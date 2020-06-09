<template>
  <div>
    <p v-for="feed in feeds" v-bind:key="feed.id">
      {{ feed.content }}
      <GravatarImage v-bind:user="feed.user" />
    </p>
  </div>
</template>

<script>
import GravatarImage from './GravatarImage.vue'

export default {
  components: {
    GravatarImage
  },
  props: {
    feeds: Array
  }
}
</script>