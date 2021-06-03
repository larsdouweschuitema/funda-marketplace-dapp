<template>
  <ul>
    <slot />
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
