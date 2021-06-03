<template>
  <div>
    <TheHeader></TheHeader>
    <main>
      <Nuxt />
    </main>
    <ModalPropertyBidder button-name="Bid" :handle-click="bidOnProperty" />
    <TheFooter></TheFooter>
  </div>
</template>

<script>
export default {
  methods: {
    bidOnProperty() {
      alert('Bid on property')
    },
  },
}
</script>
