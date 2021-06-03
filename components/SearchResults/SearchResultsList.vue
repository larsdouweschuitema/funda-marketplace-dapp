<template>
  <ul>
    <SearchResultsItem
      v-for="(property, index) in properties"
      :key="index"
      :property="property"
      class="mb-4"
    />
  </ul>
</template>

<script>
export default {
  props: {
    properties: {
      type: Array,
      required: true,
      default: () => [],
    },
  },
}
</script>
