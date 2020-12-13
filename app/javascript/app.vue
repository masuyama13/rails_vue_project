<template>
  <div id="app">
    <p>{{ message }}</p>

    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Description</th>
          <th></th>
          <th></th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="fruit in fruits">
          <td>{{ fruit.name }}</td>
          <td>{{ fruit.description }}</td>
        </tr>
      </tbody>
    </table>
    <p>----- Vue ここまで -----</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      message: "Hello Vue!",
      fruits: []
    }
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
  }
}
</script>

<style scoped>
p {
  text-align: center;
}
</style>
