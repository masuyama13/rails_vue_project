<template>
  <div id="app">
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Description</th>
          <th></th>
          <th></th>
          <th>並び替え</th>
        </tr>
      </thead>
      <draggable v-model="fruits" handle=".handle" tag="tbody" @start="start" @end="dropped">
        <tr v-for="fruit in fruits" :key="fruit.id">
          <td>{{ fruit.name }}</td>
          <td>{{ fruit.description }}</td>
          <td><a :href="`/fruits/${fruit.id}/edit`">Edit</a></td>
          <td><a @click="destroyFruit(fruit)">Destroy</a></td>
          <td class="center"><span class="handle">::</span></td>
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
      draggingItem: ''
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
    dropped (e) {
      this.draggingItem = this.beforeDragging[e.oldIndex]
      if (e.oldIndex !== e.newIndex) {
        const params = {
          // position値は1から始まるので、インデックス番号+1
          position: e.newIndex + 1
        }
        fetch(`/api/fruits/${this.draggingItem.id}/position.json`, {
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
p, .center {
  text-align: center;
}
.handle {
  cursor: grab;
}
</style>
