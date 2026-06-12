# 💧 IoT Water Quality Monitoring System

Sistem monitoring kualitas air berbasis IoT secara real-time. Dirancang untuk memantau parameter vital air menggunakan sensor analog/digital dan mengirimkan data ke dashboard analisis melalui protokol MQTT/HTTP.

---

## ✨ Fitur Utama

- **📊 Real-time Monitoring:** Pantau parameter air (pH, TDS, Turbidity, Suhu) setiap detik.
- **📱 Dashboard Web/Mobile:** Visualisasi data yang interaktif dan mudah dibaca.
- **⚠️ Intelligent Alerts:** Notifikasi otomatis jika kualitas air terdeteksi di bawah standar.
- **💾 Data Logging:** Penyimpanan riwayat data untuk analisis tren jangka panjang.

---

## 🛠️ Hardware & Tech Stack

- **Hardware:** ESP32 / Arduino, Sensor pH, Sensor TDS, Sensor Turbidity.
- **Connectivity:** WiFi, MQTT Protocol.
- **Cloud/Backend:** Node-RED / Firebase / ThingsBoard (pilih salah satu).
- **Security:** CodeQL Analysis, SECURITY.md policy active.

---

## 🚀 Setup & Instalasi

### 1) Hardware Wiring
Hubungkan sensor ke pin analog ESP32 sesuai skema di folder `docs/`.

### 2) Konfigurasi Firmware
Edit `config.h` (jika tersedia) atau variabel berikut di main file:
```cpp
const char* ssid = "WIFI_SSID";
const char* password = "WIFI_PASSWORD";
const char* mqtt_server = "broker.hivemq.com";
```

### 3) Upload & Run
- Flash kode menggunakan **VS Code + PlatformIO** atau **Arduino IDE**.
- Monitor serial output pada baud rate 115200.

---

## 🤝 Kontribusi

Pull Request sangat dihargai. Untuk perubahan besar, harap buka issue terlebih dahulu.

## 📄 Lisensi

Proyek ini dilisensikan di bawah **MIT License**. Lihat file [LICENSE](LICENSE) untuk detail.

## 🛡️ Keamanan

Kami menjaga keamanan proyek ini dengan serius. Lihat [SECURITY.md](SECURITY.md) untuk melaporkan kerentanan.
