import Vue from 'vue'
import App from './app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = document.getElementById('js-index')
  if (app) {
    new Vue({
      render: h => h(App)
    }).$mount('#js-index')
  }
})
