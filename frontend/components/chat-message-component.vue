<template>
  <p>
    <span class="time">{{ time }}</span>&nbsp;<span class="user-name">{{ userName }}</span>&nbsp;{{ message }}
  </p>
</template>

<script>
import Vue from 'vue';

export default Vue.extend({
  name: "chat-message-component",
  props: {
    time: {
      type: String,
      required: true
    },
    userName: {
      type: String,
      required: true
    },
    message: {
      type: String,
      required: true
    }
  }
})
</script>

<style scoped>

</style>
