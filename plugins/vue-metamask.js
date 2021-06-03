import Vue from 'vue'
import VueMetamask from 'vue-metamask'

if (process.client) {
  Vue.use(VueMetamask)
}
