<template>
  <ul>
    <SearchResultsItem
      v-for="(property, index) in properties"
      :key="index"
      :property="property"
      class="mb-4"
    />
  </ul>
</template>

<script>
export default {
  computed: {
    properties() {
      return this.$store.state.properties
    },
  },
  mounted() {
    // eslint-disable-next-line no-console
    console.log('properties from store', this.properties)
  },
}
</script>
