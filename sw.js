// Network first, with the last copy as the fallback, so the page, supabase-js and the fonts still open with
// no signal. A slow network gets 4 s before the cached copy is used. Supabase calls are never cached.
const CACHE = 'gym-plan-v1';
const CACHED_HOSTS = ['cdn.jsdelivr.net', 'fonts.googleapis.com', 'fonts.gstatic.com'];

self.addEventListener('install', () => self.skipWaiting());
self.addEventListener('activate', (e) => e.waitUntil(self.clients.claim()));
self.addEventListener('fetch', (e) => {
  const req = e.request;
  const url = new URL(req.url);
  if (req.method !== 'GET' || (url.origin !== location.origin && !CACHED_HOSTS.includes(url.hostname))) return;
  const net = fetch(req).then((res) => {
    if (res.ok || res.type === 'opaque') { const copy = res.clone(); caches.open(CACHE).then((c) => c.put(req, copy)); }
    return res;
  });
  const slow = new Promise((r) => setTimeout(r, 4000));
  e.respondWith(Promise.race([net, slow])
    .then((res) => res || caches.match(req).then((hit) => hit || net))
    .catch(() => caches.match(req).then((hit) => hit || Response.error())));
});
