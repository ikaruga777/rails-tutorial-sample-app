import Vue from 'vue/dist/vue';
import Hello from './Hello.vue';

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    render: (createElement) => {
      return createElement(Hello)
    }
  });
});
