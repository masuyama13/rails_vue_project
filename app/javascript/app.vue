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
        </tr>
      </thead>
      <draggable v-model="fruits" tag="tbody">
        <tr v-for="fruit in fruits">
          <td>{{ fruit.name }}</td>
          <td>{{ fruit.description }}</td>
          <td>{{ fruit.position }}</td>
          <td><a :href="`/fruits/${fruit.id}/edit`">Edit</a></td>
          <td><a>Destroy</a></td>
        </tr>
      </draggable>
    </table>
    <p>----- Vue ここまで -----</p>
  </div>
</template>

<script>
import draggable from "vuedraggable"

export default {
  data() {
    return {
      fruits: [],
      dragging: false,
    }
  },
  components: {
    draggable
  },
  created() {
    fetch('/fruits.json', {
      method: 'GET',
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
      },
      credentials: 'same-origin',
    })
    .then(response => {
      console.log(response)
      return response.json().then(json => {
        this.fruits = json
      })
    })
    .catch(error => {
      console.warn('Failed to parsing', error)
    })
  }
}
</script>

<style scoped>
p {
  text-align: center;
}
</style>
