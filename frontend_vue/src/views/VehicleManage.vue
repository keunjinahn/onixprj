<template>
  <main-layout>
    <template v-slot>
      <div class="main-panel">
        <v-toolbar color="light-blue darken-4" dark flat>
          <v-toolbar-title>차량 관리</v-toolbar-title>
        </v-toolbar>

        <v-card flat height="100">
          <v-toolbar rounded dense class="elevation-1" height="100">
            <v-col cols="8">
              <v-text-field outlined dense hide-details
                            placeholder="이름, 차량번호, 단말기번호를 입력하세요"
                            append-icon="mdi-magnify"
                            v-model="sensor.search"
                            @keydown.enter="getCarInfo()"
                            class="m-right"
              />
            </v-col>
            <v-col cols="1">
              <v-btn depressed dark big
                      color="light-blue darken-2"
                      @click="getCarInfo()">
                <div class="ml-1">조회</div>
              </v-btn>
            </v-col>
            <v-col cols="1">
              <v-btn depressed dark big
                      color="light-blue darken-2"
                      class="m-left"
                      @click="uploadExcel()">
                <v-icon>mdi-folder-upload</v-icon>
                <div class="ml-1">폴더 업로드</div>
              </v-btn>
            </v-col>
          </v-toolbar>
        </v-card>

        <v-data-table
          :headers="sensor.headers"
          :items="sensor.data"
          :loading="sensor.loading"
          :options.sync="sensor.options"
          :server-items-length="sensor.total"
          :search="sensor.search"
          :items-per-page="5"
          :footer-props="{'items-per-page-options': [10, 20, 30, 40, -1]}"
          class="elevation-1 mt-4">
          <template v-slot:item="row">
            <!-- <tr @click="onSensorItemClick(row.item,row)" :class="{'row-active': row.item.id == sensor.selectedId}"> -->
            <tr>
              <td >{{ row.item._index }}</td>
              <td style="text-align: left" >{{ row.item.carNumber}}</td>
            </tr>
          </template>
        </v-data-table>

        
      </div>
    </template>
  </main-layout> 
</template>

