<template>
  <div class="d-flex justify-center align-center">
    <validation-observer
      ref="observer"
      v-slot="{ invalid }"
    >
      <v-form class="form" id="login" @submit.prevent="register()">
        <validation-provider
          v-slot="{errors}"
          name="name"
          rules="required|min:4"
        >
          <v-text-field
            v-model="name"
            :error-messages="errors"
            label="Имя пользователя"
            required
          />
        </validation-provider>
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
        <validation-provider
          v-slot="{errors}"
          name="password_confirmation"
          rules="required|confirmed:password"
        >
          <v-text-field
            v-model="password_confirmation"
            :error-messages="errors"
            label="Подтвердите пароль"
            :type="canSee ? 'text' : 'password'"
            required
          >
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
  auth: 'guest',
  components: {
    ValidationObserver, ValidationProvider
  },
  name: "register",
  data() {
    return {
      canSee: false,
      name: '',
      email: '',
      password: '',
      password_confirmation: '',
    }
  },
  mounted() {
  },
  methods: {
    async register() {
      if (this.$refs.observer.validate()) {
        await this.$axios.get('/sanctum/csrf-cookie').then(() => {
          this.$axios.$post('/register', {
            name: this.name,
            email: this.email,
            password: this.password,
            password_confirmation: this.password_confirmation,

          })
            .then(() => {
              this.$auth.loginWith('laravelSanctum', {
                data: {
                  email: this.email,
                  password: this.password
                }
              }).then(r => console.log(r)).catch(e => console.log(e.response));
            })
            .catch(e => {
              this.$refs.observer.setErrors(e.response.data.errors);
            });
        })
      }
    },
  }
}
</script>

<style scoped>
.form {
  min-width: 350px;
}

</style>
