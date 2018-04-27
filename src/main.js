import Vue from 'vue'
import Vuetify from 'vuetify'
import App from './App'
import Web3 from 'web3'
import router from './router'
import { store } from './store'

import('vuetify/dist/vuetify.min.css')
import 'material-design-icons-iconfont/dist/material-design-icons.css'

Vue.use(Vuetify)

Vue.config.productionTip = false

  new Vue({
    el: '#app',
    router,
    store,
    template: '<App/>',
    components: { App }
  })

