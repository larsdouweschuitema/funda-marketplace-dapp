<template>
  <ul>
    <li v-for="(item, index) in properties" :key="index" class="mb-4">
      <img
        alt="Kastanjelaan 35"
        loading="lazy"
        sizes="(min-width: 500px) 228px, calc(100vw - 2rem)"
        src="https://cloud.funda.nl/valentina_media/144/136/575_720x480.jpg"
        srcset="
          https://cloud.funda.nl/valentina_media/144/136/575_360x240.jpg 360w,
          https://cloud.funda.nl/valentina_media/144/136/575_180x120.jpg 180w,
          https://cloud.funda.nl/valentina_media/144/136/575_720x480.jpg 720w
        "
        class="mb-2"
      />
      <div class="font-semibold text-blue-2">{{ item.address }}</div>
      <div>{{ item.postalCode }}</div>
      <div class="font-semibold">{{ item.price }}</div>
      <div>{{ item.surfaceArea }}</div>
      <div class="mb-2 text-blue-2">{{ item.realtor }}</div>
      <div>
        <UiButton tone="primary-alt">Buy</UiButton>
      </div>
    </li>
  </ul>
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
  mounted() {
    // eslint-disable-next-line no-console
    console.log('properties from store', this.properties)
  },
}
</script>
