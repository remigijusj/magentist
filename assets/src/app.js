import Vue from 'vue'
import { ApolloClient } from 'apollo-client'
import { HttpLink } from 'apollo-link-http'
import { InMemoryCache } from 'apollo-cache-inmemory'
import VueApollo from 'vue-apollo'
import BootstrapVue from 'bootstrap-vue'
import App from './App.vue' // Top-level container for our app. 

// Create the link the Apollo Client will manage between our frontend client and GraphQL server. 
// Note that this is setup for development/demo - deployment will require your real URL.
const httpLink = new HttpLink({
  // You should use an absolute URL.
  uri: 'http://localhost:4000/graphql',
})

// Create the apollo client, with the Apollo caching. 
const apolloClient = new ApolloClient({
  link: httpLink,
  cache: new InMemoryCache(),
  connectToDevTools: true,
})

// Install the vue plugin for VueApollo
Vue.use(VueApollo)
Vue.use(BootstrapVue)

const apolloProvider = new VueApollo({
  defaultClient: apolloClient,
})

// Bootstrap the new Vue app. It grabs onto the div with id="app" that we created in the Phoenix HTML.
// We pass the apolloProvider instance to it, so our components can all use the same connection.
const app = new Vue({
  el: '#app',
  provide: apolloProvider.provide(),
  render: h => h(App)
})
