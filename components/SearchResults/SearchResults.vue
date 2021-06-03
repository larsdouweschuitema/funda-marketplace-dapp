<template>
  <div class="md:container md:mx-auto p-4">
    <SearchResultsList />
    <UiModal v-show="isModalVisible" @close="closeModal">
      <template v-slot:header>Modal header</template>
      <template v-slot:body>
        <div class="mb-10 mx-12">Modal body</div>
      </template>
    </UiModal>
  </div>
</template>

<script>
import { UiModal } from '@funda/ui'

export default {
  components: {
    UiModal,
  },
  data() {
    return {
      isModalVisible: false,
    }
  },
  methods: {
    showModal() {
      this.isModalVisible = true
    },
    closeModal() {
      this.isModalVisible = false
    },
  },
}
</script>
