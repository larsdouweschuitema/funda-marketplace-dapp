<template>
  <div class="bg-blue-5 py-2">
    <div class="container mx-auto flex">
      <UiInput class="flex-1" placeholder="City, neighborhood, address, etc." @change="setSearchInputValue" />
      <UiButton tone="primary" small @click="handleSearch"><UiIcon icon="search" /></UiButton>
    </div>
  </div>
</template>

<script>
import { UiInput, UiButton, UiIcon } from '@funda/ui'

export default {
  components: {
    UiInput,
    UiButton,
    UiIcon,
  },
  data() {
    return {
      searchInputValue: '',
    }
  },
  methods: {
    setSearchInputValue(event) {
      this.searchInputValue = event.target.value
    },
    handleSearch() {
      console.log(this.searchInputValue)
    }
  }
}
</script>