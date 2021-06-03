<template>
  <div>
    <TheHeader></TheHeader>
    <main class="container mx-auto p-4">
      <Nuxt />
    </main>
    <ModalPropertyBidder button-name="Sell" :handle-click="sellProperty" />
    <TheFooter></TheFooter>
  </div>
</template>

<script>
export default {
  methods: {
    sellProperty() {
      alert('Sell property')
    },
  },
}
</script>
