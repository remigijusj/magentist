<template>
  <div id="app">
    <b-navbar type="dark" variant="info" class="text-right">
      <b-nav>
        <b-nav-item href="#">{{ user.name }}</b-nav-item>
      </b-nav>
    </b-navbar>

    <b-container>
      <b-row>
        <b-col class="text-center">
          <h1>CSV generator</h1>
        </b-col>
      </b-row>

      <b-row>
        <b-col sm="5">
          <b-form-group v-for="(col, idx) in columns">
            <b-form-input v-model="col.name" @focus.native="selectColumn(idx)"></b-form-input>
          </b-form-group>
          <b-form-group>
            <b-button v-on:click="addColumn">Add column</b-button>
            <b-button v-on:click="removeColumn">Remove last</b-button>
          </b-form-group>
        </b-col>
        <b-col sm="2"></b-col>
        <b-col sm="5">
          <b-form-group v-for="val in values">
            <b-form-input v-model="val.value"></b-form-input>
          </b-form-group>
          <b-form-group>
            <b-button v-on:click="addValue">Add value</b-button>
            <b-button v-on:click="removeValue">Remove last</b-button>
            <b-button v-on:click="setValues">Save</b-button>
          </b-form-group>
        </b-col>
      </b-row>

      <b-form-group class="text-center">
        <form method="POST" action="/data" class="text-center">
          <input type="hidden" name="config" v-model="config" />
          <b-button type="submit" variant="primary">Download CSV</b-button>
          <b-btn v-b-toggle.config-area>Configuration</b-btn>
        </form>
        <b-collapse id="config-area">
          <b-form-textarea v-model="config"></b-form-textarea>
        </b-collapse>
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
      columns: [
        { name: "model", values: ["Alpha", "Beta", "Gamma"] },
        { name: "style", values: ["simple", "advanced"] },
        { name: "price", values: [""] }
      ],
      colId: null,
      values: [{ value: '' }],
      user: ''
    }
  },
  computed: {
    config: {
      get: function() {
        return JSON.stringify({columns: this.columns}, null, 2)
      },
      set: function(json) {
        var data = JSON.parse(json)
        this.columns = data.columns
      }
    }
  },
  methods: {
    selectColumn: function(i) {
      this.colId = i
      this.values = this.columns[i].values.map(function(value) {return {value: value}})
    },
    addColumn: function() {
      this.columns.push({ name: "", values: [""] })
    },
    removeColumn: function() {
      if (this.columns.length > 1) this.columns.splice(-1,1)
    },
    addValue: function() {
      this.values.push({ value: "" })
    },
    removeValue: function() {
      if (this.values.length > 1) this.values.splice(-1,1)
    },
    setValues: function() {
      this.columns[this.colId].values = this.values.map(function(value) {return value.value})
    }
  },
  apollo: {
    user: gql`{
      user(id: "1"){
        name
      }
    }`,
  }
}
</script>

<style lang="scss">
body, ul {
  margin-top: 0;
}
h1 {
  margin-bottom: 20px;
}
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
}
#config-area {
  font-family: 'Console', monospace;
}
</style>
