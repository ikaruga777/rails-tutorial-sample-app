import 'core-js/stable';
import 'regenerator-runtime/runtime';
import Vue from 'vue/dist/vue';
import Home from './Home.vue';

document.addEventListener('DOMContentLoaded', () => {
  new Vew({
    el: 
    '#app',
    render: (createElement) => {
      return createElemnt(Home)
    }
  });
});
