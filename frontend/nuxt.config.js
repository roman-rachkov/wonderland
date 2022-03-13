export default {
  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: 'Wonderlan',
    htmlAttrs: {
      lang: 'en'
    },
    meta: [
      {charset: 'utf-8'},
      {name: 'viewport', content: 'width=device-width, initial-scale=1'},
      {hid: 'description', name: 'description', content: ''},
      {name: 'format-detection', content: 'telephone=no'}
    ],
    link: [
      {rel: 'icon', type: 'image/x-icon', href: '/favicon.ico'}
    ]
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
    "~plugins/validate.js"
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    '@nuxtjs/vuetify'
  ],

  vuetify: {},

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    // https://go.nuxtjs.dev/axios
    '@nuxtjs/axios',
    '@nuxtjs/auth-next',
    '@nuxtjs/proxy',
  ],

  nuxtValidate: {
    lang: 'ru',
  },

  auth: {
    strategies: {
      laravelSanctum: {
        provider: 'laravel/sanctum',
        url: 'http://localhost:8081'
      }
    }
  },

  // Axios module configuration: https://go.nuxtjs.dev/config-axios
  axios: {
    // Workaround to avoid enforcing hard-coded localhost:3000: https://github.com/nuxt-community/axios-module/issues/308
    // baseURL: 'http://127.0.0.1:8081/api',
    credentials: true,
    proxy: true
  },

  proxy: {
    '/api': {target: 'http://localhost:8081/api', pathRewrite: {'^/api': '/'}, changeOrigin: true},
    '/laravel': {target: 'http://localhost:8081', pathRewrite: {'^/laravel': '/'}, changeOrigin: true}
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {},

  watchers: {
    webpack: {
      poll: true
    }
  },

  server: {
    host: '0'
  },

  ssr: false
}
