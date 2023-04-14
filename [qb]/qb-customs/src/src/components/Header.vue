<script setup lang="ts">
defineProps(["name", "helpText"]);
</script>

<template>
  <div class="header">
    <h1>Welcome to {{ name }}</h1>

    <p>{{ helpText }}</p>
  </div>
</template>

<style scoped>
.header {
  box-shadow: rgba(0, 0, 0, 0.07) 0px 1px 2px, rgba(0, 0, 0, 0.07) 0px 2px 4px,
    rgba(0, 0, 0, 0.07) 0px 4px 8px, rgba(0, 0, 0, 0.07) 0px 8px 16px,
    rgba(0, 0, 0, 0.07) 0px 16px 32px, rgba(0, 0, 0, 0.07) 0px 32px 64px;
}

.header h1 {
  margin: 0px;

  background: #dc143c;

  width: 100%;
  text-align: center;
  color: #fff;
  font-family: "Roboto", sans-serif;
  font-weight: 400;
  font-size: 1.5rem;

  padding: 0.5rem 0.75rem;
}

.header p {
  margin: clamp(12.5px, 1.3vh, 17.5px) 1vw 0 1vw;
  padding: 0.25vw 0.5vw;

  box-shadow: rgba(0, 0, 0, 0.16) 0px 3px 6px, rgba(0, 0, 0, 0.23) 0px 3px 6px;
  background: #dc143cbf;
  border-radius: 5px;

  width: calc(100% - 2vw);
  text-align: center;
  color: #ddd;
  font-family: "Montserrat", sans-serif;
  font-weight: 400;
  letter-spacing: 3px;
  font-size: 1.25rem;
}
</style>
