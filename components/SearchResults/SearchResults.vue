<template>
  <div class="md:container md:mx-auto p-4 md:px-0">
    <SearchResultsList>
      <SearchResultsItem
        v-for="(property, index) in filteredProperties"
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
    searchInputValue() {
      return this.$store.state.searchInputValue
    },
    filteredProperties() {
      return this.properties.filter((property) => {
        console.log('property', property)
        return property.address
          .toLowerCase()
          .includes(this.searchInputValue.toLowerCase())
      })
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
