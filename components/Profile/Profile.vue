<template>
  <div>
    <h1>Account</h1>
    <h2 class="mt-8">Wallet</h2>
    <Wallet ref="wallet" />
    <h2 class="mt-8">My houses</h2>
    <SearchResultsList>
      <SearchResultsItem
        v-for="(property, index) in properties"
        :key="index"
        :property="property"
        class="mb-4"
      >
        <UiButton tone="primary-alt" @click="openModal">Sell</UiButton>
        <UiButton tone="secondary" @click="onClick">Cancel auction</UiButton>
      </SearchResultsItem>
    </SearchResultsList>
  </div>
</template>

<script>
import { UiButton } from '@funda/ui'

export default {
  components: {
    UiButton,
  },
  computed: {
    properties() {
      return this.$store.state.properties
    },
  },
  methods: {
    openModal() {
      this.$store.commit('SET_MODAL_VISIBILITY', true)
    },
    onClick() {
      this.$refs.wallet.cancelAuction(1)
    },
  },
}
</script>
