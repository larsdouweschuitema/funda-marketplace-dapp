<template>
  <div class="md:container md:mx-auto p-4 md:px-0">
    <SearchResultsList v-if="filteredProperties.length">
      <SearchResultsItem
        v-for="(property, index) in filteredProperties"
        :key="index"
        :property="property"
        class="mb-4"
      >
        <UiButton tone="primary-alt" @click="openModal">Buy</UiButton>
      </SearchResultsItem>
    </SearchResultsList>
    <div v-else>No properties found</div>
    <ModalPropertyBidder button-name="Bid" :handle-click="bidOnProperty">
      <UiInput class="mb-2" placeholder="Type a value e.g. 0.034030" />
    </ModalPropertyBidder>
  </div>
</template>

<script>
import { UiButton, UiInput } from '@funda/ui'

export default {
  components: {
    UiButton,
    UiInput,
  },
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
    bidOnProperty() {
      this.$bus.$emit('chatClicked')
    },
  },
}
</script>
