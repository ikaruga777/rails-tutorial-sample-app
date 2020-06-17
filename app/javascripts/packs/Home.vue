<template>
  <div>
    <div v-if="isLoading">
    </div>
    <div v-else>
      <div v-if="feeds.length > 0">
        <FeedList v-bind:feeds="feeds" />
      </div>
      <div v-else>
        ないぜ
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

import FeedList from './FeedList.vue'
export default {
  components: {
    FeedList
  },
  data() {
    return {
      feeds: [],
      isLoading: true
    };
  },
  async mounted() {
    const response = await axios.get('/feeds.json');
    this.feeds = response.data;
    this.isLoading = false
  }
};
</script>
