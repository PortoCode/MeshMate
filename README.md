# MeshMate

MeshMate is a SwiftUI-based iOS app designed to simulate the management of devices in a mesh Wi-Fi network. It demonstrates modern engineering practices such as gRPC and RESTful integration, reactive UI, offline persistence, and modular architecture — all in a mobile-native experience.

---

## Features

- **Device Management UI** — List and manage connected devices (block/unblock, see details).
- **Dynamic Protocol Switching** — Toggle between gRPC and RESTful API integrations.
- **gRPC Integration** — Simulated real-time network data using Protocol Buffers.
- **RESTful Support** — Load devices and network status via local JSON (with future backend support).
- **Authentication Flow** — Local login/logout simulation using `AppStorage`.
- **Offline Persistence** — Devices are stored using `UserDefaults` for offline access.
- **Mocked Network Layer** — Simulates latency, status changes, and device states.
- **Responsive SwiftUI Interface** — Navigation, forms, animations and more.
- **Clean MVVM Architecture** — Easy to test, maintain, and scale.
