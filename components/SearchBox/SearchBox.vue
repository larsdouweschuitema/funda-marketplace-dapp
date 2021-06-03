<template>
  <div class="bg-blue-5 p-4">
    <div class="md:container md:mx-auto">
      <input
        v-model="searchInputValue"
        placeholder="City, neighborhood, address, etc."
        class="
          w-full
          rounded-sm
          bg-white
          shadow-inner
          py-2
          px-4
          outline-none
          text-base
          font-normal
          h-11
        "
      />
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      searchInputValue: '',
    }
  },
  watch: {
    searchInputValue: {
      handler(val) {
        this.$store.commit('SET_SEARCH_INPUT_VALUE', val)
      },
      immediate: true,
    },
  },
}
</script>
