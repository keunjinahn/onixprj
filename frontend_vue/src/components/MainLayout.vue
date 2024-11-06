<template>
  <div class="w-100">
    <v-app-bar app clipped-left dense class="top-menu" color="white" elevation="1">
      <router-link :to="{name: 'sensor_log_event'}" class="d-flex align-center">
        <img src="@/assets/logo-black.png" height="40" />
      </router-link>
      <div class="ml-auto d-flex align-center">
        <v-divider vertical/>
        <v-btn icon small color="deep-orange accent-2" class="ml-4" @click="logout_dialog.show=true">
          <v-icon>mdi-power</v-icon>
        </v-btn>
      </div>
    </v-app-bar>

    <v-navigation-drawer app clipped absolute permanent color="white" :mini-variant="mini">
      <div class="mt-2 px-4 d-flex justify-space-between align-center">
        <template v-if="mini">
          <v-icon @click="mini = false">mdi-chevron-double-right</v-icon>
        </template>
        <template v-else>
          <div width="100"></div>
          <v-btn class="expandMenu" icon @click="mini = true">
            <v-icon>mdi-chevron-double-left</v-icon>
          </v-btn>
        </template>
      </div>
      
      <!-- 대시보드 -->
      <v-list-item v-once :to="{name: navLinks[0].subLinks[0].route}" color="primary">
        <v-list-item-avatar>
          <v-icon>{{ navLinks[0].icon }}</v-icon>
        </v-list-item-avatar>
        <v-list-item-content>
          <v-list-item-title>{{ navLinks[0].text }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <!-- 데이터 관리 -->
      <v-list-item v-once :to="{name: navLinks[1].subLinks[0].route}" color="primary">
        <v-list-item-avatar>
          <v-icon>{{ navLinks[1].icon }}</v-icon>
        </v-list-item-avatar>
        <v-list-item-content>
          <v-list-item-title>{{ navLinks[1].text }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <div class="subMenuWrapper">
        <v-list class="py-0 subMenu" :class="{subMenuOpen: $route.path.startsWith('/manage')}">
          <v-list-item dense :to="{name: navLinks[1].subLinks[0].route}" color="primary lighten-2">
            <v-list-item-content>
              <v-list-item-title class="pl-14">{{ navLinks[1].subLinks[0].text }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          <v-list-item dense :to="{name: navLinks[1].subLinks[1].route}" color="primary lighten-2">
            <v-list-item-content>
              <v-list-item-title class="pl-14">{{ navLinks[1].subLinks[1].text }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          <v-list-item dense :to="{name: navLinks[1].subLinks[2].route}" color="primary lighten-2">
            <v-list-item-content>
              <v-list-item-title class="pl-14">{{ navLinks[1].subLinks[2].text }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>            
        </v-list>
      </div>


            
      <!-- 보고서 관리 -->
      <v-list class="py-0">
        <v-list-item v-once :to="{name: navLinks[2].subLinks[0].route}" color="primary">
          <v-list-item-avatar>
            <v-icon>{{ navLinks[2].icon }}</v-icon>
          </v-list-item-avatar>
          <v-list-item-content>
            <v-list-item-title>{{ navLinks[2].text }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <div class="subMenuWrapper">
          <v-list class="py-0 subMenu" :class="{subMenuOpen: $route.path.startsWith('/report')}">
            <v-list-item dense :to="{name: navLinks[2].subLinks[0].route}" color="primary lighten-2">
              <v-list-item-content>
                <v-list-item-title class="pl-14">{{ navLinks[2].subLinks[0].text }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </div>

        <!-- 사용자 관리 -->
        <v-list-item v-once :to="{name: navLinks[3].subLinks[0].route}" color="primary">
          <v-list-item-avatar>
            <v-icon>{{ navLinks[3].icon }}</v-icon>
          </v-list-item-avatar>
          <v-list-item-content>
            <v-list-item-title>{{ navLinks[3].text }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
      
    </v-navigation-drawer>

    <v-main class="page-container">
      <slot></slot>
    </v-main>

    <v-dialog v-model="logout_dialog.show" max-width="500px">
      <v-card>
        <v-card-title>로그아웃 하시겠습니까?</v-card-title>
        <v-card-actions>
          <v-btn tile depressed class="flex-grow-1" @click="$session.logout();">로그아웃</v-btn>
          <v-btn tile depressed class="flex-grow-1" @click="logout_dialog.show = false">취소</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

  </div>
</template>

<script>
import axios from "axios";
export default {
  components: {},
  props: {
    source: String,
  },
  methods:{
  },
  computed: {
  },
  mounted () {
  },
  data: () => ({
    mini: false,
    worktime: '00:00',
    refreshKey: Date.now(),
    navLinks: [
      {
        icon: "mdi-chart-areaspline-variant",
        text: "대시보드",
        subLinks: [
          { text: "대시보드", route: "sensor_analysis"},
        ]
      },
      {
        icon: "mdi-radio-tower",
        text: "데이터 관리",
        subLinks: [
          { text: "차량 관리", route: "vehicleManage"},
          { text: "운전자 관리", route: "driverManage"},
          { text: "이벤트 관리", route: "eventManage"},
        ]
      },
      {
        icon: "mdi-sitemap",
        text: "보고서 관리",
        subLinks: [
          { text: "통계 보고서", route: "sensor_event"},
        ]
      },
      {
        icon: "mdi-account-plus",
        text: "사용자 관리",
        subLinks: [
          { text: "사용자 관리", route: "user_manage"},
        ]
      },

    ],
    logout_dialog: {
      show: false,
    },
  }),
};
</script>

<style lang="scss">
.top-menu {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 100;
}
.page-container {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 1;
  background-color:#dadada;
  // background-color: #3d5f70;
  // background-image: url(../assets/bg/bg-1.jpg);
  // background-size: cover;
}

.subMenuWrapper {
  position: relative;
  overflow-x: hidden;
}
.subMenu {
  margin-top: -320px;
  transition: margin-top 0.25s;
}
.subMenu.subMenuOpen { margin-top: 0; }
</style>