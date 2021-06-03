module.exports = {
  presets: [require('@funda/tailwind-config')],
  purge: {
    content: [
      './node_modules/\\@funda/ui/src/**/*.{js,vue}',
      './components/**/*.{js,vue}',
      './layouts/*.{js,vue}',
      './pages/*.{js,vue}',
      './nuxt.config.js',
    ],
  }
}