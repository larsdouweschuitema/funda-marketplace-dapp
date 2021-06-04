<template>
  <div>
    <TheHeader></TheHeader>
    <main>
      <Nuxt />
    </main>
    <ModalPropertyBidder button-name="Bid" :handle-click="bidOnProperty">
      <UiInput class="mb-2" placeholder="Type a value e.g. 0.034030" />
    </ModalPropertyBidder>
    <TheFooter></TheFooter>
  </div>
</template>

<script>
import { UiInput } from '@funda/ui'

export default {
  components: {
    UiInput,
  },
  methods: {
    bidOnProperty() {
      alert('Bid on property')
    },
  },
}
</script>
