<template>
  <div>
    <div v-if="feeds.length > 0">
      <p v-for "feed in feeds" v-bind:key="feed.id">
        あるぜ
        {{ feed.content }}
      </p>
    </div>
    <div v-else>
      ないぜ
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      feeds: []
    };
  },
  async mounted() {
    const response = await axios.get('/feeds.json');
    this.feeds = response.data;
  }
};
</script>
