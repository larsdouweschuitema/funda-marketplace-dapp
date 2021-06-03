export default {
  modules: ['@nuxtjs/axios'],
  axios: {
    baseURL: process.env.API_URL,
  },
  buildModules: ['@nuxtjs/eslint-module', '@nuxtjs/pwa', '@nuxtjs/tailwindcss'],
  head: {
    titleTemplate: '%s [funda]',
    htmlAttrs: {
      lang: 'nl',
    },
  },
  pwa: {
    meta: {
      theme_color: '#FFFFFF',
    },
    workbox: false,
  },
  components: true,
  loading: false,
  loadingIndicator: false,
  fetch: {
    client: false,
  },
  features: {
    middleware: true,
    transitions: false,
    deprecations: false,
    validate: false,
    asyncData: false,
    fetch: false,
    clientOnline: false,
    clientPrefetch: false,
    clientUseUrl: true,
    componentAliases: false,
    componentClientOnly: false,
  },
  build: {
    extractCSS: true,
    transpile: ['@funda/ui', '@funda/icons'],
    indicator: false,
    terser: true,
  },
}
