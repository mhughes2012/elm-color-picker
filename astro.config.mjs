import { defineConfig } from 'astro/config';

export default defineConfig({
  vite: {
    plugins: [
      // You'll need to install and configure vite-plugin-elm
      // npm install --save-dev vite-plugin-elm
      require('vite-plugin-elm')()
    ]
  }
});