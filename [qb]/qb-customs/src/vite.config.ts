import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import * as path from "path";

// https://vitejs.dev/config/
export default defineConfig({
  base: "",
  plugins: [vue()],
  build: {
    outDir: "../html",
  },
  resolve: {
    alias: [
      { find: "@components", replacement: path.resolve("src", "components") },
      { find: "@", replacement: path.resolve("src", "") },
    ],
  },
});

