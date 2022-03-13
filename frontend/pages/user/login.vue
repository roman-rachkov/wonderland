<template>
  <div class="d-flex justify-center align-center">
    <validation-observer
      ref="observer"
      v-slot="{ invalid }"
    >
      <v-form class="form" id="login" @submit.prevent="login()">
        <validation-provider
          v-slot="{errors}"
          name="email"
          rules="required|email"
        >
          <v-text-field
            v-model="email"
            :error-messages="errors"
            label="E-mail"
            required
          />
        </validation-provider>
        <validation-provider
          v-slot="{errors}"
          name="password"
          rules="required|min:6"
        >
          <v-text-field
            v-model="password"
            :error-messages="errors"
            label="Пароль"
            :type="canSee ? 'text' : 'password'"
            required
          >
            <v-btn icon @click.prevent="canSee = !canSee" slot="append">
              <v-icon v-if="!canSee">mdi-eye</v-icon>
              <v-icon v-else>mdi-eye-remove</v-icon>
            </v-btn>
          </v-text-field>
        </validation-provider>
        <v-btn
          type="submit"
          :disabled="invalid"
        >
          Войти
        </v-btn>
      </v-form>
    </validation-observer>
  </div>
</template>

<script>
import {ValidationObserver, ValidationProvider} from 'vee-validate';

export default {
  components: {
    ValidationObserver, ValidationProvider
  },
  name: "login",
  data() {
    return {
      canSee: false,
      email: '',
      password: ''
    }
  },
  methods: {
    async login() {
      if (this.$refs.observer.validate()) {
        await this.$auth.loginWith('laravelSanctum', {data: {email: this.email, password: this.password}})
      }
    }
  }
}
</script>

<style scoped>
.form {
  min-width: 350px;
}

</style>
