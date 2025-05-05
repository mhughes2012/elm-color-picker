import { defineConfig } from 'astro/config';
import elmPlugin from 'vite-plugin-elm';

export default defineConfig({
  vite: {
    plugins: [
      elmPlugin()
    ]
  }
});