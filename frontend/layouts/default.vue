<template>
  <v-app>
    <v-container class="page d-flex flex-column justify-space-between pt-0 pb-0">
      <HeaderComponent class="flex-grow-0 flex-shrink-0"/>
      <Nuxt class="flex-grow-1"/>
      <FooterComponent class="flex-grow-0 flex-shrink-0"/>
    </v-container>
  </v-app>
</template>

<script>
import HeaderComponent from "@/components/header-component";
import FooterComponent from "@/components/Footer-component";

export default {
  name: "default",
  components: {
    HeaderComponent, FooterComponent
  }
}
</script>

<style scoped>
.page {
  min-height: 100vh;
}
</style>
