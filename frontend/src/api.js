// Tiny fetch helper shared by every page.
//
// credentials: "include" makes the browser send the Devise session cookie, so
// requests to signed-in-only endpoints (the dashboards) are authenticated once
// you've logged in through the Rails page.
//
// It normalises the two failure cases the pages care about:
//   - "unauthorized": you're not signed in, or not the right role. Devise
//     answers a JSON request with 401; a wrong-role user gets redirected (which
//     fetch follows, so res.redirected is true); either way there's no JSON.
//   - a thrown generic Error for anything else (network down, 500, etc.).
export async function getJSON(path) {
  const res = await fetch(path, {
    headers: { Accept: "application/json" },
    credentials: "include",
  });

  const isJSON = (res.headers.get("content-type") || "").includes("application/json");

  if (res.status === 401 || res.status === 403 || res.redirected || !isJSON) {
    const err = new Error("unauthorized");
    err.code = "unauthorized";
    throw err;
  }
  if (!res.ok) throw new Error(`HTTP ${res.status}`);

  return res.json();
}