<script>
import axios from "axios";
import { eq } from 'lodash';
import moment from 'moment'
export default {
  props: {
  },
  components: {},
  methods: {
    /* 차량정보 조회 */
    async getCarInfo() {
      const { page, itemsPerPage, sortBy, sortDesc } = this.sensor.options;
      try {
        let filters_or = []
        let filters_and = []
        // let order_by = []
        if (this.sensor.search) {
          filters_or.push({name: "carNumber", op: "like", val: `%${this.sensor.search}%`});
        }
        // if (sortBy.length) {
        //   for (let i=0; i<sortBy.length; i++) {
        //     order_by.push({field: sortBy[i], direction: sortDesc[i] ? 'desc' : 'asc'})
        //   }
        // }else{
        //   order_by.push({field: "carNumber", direction: 'desc'})
        // }

        let q = {
          filters: [{or: filters_or}, {and: filters_and}],
          // order_by
        }
        let params = {
          q: q,
          results_per_page: itemsPerPage,
          page: page,

        };

        let { data } = await this.$http.get("car-list", { params });
        this.sensor.total = data.num_results;
        this.sensor.data = data.objects.map((v, i) => {
          v._index = i + (page - 1) * itemsPerPage + 1;
          return v;
        });
      } catch (err) {
        console.error(err);
      } finally {
        this.sensor.loading = false;
      }   
    },

    async onSensorItemClick(item){
      if(item == null) return

      this.sensor.selectedId = item.id
      const { page, itemsPerPage, sortBy, sortDesc } = this.event.options;
      try {
        let filters_or = []
        let filters_and = []
        let order_by = []
        filters_and.push({name: 'fk_customer_idx', op: 'eq', val: item.fk_customer_idx})
        filters_and.push({name: 'receiver_id', op: 'eq', val: item.receiver.receiver_id})
        filters_and.push({name: 'repeater_id', op: 'eq', val: item.repeater.repeater_id})        
        filters_and.push({name: 'sensor_id', op: 'eq', val: item.sensor_id})
        order_by.push({field: "event_log_idx", direction: 'desc'})
        let q = {
          filters: [{or: filters_or}, {and: filters_and}],
          order_by
        }
        let params = {
          q: q,
          results_per_page: itemsPerPage,
          page: page,

        };
        let { data } = await this.$http.get("event_log_list", { params });
        this.event.total = data.num_results;
        this.event.data = data.objects.map((v, i) => {
          v._index = i + (page - 1) * itemsPerPage + 1;
          return v;
        });
        this.selected_sensor = item
      } catch (err) {
        console.error(err);
      } finally {
        this.event.loading = false;
      }        
    },
    async uploadExcel() {
      let params = {
        "page_name": "sensor_event",
        "headers": (() => {
          let headers_text = []
          for (let i=1; i < this.sensor.headers.length-1; i++) {
            headers_text.push(this.sensor.headers[i].text)
          }
          return headers_text
        })()
      }
      let {data} = await this.$http.post('make_excel', params)

      var url = this.$session.getWebURL() + '/api/v1/save_excel/' + data.filename
      axios({
        method: 'get',
        url:url,
        responseType: 'blob'
      })
      .then(response => {
        const url = window.URL.createObjectURL(new Blob([response.data], {
          type: 'application/vnd.ms-excel'
        }))
        const link = document.createElement('a')
        link.href = url
        var download_file_name = "감지기상태_" + Date.now().toString() + ".xlsx"
        link.setAttribute('download', download_file_name)
        link.click()
      })
      .catch(() => console.log('error: excel download error'))
    },
  },
  mounted() {
    this.getCarInfo()
  },
  watch: {
    "sensor.options": {
      handler() {
        this.getCarInfo()
      },
      deep: true,
    },
    "event.options": {
      handler() {
        this.onSensorItemClick(this.selected_sensor)
      },
      deep: true,
    },    
  },
  data() {
    return {
      sensor: {
        selectedId: '',
        headers: [
          {text: 'No.', value: 'id', sortable: false, align: 'center', width: 20 },
          {text: "차량 번호", value: "carNumber", sortable: false, align: 'left', width: 400}, 
        ],
        data: [],
        options: {"page":1,"itemsPerPage":10,"sortBy":[],"sortDesc":[],"groupBy":[],"groupDesc":[],"mustSort":false,"multiSort":false},
        loading: false,
        search: '',
        total:0
      },
      event: {
        headers: [
          {text: 'No.', value: 'id', sortable: false, align: 'center', width: 20 },
          {text: "이벤트 시간", value: "event_datetime", sortable: false,align: 'center', width: 80}, 
          {text: "이벤트 No.", value: "event_id", sortable: false,align: 'center', width: 80}, 
          {text: "감지기 현재값", value: "sensor_value",align: 'center', sortable: false, width: 60},
          {text: "이벤트 내용", value: "event_desc",align: 'center', sortable: false, width: 150},
          {text: "입출력단 번호", value: "inout_id",align: 'center', sortable: false, width: 40},          
        ],
        data: [],
        options: {"page":1,"itemsPerPage":5,"sortBy":[],"sortDesc":[],"groupBy":[],"groupDesc":[],"mustSort":false,"multiSort":false},
        loading: false,
        search: '',
        total:0
      },
      addPopup: {
        show: false,
        loading:false,
        popup_type: 'ADD',
      },      
      loading: false,
      selected_sensor:null
    };
  },
};
</script>

<style lang="scss" scoped>
.main-panel {
  padding: 10px;
  height: calc(100vh - 80px);
  overflow-y: auto;
}
.main-panel .v-data-table header {
  font-size: 14px;
}
.main-panel .v-data-table th {
  font-size: 14px;
}
.main-panel .v-data-table td {
  font-size: 14px;
}
td {
  text-align: center;
}
.main-panel .v-data-table{
  cursor:pointer
}
.flex-grow-1{
  margin-left:10px;
  margin-bottom: 10px;
  width:48%;
}
</style>
