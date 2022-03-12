<template>
  <div>
    <form @submit.prevent="login">
      <input type="email" name="email" v-model="email" placeholder="E-mail">
      <input type="password" name="password" v-model="password" placeholder="Password">
      <button type="submit">Send</button>
    </form>
  </div>
</template>

<script>
export default {
  name: 'IndexPage',
  data() {
    return {
      email: null,
      password: null,
      user: {}
    }
  },
  methods: {
    async login() {
      let res = await this.$auth.loginWith('laravelSanctum', {data: {email: this.email, password: this.password}});
      this.loading = false;
      console.log(res);
    },
  }
}
</script>
