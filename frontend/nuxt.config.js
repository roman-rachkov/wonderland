export default {
  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: 'Wonderland',
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
    "~plugins/validate.js",
    "~plugins/i18n.js",
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    '@nuxtjs/vuetify',
    '@nuxtjs/laravel-echo'
  ],

  echo: {
    broadcaster: 'socket.io',
    authModule: true,
    connectOnLogin: true,
    disconnectOnLogout: true,
    // plugins: ['~/plugins/echo.js']
    host: 'http://localhost:8001',
    // transports: ['websocket']
  },

  vuetify: {},

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    // https://go.nuxtjs.dev/axios
    '@nuxtjs/axios',
    '@nuxtjs/auth-next',
    // '@nuxtjs/proxy',
    '@nuxtjs/i18n'
  ],

  i18n: {
    locales: ['ru'],
    defaultLocale: 'ru',
    strategy: 'no_prefix',
  },

  nuxtValidate: {
    lang: 'ru',
  },

  auth: {
    strategies: {
      laravelSanctum: {
        provider: 'laravel/sanctum',
        url: 'http://localhost:8081'
      }
    },
    plugins: [
      "~plugins/auth.js",
    ]
  },

  // Axios module configuration: https://go.nuxtjs.dev/config-axios
  axios: {
    // Workaround to avoid enforcing hard-coded localhost:3000: https://github.com/nuxt-community/axios-module/issues/308
    baseURL: 'http://localhost:8081',
    credentials: true,
    proxy: false,
    // prefix: '/laravel'
  },

  // proxy: {
  //   '/api': {target: 'http://localhost:8081', changeOrigin: true},
  //   '/laravel': {target: 'http://localhost:8081', pathRewrite: {'^/laravel': ''}, changeOrigin: true}
  // },

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

  ssr: false,

  router: {
    middleware: ['auth']
  }
}
