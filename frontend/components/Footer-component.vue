<template>
  <v-footer class="mt-3">
    &copy;&nbsp;2022 <template v-if="new Date().getFullYear() - 2022 > 0">- {{ new Date().getFullYear() }}</template>&nbsp;<nuxt-link :to="{name: 'index'}">Wonderland</nuxt-link>
  </v-footer>
</template>

<script>
export default {
  name: "Footer-component"
}
</script>

<style scoped>

</style>
