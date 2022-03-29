<template>
  <v-container fluid>
    <chat-component/>
  </v-container>
</template>

<script>
import chatComponent from "~/components/chat-component";

export default {
  name: "index",
  components: {chatComponent}
}
</script>

<style scoped>

</style>
