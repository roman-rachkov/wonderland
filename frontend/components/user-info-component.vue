<template>
  <div v-if="!$auth.loggedIn" class="user-info">
    <p>Привет, Гость!</p>
    <p>
      <nuxt-link :to="{name: 'user-login'}">Войти</nuxt-link>&nbsp;
      или&nbsp;
      <nuxt-link :to="{name: 'user-register'}">Зарегистрироваться?</nuxt-link>
    </p>
  </div>
  <div v-else class="user-info d-flex align-center">
    <p class="mr-1">Привет,&nbsp;
      <nuxt-link :to="{name: 'user', params: {}}">{{ $auth.user.name }}</nuxt-link>
    </p>
    <v-form @submit.prevent="logout()">
      <v-btn
        icon
        type="submit"
      >
        <v-icon>mdi-logout</v-icon>
      </v-btn>
    </v-form>
  </div>
</template>

<script>
export default {
  name: "user-info-component",
  methods: {
    async logout() {
      await this.$auth.logout();
    }
  }
}
</script>

<style scoped>
p {
  margin-bottom: 0;
}
</style>
