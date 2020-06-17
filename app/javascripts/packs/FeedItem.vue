<template>
  <div>
      {{ feed.content }}
      <GravatarImage v-bind:user="feed.user" />
  </div>
</template>

<script>
import GravatarImage from './GravatarImage.vue'

export default {
  components: {
    GravatarImage
  },
  props: {
    feed: Object
  }
}
</script>