# TeachApp (monorepo)

A learning project. One Git repository holds two applications:

```
teachapp/
├── backend/    # Ruby on Rails 8 app (the API + the original server-rendered site)
└── frontend/   # Minimal React app (Vite) that reads data from the backend
```

A "monorepo" just means multiple related projects kept in a single repository,
each in its own folder.

---

## What talks to what

- The **backend** is your existing Rails app, moved unchanged into `backend/`.
  It still serves its normal HTML pages, and it now also serves the course list
  as JSON at `GET /courses.json` (via `app/views/courses/index.json.jbuilder`).
- The **frontend** is a tiny React app with a single component. It fetches
  `/courses.json` and lists the courses.

In development the two run as separate servers:

| App      | Command             | URL                     |
|----------|---------------------|-------------------------|
| Backend  | `bin/rails server`  | http://localhost:3000   |
| Frontend | `npm run dev`       | http://localhost:5173   |

The React app asks for `/courses.json` as a *relative* URL. The Vite dev server
forwards ("proxies") that request to Rails on port 3000 — see
`frontend/vite.config.js`. Because the browser only ever talks to the Vite
server, there is **no CORS setup needed** on the Rails side.

---

## Running it (two terminals)

**Terminal 1 — backend (Rails):**

```bash
cd backend
bin/rails server
```

**Terminal 2 — frontend (React):**

```bash
cd frontend
npm install   # first time only
npm run dev
```

Then open http://localhost:5173. You should see the course(s) from your Rails
database. (Make sure the backend has data — `cd backend && bin/rails db:seed`.)

---

## Deployment note

The Rails app is fully self-contained inside `backend/` — its `Dockerfile`,
Kamal config (`backend/config/deploy.yml`), and `Procfile.dev` all moved with it,
so run Kamal from inside `backend/`. The GitHub Actions workflow
(`.github/workflows/ci.yml`) was updated to run every step inside `backend/`.
