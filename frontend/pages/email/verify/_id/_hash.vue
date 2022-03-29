<template>
<div class="root"></div>
</template>

<script>
export default {
  name: "EmailVerifyIdHash",
  mounted() {
    this.$axios.$get('/sanctum/csrf-cookie')
    .then(() => {
      this.$axios.$get(this.$route.fullPath)
        .then(r => {
          this.$router.push({name: 'game'})
        })
        .catch(e => console.log(e.response));
    })
  }
}
</script>

<style scoped>

</style>
