<template>
  <NuxtLink to="/profile" class="text-white flex"
    ><UiIcon class="mr-2" icon="avatar" />Account</NuxtLink
  >
</template>

<script>
import { UiIcon } from '@funda/ui'

export default {
  components: {
    UiIcon,
  },
}
</script>
