<template>
  <main>
    <SearchBox />
    <SearchResults />
  </main>
</template>

<script>
export default {
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
