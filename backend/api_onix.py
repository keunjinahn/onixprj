print ("module [backend.api_onix] loaded")

import hashlib
from flask import make_response, jsonify, request, json, send_from_directory, g
from flask_restless import ProcessingException
from flask_restful import reqparse
from datetime import datetime, timedelta
import os
import json
from functools import wraps
import pandas as pd
from zipfile import BadZipFile

from backend import app, login_manager
from backend_model.table_fireprj import *
from backend_model.table_onix import *
from backend import manager
db = DBManager.db


def check_columns(df, driver_id, car_id):
    # DataFrame 객체를 데이터베이스의 구성과 같게 재구성
    # 컬럼이 존재하지 않으면 None으로 채운다.
    # 데이터베이스에 존재하지 않는 컬럼이 있으면 버린다.
    # 순서가 바뀌어 있다면 복원한다.
    # *** '컬럼명' 기준으로 검사함 ***
    columns = list(df.columns)
    valid = ['GPS수집시간', '위도', '경도', '충격', '속도', '공회전', '배터리', '온도', '습도']
    check_map = [columns.index(v) if v in columns else -1 for v in valid]

    result = pd.DataFrame()
    for i, v in enumerate(valid):
        result[valid[i]] = df.iloc[:, check_map[i]] if v != -1 else None

    # eventEndTime과 CreatedTime을 생성한다.
    result['GPS수집시간'] = pd.to_datetime(result['GPS수집시간'])
    result.insert(1, 'eventEndTime', result['GPS수집시간'] + timedelta(seconds=10))
    result['CreatedTime'] = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # db와 컬럼명 일치하도록 변경
    db_cols = ['eventStartTime', 'eventEndTime', 'latitude', 'longitude', 'impact'
                , 'speed', 'idle',  'battery', 'temperature', 'humidity', 'createdTime']
    result.columns = db_cols

    # fk생성
    result.insert(1, 'fkDriver', driver_id)
    result.insert(2, 'fkCar', car_id)
    return result

def get_fk_infos(car_number):
    data = TbCarInfo.query.filter(TbCarInfo.carNumber==car_number).first()
    default_driver = 1

    # 해당 차량이 존재하면
    if data != None:
        return data.fkDriver, data.idx
    else:
        # 없을 경우 -> 삽입
        obj = TbCarInfo()
        obj.carNumber = car_number
        obj.fkDriver = default_driver
        obj.modifiedTime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        db.session.add(obj)
        db.session.commit()

        data = TbCarInfo.query.filter(TbCarInfo.carNumber==car_number).first()
        return data.fkDriver, data.idx

@app.route('/api/v1/excel-upload', methods=['POST'])
def except_event_xl():
    # 파일 줄 때 한 개의 리스트에 전부 담아서 줘야 함
    if 'files' not in request.files:
        return jsonify({"error":"No files part"}, 400)
    
    files = request.files.getlist('files')
    data_count = 0
    except_count = 0
    for file in files:
        filename = file.filename.split('/')[1]
        car_number = filename.split('_')[0]
        driver_id, car_id  = get_fk_infos(car_number)
        try:
            df = pd.read_excel(file, engine='openpyxl')
        except BadZipFile as e:
            print(f"Failed to read '{filename}': {e}")
            except_count += 1
            continue
        df = check_columns(df, driver_id, car_id)
        data_count += len(df)
        df.to_sql('tbeventlog', con=db.engine, if_exists='append', index=False)

    result = {
        "file_count": len(files) - except_count,
        "data_count": data_count
    }
    print(result)

    return make_response(jsonify(result), 200)

# @app.route('/upload-bump', methods=['GET'])
# def upload_bump():
#     path = os.getcwd() + '\\data\\all_bumps.csv'
#     df = pd.read_csv(path)
#     df['latitude'] = pd.to_numeric(df['latitude'], errors='coerce')
#     df['longitude'] = pd.to_numeric(df['longitude'], errors='coerce')
#     df.to_sql('tbbumpdata', con=db.engine, if_exists='append', index=False)

#     result = {
        
#     }
#     return make_response(jsonify(result), 200)

manager.create_api(TbCarInfo
                   , results_per_page=10000
                   , url_prefix='/api/v1'
                   , collection_name='car-list'
                   , methods=['GET', 'DELETE', 'PATCH', 'POST']
                   , allow_patch_many=True)

manager.create_api(TbDriverInfo
                   , results_per_page=10000
                   , url_prefix='/api/v1'
                   , collection_name='driver-list'
                   , methods=['GET', 'DELETE', 'PATCH', 'POST']
                   , allow_patch_many=True)

manager.create_api(TbEventLog
                   , results_per_page=10000
                   , url_prefix='/api/v1'
                   , collection_name='event-logs'
                   , methods=['GET', 'DELETE', 'PATCH', 'POST']
                   , allow_patch_many=True)