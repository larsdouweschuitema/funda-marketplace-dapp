<template>
  <div class="md:container md:mx-auto p-4 md:px-0">
    <SearchResultsList :properties="properties" />
    <ModalPropertyBidder />
  </div>
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
