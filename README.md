# 🌡️ IoT Water Monitoring — DHT11 Realtime Dashboard

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase)](https://firebase.google.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Aplikasi Flutter untuk monitoring suhu & kelembaban real-time dari sensor DHT11 via Firebase Firestore. Data ditampilkan dalam bentuk angka langsung dan grafik interaktif menggunakan Chart.

---

## ✨ Features

- 🌡️ **Realtime Monitoring** — Suhu & kelembaban DHT11 dari Firebase Firestore
- 📊 **Interactive Charts** — Grafik suhu & kelembaban via `fl_chart`
- 🔥 **Firebase Crashlytics** — Error tracking otomatis
- 📱 **Cross-Platform** — Android, iOS, Web dalam satu codebase
- 🔄 **Live Update** — Data Firestore ter-streaming secara real-time

## 🛠️ Tech Stack

| Component | Tech |
|-----------|------|
| Framework | Flutter 3.x |
| Backend | Firebase (Firestore, Crashlytics) |
| Charts | fl_chart |
| Language | Dart |

## 🚀 Getting Started

```bash
git clone https://github.com/arapcihuy/iot-water-monitoring.git
cd iot-water-monitoring
flutter pub get
flutter run
```

### Prerequisites

- Flutter SDK ≥ 3.0
- Firebase project (configure `firebase_options.dart`)

## 📄 License

MIT

## 👤 Author

**arapcihuy** — [github.com/arapcihuy](https://github.com/arapcihuy)
