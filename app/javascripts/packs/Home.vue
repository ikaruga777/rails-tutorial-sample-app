<template>
  <div>
    <div v-if="isLoading">
    </div>
    <div v-else>
      <div v-if="feeds.length > 0">
          <p v-for="feed in feeds" v-bind:key="feed.id">
            {{ feed.content }}
          </p>
        </div>
        <div v-else>
          ないぜ
        </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
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
