<template>
  <UiModal v-show="isModalVisible" :show-close-icon="true" @close="closeModal">
    <template v-slot:header>Modal header</template>
    <template v-slot:body>
      <div class="mb-10 mx-12">Modal body</div>
    </template>
  </UiModal>
</template>

<script>
import { UiModal } from '@funda/ui'

export default {
  components: {
    UiModal,
  },
  computed: {
    isModalVisible() {
      return this.$store.state.isModalVisible
    },
  },
  methods: {
    closeModal() {
      this.$store.commit('SET_MODAL_VISIBILITY', false)
    },
  },
}
</script>
