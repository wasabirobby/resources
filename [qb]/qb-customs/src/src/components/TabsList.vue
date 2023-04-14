<script setup lang="ts">
import { onMounted } from "vue";
import type { Tab, Option } from "../utils";
import { axiosPost } from "../utils";

const props = defineProps(["tabs", "isOptions"]);
const emit = defineEmits(["changeTab", "clickOption"]);
let formatter = new Intl.NumberFormat("de-DE", {
  style: "currency",
  currency: "USD",
});

function handleTab(newTab: string): void {
  if (props.isOptions) {
    emit("clickOption", newTab);
  } else {
    emit("changeTab", newTab);
  }
}

function previewOption(data: Tab | Option): void {
  if (props.isOptions == true) {
    axiosPost("previewOption", data);
  }
}

function unPreviewOption(data: Tab | Option): void {
  if (props.isOptions == true) {
    axiosPost("unPreviewOption", data);
  }
}

onMounted(() => {
  window.addEventListener("message", (e: MessageEvent) => {
    switch (e.data.action) {
      case "firstSetup":
        formatter = new Intl.NumberFormat("de-DE", {
          style: "currency",
          currency: e.data.currency,
        });
        break;
    }
  });
});

function getFormattedNum(num: number) {
  return formatter.format(num);
}
</script>

<template>
  <div class="tabs-list">
    <div
      class="tab-item"
      v-for="tab in tabs"
      :key="tab.name"
      @click="handleTab(tab)"
      v-ripple
      @mouseover="previewOption(tab)"
      @mouseleave="unPreviewOption(tab)"
    >
      <div class="label">{{ tab.label }}</div>
      <div class="price">
        {{ tab.price !== undefined ? `${getFormattedNum(tab.price)}` : "" }}
      </div>
    </div>
  </div>
</template>

<style scoped>
.tabs-list {
  padding: 15px 0 25px 0;

  flex: 1;
  width: 100%;

  display: flex;
  flex-direction: column;
  row-gap: 3px;

  overflow-y: scroll;
  overflow-x: hidden;
}

.tab-item {
  width: 100%;

  padding: 0.25rem 1rem;

  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
}

.label {
  flex: 1;
}

.label,
.price {
  font-family: "Roboto", sans-serif;
  font-weight: 400;
  font-size: 1.1rem;
  color: #fff;
}

.tab-item:hover {
  cursor: pointer;

  background: #1e242b;
  color: #000;
}

p {
  max-height: 100px;
}
</style>
