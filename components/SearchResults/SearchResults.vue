<template>
  <div class="md:container md:mx-auto p-4 md:px-0">
    <SearchResultsList v-if="filteredProperties.length">
      <SearchResultsItem
        v-for="(property, index) in filteredProperties"
        :key="index"
        :property="property"
        class="mb-4"
        button-name="Buy"
        :on-click="openModal"
      />
    </SearchResultsList>
    <div v-else>No properties found</div>
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
        return property.address
          .toLowerCase()
          .includes(this.searchInputValue.toLowerCase())
      })
    },
  },
  methods: {
    openModal() {
      this.$store.commit('SET_MODAL_VISIBILITY', true)
    },
  },
}
</script>
