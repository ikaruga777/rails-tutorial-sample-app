import 'core-js/stable';
import 'regenerator-runtime/runtime';
import Vue from 'vue/dist/vue';
import Home from './Home.vue';

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el:
    '#app',
    render: (createElement) => {
      return createElement(Home)
    }
  });
});
