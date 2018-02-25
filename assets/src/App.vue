<template>
  <div id="app">
    <h1>{{ header }}</h1>
    <p>User: {{ user.name }}</p>

    <form method="POST" action="/data">
      <textarea rows="6" cols="60" v-model="config" name="config"></textarea>
      <br/>
      <input type="submit" value="Download CSV" />
    </form>
  </div>
</template>

<script>
import gql from 'graphql-tag'
export default {
  name: 'app',
  data () {
    return {
      header: 'Magento CSV generator',
      config: '{\n"columns": ["model","style","price"],\n"values":{\n  "model": ["Alpha","Beta","Gamma"],\n  "style": ["simple","advanced"]\n}\n}',
      user: ''
    }
  },
  methods: {
  },
  apollo: {
    // Apollo will assign the result of that query to the 'user' key in data.
    user: gql`{
      user(id: "1"){
        name
      }
    }`,
  }
}
</script>

<style lang="scss">
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
