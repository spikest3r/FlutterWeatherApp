'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "d042f4a66ff49cd75db650fffae2d341",
"assets/AssetManifest.bin.json": "abeb843edb7bbb62dae08be21d97f07f",
"assets/AssetManifest.json": "6d09af20c3951470c950b76d0038d47f",
"assets/assets/1.png": "4b5f6d461c5792a0483906d43b8bca61",
"assets/assets/10.png": "b2c61e983219093c2512c83e6b0f367b",
"assets/assets/11.png": "dc20752b02098fd63a6f7525ec7915c4",
"assets/assets/12.png": "0b53ec5f0264ef5bceb9d88752725c22",
"assets/assets/13.png": "6e125137c645c965ab3190b3125d0e5a",
"assets/assets/14.png": "8afbbbb03239e75e5603aedb646d27bd",
"assets/assets/15.png": "60ebd3ee26ec9aa0c992a76fa42197ff",
"assets/assets/16.png": "316f80064c3daa686952c9415758e211",
"assets/assets/17.png": "9d7412026d845388b242e239b28b5b8b",
"assets/assets/18.png": "88d281f084c738064af8466d1475828b",
"assets/assets/19.png": "90303a53850accbca9950da6d28400a0",
"assets/assets/2.png": "c8672f23b70f84fc239eb1f321ed1371",
"assets/assets/20.png": "fe5df75d21a3d18a9533c5ab2f125a31",
"assets/assets/21a.png": "dcd2849b6d2a6cf2ff08b78810deee9c",
"assets/assets/21b.png": "f44dc84042f519c353aefde602d3ac3d",
"assets/assets/22a.png": "0a8971ee09fc45ba1d730281cf241248",
"assets/assets/22b.png": "e6f82fe39766eb9f0cdb018d641b34d9",
"assets/assets/23a.png": "76d799516a0cd49b2460102ee0f3af3f",
"assets/assets/23b.png": "e209a3948755cf7652c4b975ece37f3d",
"assets/assets/24a.png": "e99c5bb7435b0bfc7eb34b5be22d077c",
"assets/assets/24b.png": "71716dc4ff33b3844c9baac3047ba2c2",
"assets/assets/26.png": "2b0004c9e05dba5ab3f28aec693a7459",
"assets/assets/27.png": "a69512302d93ec8432a2aa4ebf5cca32",
"assets/assets/28.png": "0450eb25f063e70f7713468688a57fb0",
"assets/assets/29.png": "9043fc9b42cbe2b8b765ab5efc723dd2",
"assets/assets/3.png": "7079234f6f3ea44273c19dd6784dc56d",
"assets/assets/30.png": "169c6c82ce85a45afdcc782a353cf293",
"assets/assets/31.png": "657cb50445f9769aa94bb7f85ef86238",
"assets/assets/32.png": "a77b95e921ea685c46cbc02d0cfa8196",
"assets/assets/33.png": "2778e491041d202b399a8118bf9d3a58",
"assets/assets/34.png": "8565e0c95d32ebd979ac7e14fba42c2c",
"assets/assets/35.png": "f5f3da48818398b308a2c523cca61235",
"assets/assets/4.png": "8107a28f2922c3429ed7287e4a3f2cad",
"assets/assets/5.png": "42c90c2d9708ec78f5c0a92516994d38",
"assets/assets/6.png": "5bd90b69d70786967555e34888696d60",
"assets/assets/7.png": "3fd13222859352cd37de8f75b6f21543",
"assets/assets/8.png": "9aa43172b4bbda63411b40c5c9273d12",
"assets/assets/9.png": "3e817f2f75cb6165d554bba052423785",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "c6dc8891b7bf44aa7d1f231adfe97ccc",
"assets/NOTICES": "eb92f1f041d187954ec71b4eb78efb67",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "32406363f5eefa8b9c3f1470747f411b",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "08b3a59510928355c64f5da8df786e01",
"/": "08b3a59510928355c64f5da8df786e01",
"main.dart.js": "07a1e575411a111283895dda335f1914",
"manifest.json": "325504763c0b4ee443bf69e5af20d655",
"version.json": "cb52daa919d6aa3bbe5d0f27829cdad0"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
