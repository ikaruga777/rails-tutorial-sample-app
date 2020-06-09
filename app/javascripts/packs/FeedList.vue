<template>
  <div>
    <p v-for="feed in feeds" v-bind:key="feed.id">
      <FeedItem v-bind:feed="feed" />
    </p>
  </div>
</template>

<script>
import FeedItem from './FeedItem.vue'

export default {
  components: {
    FeedItem
  },
  props: {
    feeds: Array
  }
}
</script>