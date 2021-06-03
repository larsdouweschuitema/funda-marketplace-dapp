<template>
  <div>
    <footer v-once class="bg-light-2 border-b-4 border-orange-2 pt-7">
      <div class="flex flex-wrap px-4 md:container md:mx-auto">
        <TheFooterNav
          v-for="(navigation, index) in footers.navigations"
          :key="index"
          :navigation="navigation"
        />
      </div>
      <div class="border-t border-light-1 p-5">
        <div class="flex flex-wrap md:flex-no-wrap md:container md:mx-auto">
          <ul class="flex justify-center md:justify-start w-full mb-4">
            <li
              v-for="(social, index) in footers.socials"
              :key="index"
              class="pr-2"
            >
              <a
                class="bg-white rounded-sm inline-flex h-11 w-11 justify-center items-center"
                :href="social.url"
                :aria-label="social.icon"
                :target="social.target"
                :rel="social.rel"
                ><UiIcon class="p-1 text-blue-1 h-8 w-8" :icon="social.icon"
              /></a>
            </li>
          </ul>
          <div
            class="flex flex-col md:flex-row w-full items-center md:items-start md:justify-end"
          >
            <p class="mb-2">&copy; 2001-{{ currentYear }} funda</p>
            <ul class="flex">
              <li v-for="(link, index) in footers.links" :key="index">
                <span class="mx-2">•</span>
                <a
                  class="text-blue-1"
                  :href="link.url"
                  :aria-label="link.label"
                  >{{ link.label }}</a
                >
              </li>
            </ul>
          </div>
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
import { UiIcon } from '@funda/ui'
import footers from './footerData'

export default {
  components: {
    UiIcon,
  },
  data() {
    return {
      currentYear: new Date().getFullYear(),
      footers,
    }
  },
}
</script>