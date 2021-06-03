<template>
  <Profile />
</template>

<script>
export default {
  layout: 'profile',
  mounted() {
    this.getProperties()
  },
  methods: {
    async getProperties() {
      await this.$store.dispatch('getProperties')
    },
  },
}
</script>
