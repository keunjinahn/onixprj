import Vue from 'vue'
import VueRouter from 'vue-router'
import * as View from '@/views'
import session from '@/plugins/session'
import { Typhoon_Manage } from "../views";

async function rootAccess(to, from, next) {
  if (!session.authentication && to.query.uid) {
    try {
      await session.loginFromProp(to.query.uid)
      next({ name: 'sensor_log_event' })
    }
    catch (e) {
      next({ name: 'sensor_log_event' })
    }
  }
  else next({ name: 'sensor_log_event' })
}

const beforeEnter = (to, from, next) => {
  if (session.authentication) next()
  else next({ name: 'login' })
}

Vue.use(VueRouter)

const routes = [{
  path: '/',
  name: 'home',
  template: '<router-view />',
  beforeEnter: rootAccess
},
{
  path: '/login',
  component: View.Login,
  children: [
    {
      path: '',
      name: 'login',
      component: View.Login_SignIn
    },
    {
      path: 'signup',
      name: 'signup',
      component: View.Login_SignUp
    },
    {
      path: 'find-password',
      name: 'find-password',
      component: View.Login_FindPassword
    }
  ]
},

/* 
  -데이터 관리
    ㄴ차량관리
    ㄴ운전자 관리
    ㄴ이벤트 관리
 */
{
  path: '/manage',
  name: 'manage',
  component: View.SubView,
  redirect: { name: 'vehicleManage' },
  beforeEnter,
  children: [
    {
      path: 'vehicleManage',
      name: 'vehicleManage',
      component: View.VehicleManage,
      meta: { breadcrumb: [{ text: '관리', disabled: true }, { text: '차량 관리', disabled: true }] },
      props: true,
      beforeEnter
    },
    {
      path: 'driverManage',
      name: 'driverManage',
      component: View.DriverManage,
      meta: { breadcrumb: [{ text: '관리', disabled: true }, { text: '운전자 관리', disabled: true }] },
      props: true,
      beforeEnter
    },
    {
      path: 'eventManage',
      name: 'eventManage',
      component: View.EventManage,
      meta: { breadcrumb: [{ text: '관리', disabled: true }, { text: '이벤트 관리', disabled: true }] },
      props: true,
      beforeEnter
    },
    
  ]
},

/* 
  -보고서 관리
    ㄴ통계 보고서
 */
{
  path: '/report',
  name: 'report',
  component: View.SubView,
  redirect: { name: 'sensor_event' },
  beforeEnter,
  children: [
    {
      path: 'sensor_event',
      name: 'sensor_event',
      component: View.SensorEvent,
      meta: { breadcrumb: [{ text: '화재감지기 상태', disabled: true }, { text: '화재감지기 상태', disabled: true }] },
      props: true,
      beforeEnter
    },
    {
      path: 'repeater_event',
      name: 'repeater_event',
      component: View.RepeaterEvent,
      meta: { breadcrumb: [{ text: '화재중계기 상태', disabled: true }, { text: '화재중계기 상태', disabled: true }] },
      props: true,
      beforeEnter
    },    
    {
      path: 'event_list',
      name: 'event_list',
      component: View.EventList,
      meta: { breadcrumb: [{ text: '모니터링', disabled: true }, { text: '이벤트 리스트', disabled: true }] },
      props: true,
      beforeEnter
    },
  ]
},

/* 
  -사용자 관리
 */
{
  path: '/user_manage',
  name: 'user_manage',
  component: View.UserManage,
  meta: { breadcrumb: [{ text: '사용자', disabled: true }, { text: '사용자 관리', disabled: true }] },
  props: true,
  beforeEnter
},

// {
//   path: '/manage',
//   name: 'manage',
//   component: View.SubView,
//   redirect: { name: 'sensor_manage' },
//   beforeEnter,
//   children: [
//     {
//       path: 'sensor_manage',
//       name: 'sensor_manage',
//       component: View.SensorManage,
//       meta: { breadcrumb: [{ text: '관리', disabled: true }, { text: '감지기 관리', disabled: true }] },
//       props: true,
//       beforeEnter
//     },
//     {
//       path: 'repeater_manage',
//       name: 'repeater_manage',
//       component: View.RepeaterManage,
//       meta: { breadcrumb: [{ text: '관리', disabled: true }, { text: '중계기 관리', disabled: true }] },
//       props: true,
//       beforeEnter
//     },
//     {
//       path: 'receiver_manage',
//       name: 'receiver_manage',
//       component: View.ReceiverManage,
//       meta: { breadcrumb: [{ text: '관리', disabled: true }, { text: '수신기 관리', disabled: true }] },
//       props: true,
//       beforeEnter
//     },
//   ]
// },
{
  path: '/sensor_analysis',
  name: 'sensor_analysis',
  component: View.SensorAnalysis,
  meta: { breadcrumb: [{ text: '데이터 분석', disabled: true }, { text: '이벤트 분석', disabled: true }] },
  props: true,
  beforeEnter
},
{
  path: '/crm_manage',
  name: 'crm_manage',
  component: View.CrmManage,
  meta: { breadcrumb: [{ text: '고객', disabled: true }, { text: '고객 관리', disabled: true }] },
  props: true,
  beforeEnter
},
{
  path: '/sensor_dashboard',
  name: 'sensor_dashboard',
  component: View.SensorDashboard,
  meta: { breadcrumb: [{ text: '대시보드', disabled: true }, { text: '대시보드', disabled: true }] },
  props: true,
  beforeEnter
},
{
  path: '/sensor_log_event',
  name: 'sensor_log_event',
  component: View.SensorLogEvent,
  meta: { breadcrumb: [{ text: '이벤트', disabled: true }, { text: '이벤트', disabled: true }] },
  props: true,
  beforeEnter
},
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router