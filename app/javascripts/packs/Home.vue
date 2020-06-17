<template>
  <div>
    <div v-if="isLoading">
      ろーてぃんぐちゅう
    </div>
    <div v-else>
      <div v-if="feeds.length > 0 ">
        <p v-for="feed in feeds" v-bind:key="feed.id">
          {{ feed.content }}
        </p>
      </div>
      <div v-else>
        ふぃーどがないよ
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data() {
    return {
      isLoading: true,
      feeds: []
    };
  },
  async mounted() {
    const res = await axios.get('/feeds.json');
    this.feeds = res.data;
    this.isLoading = false;
  }
}
</script>
