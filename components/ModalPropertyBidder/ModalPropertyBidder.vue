<template>
  <UiModal v-show="isModalVisible" :show-close-icon="true" @close="closeModal">
    <template v-slot:header>Buy property</template>
    <template v-slot:body>
      <div class="p-4">
        <slot />
        <UiButton class="w-full" tone="primary" @click="handleClick">{{
          buttonName
        }}</UiButton>
        
      </div>
    </template>
  </UiModal>
</template>

<script>
import { UiModal, UiButton } from '@funda/ui'

export default {
  components: {
    UiModal,
    UiButton,
  },
  props: {
    buttonName: {
      type: String,
      required: true,
    },
    handleClick: {
      type: Function,
      required: true,
    },
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
