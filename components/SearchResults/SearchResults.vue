<template>
  <div class="md:container md:mx-auto p-4 md:px-0">
    <SearchResultsList :properties="properties">
      <SearchResultsItem
        v-for="(property, index) in properties"
        :key="index"
        :property="property"
        class="mb-4"
        button-name="Buy"
        :on-click="openModal"
      />
    </SearchResultsList>
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
  methods: {
    openModal() {
      this.$store.commit('SET_MODAL_VISIBILITY', true)
    },
  },
}
</script>
