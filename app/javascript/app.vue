<template>
  <div id="app">
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Description</th>
          <th></th>
          <th></th>
        </tr>
      </thead>
      <draggable v-model="fruits" tag="tbody" @start="start" @end="dropped">
        <tr v-for="fruit in fruits" :key="fruit.id" @dragstart="dragstart(fruit)">
          <td>{{ fruit.name }}</td>
          <td>{{ fruit.description }}</td>
          <td><a :href="`/fruits/${fruit.id}/edit`">Edit</a></td>
          <td><a @click="destroyFruit(fruit)">Destroy</a></td>
        </tr>
      </draggable>
    </table>
    <p>----- Vue ここまで -----</p>
  </div>
</template>

<script>
import draggable from "vuedraggable"

export default {
  props: ['fruitsData'],
  data () {
    return {
      fruits: JSON.parse(this.fruitsData),
      beforeDragging: '',
      draggingItem: '',
      oldPosition: null
    }
  },
  components: {
    draggable
  },
  methods: {
    token () {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    start () {
      this.beforeDragging = this.fruits
    },
    dragstart (fruit) {
      this.draggingItem = fruit
      const target = this.fruits.find((v) => v.id === this.draggingItem.id)
      this.oldPosition = this.fruits.indexOf(target) + 1
    },
    dropped () {
      const targetId = this.draggingItem.id
      const targetItem = this.fruits.find((v) => v.id === targetId)
      const newPosition = this.fruits.indexOf(targetItem) + 1
      if (this.oldPosition !== newPosition) {
        const params = {
          'position': newPosition
        }
        fetch(`/api/fruits/${targetId}.json`, {
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
            if (response.ok) {
              return response.json()
            } else {
              this.fruits = this.beforeDragging
            }
          })
          .catch(error => {
            console.error('Failed to parsing', error)
          })
      }
    },
    destroyFruit (fruit) {
      if (window.confirm('削除してよろしいですか？')) {
        fetch(`/api/fruits/${fruit.id}.json`, {
          method: 'DELETE',
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-Token': this.token()
          },
          credentials: 'same-origin',
          redirect: 'manual',
        })
          .then(response => {
            if (response.ok) {
              this.fruits = this.fruits.filter(v => v.id !== fruit.id)
            }
          })
          .catch(error => {
            console.error('There has been a problem with your fetch operation:', error)
          })
      }
    }
  }
}
</script>

<style scoped>
p {
  text-align: center;
}
</style>
