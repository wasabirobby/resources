<script setup lang="ts">
import { ref, onMounted } from "vue";
import type { Ref } from "vue";
import type { Tab } from "@/utils";
import { axiosPost } from "@/utils";

import Header from "@components/Header.vue";
import TabsList from "@components/TabsList.vue";

const customsName: Ref<string> = ref(
  process.env.NODE_ENV == "development" ? "QB-Customs" : ""
);
const helpText: Ref<string> = ref("Choose a tab");
let defaultTabs: Tab[] = [];
const tabs: Ref<Tab[]> = ref(defaultTabs);
const currentTab: Ref<Tab | null> = ref(null);
const show: Ref<boolean> = ref(
  process.env.NODE_ENV == "development" ? true : false
);

function changeTab(newTab: Tab | null, ignoreFormatting?: boolean): void {
  if (
    ignoreFormatting !== true &&
    newTab !== null &&
    currentTab.value !== null
  ) {
    newTab.name = currentTab.value.name + "-" + newTab.name;
  }

  currentTab.value = newTab;

  if (currentTab.value == null) {
    helpText.value = "Choose a tab";
    tabs.value = defaultTabs;
  } else {
    if (currentTab.value.subCategories == undefined) {
      tabs.value = currentTab.value.options;
      helpText.value = "Choose an option";
    } else {
      tabs.value = currentTab.value.subCategories;
      helpText.value = "Choose a sub category";
    }
  }
}

function clickOption(clickedOption: Tab): void {
  axiosPost("clickOption", {
    tab: currentTab.value.name,
    option: clickedOption.name,
  });

  currentTab.value = null;
  tabs.value = defaultTabs;
}

function close(forceClose: boolean): void {
  if (forceClose !== true && currentTab.value !== null) {
    const last = currentTab.value.name.lastIndexOf("-");

    if (last == -1) {
      changeTab(null);
      return;
    } else {
      const splits = currentTab.value.name.split("-");

      let newValue: null | Tab = null;
      for (let i = 0; i < splits.length; i++) {
        if (i !== splits.length - 1) {
          if (newValue == null) {
            for (let i2 = 0; i2 < defaultTabs.length; i2++) {
              if (defaultTabs[i2].name == splits[i]) {
                newValue = defaultTabs[i2];
                break;
              }
            }
          } else {
            for (let i2 = 0; i2 < newValue.subCategories.length; i2++) {
              if (newValue.subCategories.name == splits[i]) {
                newValue = newValue.subCategories[i2];
              }
            }
          }
        }
      }

      if (newValue !== null) {
        let newTabName = "";
        for (let i = 0; i < splits.length; i++) {
          if (i !== splits.length - 1) {
            if (newTabName !== "") {
              newTabName = newTabName + "-" + splits[i];
            } else {
              newTabName = splits[i];
            }
          }
        }

        newValue.name = newTabName;
        changeTab(newValue, true);
      }
      return;
    }
  } else {
    show.value = false;
    axiosPost("close");
  }
}

onMounted(() => {
  window.addEventListener("keyup", function (e: KeyboardEvent) {
    switch (e.keyCode) {
      case 27: // escape
        close(false);
        break;
      case 8: // backspace
        close(false);
        break;
    }
  });

  window.addEventListener("message", function (e: MessageEvent) {
    switch (e.data.action) {
      case "setupTabs":
        tabs.value = e.data.newTabs;
        defaultTabs = e.data.newTabs;
        break;
      case "open":
        show.value = true;
        break;
    }
  });
});
</script>

<template>
  <v-app>
    <div
      class="main"
      :style="{
        opacity: show ? 1 : 0,
        transform: show
          ? 'translateY(-50%)'
          : 'translateX(100px) translateY(-50%)',
      }"
    >
      <Header :name="customsName" :helpText="helpText"></Header>
      <TabsList
        :tabs="tabs"
        :isOptions="currentTab && currentTab.subCategories == undefined"
        v-if="
          currentTab == null ||
          currentTab.subCategories !== undefined ||
          currentTab.options !== undefined
        "
        @changeTab="changeTab"
        @clickOption="clickOption"
      />
    </div>
  </v-app>
</template>

<style scoped>
.main {
  height: fit-content;
  min-height: 500px;
  max-height: clamp(720px, 1080px, 80vh);

  min-width: 400px;
  max-width: calc(100vw / 3);

  background: #151a1f;
  border-radius: 6px;

  overflow: hidden;

  position: absolute;
  top: 50%;
  right: 2.5vh;

  display: flex;
  flex-direction: column;

  transition: 250ms;
}
</style>
