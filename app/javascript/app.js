import Vue from 'vue'
import App from './app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = document.getElementById('js-index')
  if (app) {
    const fruitsData = app.getAttribute('data-fruits')
    new Vue({
      render: h => h(App, { props: {
        fruitsData: fruitsData
        }
      })
    }).$mount('#js-index')
  }
})
