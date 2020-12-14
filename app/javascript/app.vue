<template>
  <div id="app">
    <p>{{ fruits }}</p>

    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Description</th>
          <th>Position</th>
          <th></th>
          <th></th>
          <th></th>
        </tr>
      </thead>
      <draggable v-model="fruits" tag="tbody" @end="dropped">
        <tr v-for="fruit in fruits">
          <td>{{ fruit.name }}</td>
          <td>{{ fruit.description }}</td>
          <td>{{ fruit.position }}</td>
        </tr>
      </draggable>
    </table>
    <p>----- Vue ここまで -----</p>
  </div>
</template>

<script>
import draggable from "vuedraggable"
import "whatwg-fetch"

export default {
  data() {
    return {
      fruits: [],
      dragging: false
    }
  },
  components: {
    draggable
  },
  created() {
    fetch(`/fruits.json`, {
      method: 'GET',
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
      },
      credentials: 'same-origin',
    })
      .then(response => {
        return response.json()
      })
      .then(json => {
        json.forEach(c => { this.fruits.push(c) });
      })
      .catch(error => {
        console.warn('Failed to parsing', error)
      })
  },
  methods: {
    token () {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    dropped() {
      this.fruits.forEach((fruit, index) => {
        fruit.position = index + 1

        // console.log('デバッグ用')
        // console.log(fruit.id)
      })
      this.fruits.forEach((fruit) => {
        let params = {
          'position': fruit.position
        }
        fetch(`/fruits/${fruit.id}.json`, {
          method: 'PATCH',
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-Token': this.token()
          },
          credentials: 'same-origin',
          redirect: 'manual',
          body: JSON.stringify(params)
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok')
          }
          return response.blob()
        })
        .catch(error => {
          console.error('Failed to parsing', error)
        })
      })
    }
  }
}
</script>

<style scoped>
p {
  text-align: center;
}
</style>
