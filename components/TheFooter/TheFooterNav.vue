<template>
  <nav class="w-full md:w-6/12 lg:w-1/4 mb-9">
    <h3 class="font-semibold py-1.5">{{ navigation.heading }}</h3>
    <ul>
      <li v-for="(link, index) in navigation.links" :key="index">
        <a
          class="text-blue-1 py-1.5 block"
          :href="link.url"
          :aria-label="link.label"
          :target="link.target"
          :rel="link.rel"
          >{{ link.label }}</a
        >
      </li>
    </ul>
  </nav>
</template>

<script>
export default {
  props: {
    navigation: {
      type: Object,
      required: true,
    },
  },
}
</script>
