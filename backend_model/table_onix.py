from backend_model.database import DBManager
db = DBManager.db

class TbDriverInfo(db.Model):
    __tablename__ = 'tbdriverinfo'

    idx = db.Column('idx', db.Integer, primary_key=True)
    driverName = db.Column('driverName', db.String)
    company = db.Column('company', db.String)
    workplace = db.Column('workplace', db.String)
    createdTime = db.Column('createdTime', db.DateTime)
    modifiedTime = db.Column('modifiedTime', db.DateTime)

class TbCarInfo(db.Model):
    __tablename__ = 'tbcarinfo'

    idx = db.Column('idx', db.Integer, primary_key=True)
    fkDriver = db.Column('fkDriver', db.Integer, db.ForeignKey(TbDriverInfo.idx))
    carNumber = db.Column('carNumber', db.String)
    carName = db.Column('carName', db.String)
    carType = db.Column('carType', db.String)
    deviceNumber = db.Column('deviceNumber', db.Integer)
    modifiedTime = db.Column('modifiedTime', db.DateTime)
    driverInfo = db.relationship('TbDriverInfo')

class TbEventLog(db.Model):
    __tablename__ = 'tbeventlog'

    idx = db.Column('idx', db.Integer, primary_key=True)
    fkDriver = db.Column('fkDriver', db.Integer, db.ForeignKey(TbDriverInfo.idx))
    fkCar = db.Column('fkCar', db.Integer, db.ForeignKey(TbCarInfo.idx))
    eventStartTime = db.Column('eventStartTime', db.DateTime)
    eventEndTime = db.Column('eventEndTime', db.DateTime)
    latitude = db.Column('latitude', db.Float)
    longitude = db.Column('longitude', db.Float)
    impact = db.Column('impact', db.Float)
    speed = db.Column('speed', db.Integer)
    idle = db.Column('idle', db.Integer)
    battery = db.Column('battery', db.Integer)
    temperature = db.Column('temperature', db.Float)
    humidity = db.Column('humidity', db.Float)
    createdTime = db.Column('createdTime', db.DateTime)
    driverInfo = db.relationship('TbDriverInfo')
    carInfo = db.relationship('TbCarInfo')

class BumpData(db.Model):
    __tablename__ = 'tbbumpdata'

    idx = db.Column('idx', db.Integer, primary_key=True)
    latitude = db.Column('latitude', db.Float)
    longitude = db.Column('longitude', db.Float)
    category = db.Column('category', db.String)
    height = db.Column('height', db.Float)
    width = db.Column('width', db.Float)
    extention = db.Column('extention', db.Float)
    roadCategory = db.Column('roadCategory', db.String)
    continuaous = db.Column('continuaous', db.Boolean)
    address = db.Column('address', db.String)