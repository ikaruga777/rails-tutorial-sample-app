<template>
  <a v-bind:href="'/users/' + user.id">
    <img v-bind:src="user.gravatar_url" v-bind:alt="user.name" class="gravatar" />
  </a>
</template>

<script>
export default {
  props: {
    user: Object
  }
};
</script>