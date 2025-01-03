import Vue from 'vue';
//配置路由
import VueRouter from 'vue-router'
Vue.use(VueRouter);
//1.创建组件
import Index from '@/views/index'
import Home from '@/views/home'
import Login from '@/views/login'
import NotFound from '@/views/404'
import UpdatePassword from '@/views/update-password'
import pay from '@/views/pay'
import register from '@/views/register'
import center from '@/views/center'
    import kefangxinxi from '@/views/modules/kefangxinxi/list'
    import dingfangxinxi from '@/views/modules/dingfangxinxi/list'
    import huanfangxinxi from '@/views/modules/huanfangxinxi/list'
    import tuifangxinxi from '@/views/modules/tuifangxinxi/list'
    import yonghu from '@/views/modules/yonghu/list'
    import xufangxinxi from '@/views/modules/xufangxinxi/list'
    import feiyongxinxi from '@/views/modules/feiyongxinxi/list'
    import xiaoshouqingkuang from "@/views/modules/xiaoshouqingkuang/list";


//2.配置路由   注意：名字
const routes = [{
    path: '/index',
    name: '首页',
    component: Index,
    children: [{
      // 这里不设置值，是把main作为默认页面
      path: '/',
      name: '首页',
      component: Home,
      meta: {icon:'', title:'center'}
    }, {
      path: '/updatePassword',
      name: '修改密码',
      component: UpdatePassword,
      meta: {icon:'', title:'updatePassword'}
    }, {
      path: '/pay',
      name: '支付',
      component: pay,
      meta: {icon:'', title:'pay'}
    }, {
      path: '/center',
      name: '个人信息',
      component: center,
      meta: {icon:'', title:'center'}
    }
      ,{
	path: '/kefangxinxi',
        name: '客房信息',
        component: kefangxinxi
      }
      ,{
	path: '/dingfangxinxi',
        name: '订房信息',
        component: dingfangxinxi
      }
      ,{
	path: '/huanfangxinxi',
        name: '换房信息',
        component: huanfangxinxi
      }
      ,{
	path: '/tuifangxinxi',
        name: '退房信息',
        component: tuifangxinxi
      }
      ,{
	path: '/yonghu',
        name: '用户',
        component: yonghu
      }
      ,{
	path: '/xufangxinxi',
        name: '续房信息',
        component: xufangxinxi
      }
      ,{
	path: '/feiyongxinxi',
        name: '费用信息',
        component: feiyongxinxi
      }
      ,{
  path: "/xiaoshouqingkuang",
        name: "销售情况",
        component: xiaoshouqingkuang
      }
    ]
  },
  {
    path: '/login',
    name: 'login',
    component: Login,
    meta: {icon:'', title:'login'}
  },
  {
    path: '/register',
    name: 'register',
    component: register,
    meta: {icon:'', title:'register'}
  },
  {
    path: '/',
    name: '首页',
    redirect: '/index'
  }, /*默认跳转路由*/
  {
    path: '*',
    component: NotFound
  }
]
//3.实例化VueRouter  注意：名字
const router = new VueRouter({
  mode: 'hash',
  /*hash模式改为history*/
  routes // （缩写）相当于 routes: routes
})

export default router;
