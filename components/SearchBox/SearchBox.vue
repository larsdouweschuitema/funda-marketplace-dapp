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
import debounce from 'lodash'
export default {
  data() {
    return {
      searchInputValue: '',
    }
  },
  watch: {
    searchInputValue(val) {
      this.searchProperties(val)
    },
  },
  methods: {
    searchProperties(val) {
      debounce(this.$store.commit('SET_SEARCH_INPUT_VALUE', val), 1000)
    },
  },
}
</script>
