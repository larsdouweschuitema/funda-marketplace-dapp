<template>
  <div>
    <h1>Account</h1>
    <h2>My houses</h2>
    <SearchResultsList :properties="properties">
      <SearchResultsItem
        v-for="(property, index) in properties"
        :key="index"
        :property="property"
        class="mb-4"
        button-name="Sell"
        :on-click="openModal"
      />
    </SearchResultsList>
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
  methods: {
    openModal() {
      this.$store.commit('SET_MODAL_VISIBILITY', true)
    },
  },
}
</script>
