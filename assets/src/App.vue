<template>
  <div id="app">
    <b-container class="text-center">
      <b-jumbotron header="CSV generator" v-bind:lead="user.name"></b-jumbotron>

      <form method="POST" action="/data">
        <input type="hidden" name="config" v-model="config" />
        <b-button type="submit" variant="primary">Download CSV</b-button>
      </form>

      <b-form-group>
        <b-form-checkbox v-model="debug">Show config</b-form-checkbox>
        <b-form-textarea v-model="config" v-if="debug" id="config-area"></b-form-textarea>
      </b-form-group>
    </b-container>
  </div>
</template>

<script>
import gql from 'graphql-tag'
export default {
  name: 'app',
  data () {
    return {
      config: '{\n"columns": ["model","style","price"],\n"values": {\n  "model": ["Alpha","Beta","Gamma"],\n  "style": ["simple","advanced"]}\n}',
      user: '',
      debug: false
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
}
#config-area {
  font-family: 'Console', monospace;
}
</style>
