<template>
  <form action="#" id="login" @submit.prevent="login()">
    <input type="email" v-model="email">
    <input type="password" v-model="password">
  </form>
</template>

<script>
export default {
  name: "register",
  data() {
    return {
      email: '',
      password: ''
    }
  },
  methods: {
    async login() {
      await this.$auth.loginWith('laravelSanctum', {data: {email: this.email, password: this.password}});
      await this.$router.push({name: 'user'});
    }
  }
}
</script>

<style scoped>

</style>
