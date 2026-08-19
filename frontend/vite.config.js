import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import tailwindcss from "@tailwindcss/vite";

// Vite config for the React frontend.
//
// proxy: forward ONLY the Rails JSON API paths and the Devise auth pages to
// Rails on :3000. This is deliberately narrow. Client-side routes such as
// "/courses/1" or "/dashboard/instructor" must NOT be proxied — they need to
// fall through to the SPA so React Router can render them in the browser.
//
// A proxy key that starts with "^" is treated as a regular expression, which
// lets us match, say, "/courses/1.json" (an API call) while leaving
// "/courses/1" (a page route) alone.
//
// Note the singular/plural split that keeps things from colliding:
//   - React page routes use  /dashboard/...   (singular, handled by the SPA)
//   - Rails JSON API uses     /dashboards/...  (plural, proxied to Rails)
//
// changeOrigin + the Origin header rewrite: Rails 8's CSRF protection rejects a
// POST (like Devise login) when the browser's Origin header doesn't match the
// host Rails thinks it's serving. Because the browser is on :5173 and Rails is
// on :3000, they never match through a plain proxy. Rewriting the Origin header
// to Rails' own origin makes the check pass — without weakening CSRF on the
// backend. In production the frontend and backend share an origin, so this
// dev-only shim isn't needed there.
const toRails = {
  target: "http://localhost:3000",
  changeOrigin: true,
  headers: { origin: "http://localhost:3000" },
};

export default defineConfig({
  plugins: [react(), tailwindcss()],
  server: {
    port: 5173,
    proxy: {
      "^/courses(\\.json|/\\d+\\.json)$": toRails,
      "^/dashboards/(instructor|student)\\.json$": toRails,
      "^/users": toRails,
    },
  },
});
