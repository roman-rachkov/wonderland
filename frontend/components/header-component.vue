<template>
  <v-app-bar class="mb-3 sticky">
    <nuxt-link :to="{name: 'index'}" class="logo">
      <v-toolbar-title>Wonderland</v-toolbar-title>
    </nuxt-link>
    <v-spacer/>
    <user-info-component/>
  </v-app-bar>
</template>

<script>
import userInfoComponent from "@/components/user-info-component";

export default {
  name: "HeaderComponent",
  components: {
    userInfoComponent
  }
}
</script>

<style scoped>

.logo{
  text-decoration: none;
  text-transform: uppercase;
  color: black;
}
.sticky{
  top: 0;
  position: sticky;
  z-index: 1500000;
}
</style>
