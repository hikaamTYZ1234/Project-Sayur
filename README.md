# Project Sayur 🥬

Aplikasi e-commerce untuk pembelian sayuran dan produk organik dengan teknologi Flutter (Frontend) dan Laravel (Backend).

## 📋 Deskripsi Aplikasi

**Project Sayur** adalah platform e-commerce mobile yang memudahkan pengguna untuk:
- ✅ Menelusuri katalog produk sayuran dan organik
- ✅ Menambahkan produk ke keranjang
- ✅ Melakukan pemesanan online
- ✅ Melihat riwayat pesanan
- ✅ Mengelola profil pengguna
- ✅ Tema gelap dan terang

**Tech Stack:**
- **Frontend:** Flutter (Dart)
- **Backend:** Laravel (PHP)
- **Database:** MySQL/SQLite
- **API:** RESTful API dengan Sanctum Authentication

---

## 🚀 Setup & Instalasi

### Prerequisites
- PHP 8.0+ (untuk Laravel)
- Composer
- Node.js & npm (untuk frontend assets)
- Flutter SDK
- MySQL atau SQLite

---

## 🔧 Backend Laravel - Setup

### 1. Install Dependencies
```bash
cd backend-sayur
composer install
```

### 2. Konfigurasi Environment
```bash
cp .env.example .env
```

Edit file `.env`:
```env
APP_NAME=SayurAPI
APP_ENV=local
APP_DEBUG=true
APP_URL=http://localhost:8000

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=sayur_db
DB_USERNAME=root
DB_PASSWORD=

SANCTUM_STATEFUL_DOMAINS=localhost:3000,127.0.0.1:3000
```

### 3. Generate Application Key
```bash
php artisan key:generate
```

### 4. Buat Database
```bash
# Via MySQL
mysql -u root -p
> CREATE DATABASE sayur_db;
> EXIT;
```

### 5. Jalankan Migrasi & Seeder
```bash
php artisan migrate
php artisan db:seed  # (opsional, jika ada)
```

### 6. Jalankan Development Server
```bash
php artisan serve
```

Backend akan berjalan di: **http://localhost:8000**

---

## 📱 Frontend Flutter - Setup

### 1. Install Dependencies
```bash
cd frontend
flutter pub get
```

### 2. Konfigurasi API URL
Edit file `lib/services/api_service.dart`:

**Untuk development lokal (Chrome Desktop):**
```dart
static const String baseUrl = 'http://localhost:8000/api';
```

**Untuk Android Emulator:**
```dart
static const String baseUrl = 'http://10.0.2.2:8000/api';
```

**Untuk Device Fisik:**
```dart
static const String baseUrl = 'http://<IP_DEVICE>:8000/api';
```

### 3. Jalankan Aplikasi
```bash
flutter run
```

Atau untuk platform spesifik:
```bash
flutter run -d chrome          # Web
flutter run -d emulator-5554   # Android Emulator
```

---

## 🗄️ Konfigurasi Database

### Database Schema (otomatis via Laravel migrations)

**Tabel Utama:**
- `users` - Data pengguna (nama, email, password)
- `products` - Produk sayuran (nama, harga, kategori)
- `categories` - Kategori produk
- `orders` - Pesanan pengguna
- `order_items` - Detail item dalam pesanan
- `personal_access_tokens` - Token autentikasi (Sanctum)

### Reset Database
```bash
php artisan migrate:reset
php artisan migrate
```

---

## 🔐 API Authentication

### Login
```bash
POST /api/login
Content-Type: application/json

{
  "email": "budi@gmail.com",
  "password": "123456"
}
```

**Response:**
```json
{
  "message": "Login berhasil",
  "token": "eyJ0eXAiOiJKV1QiLCJhbGc...",
  "user": {
    "id": 1,
    "name": "Budi",
    "email": "budi@gmail.com",
    "phone": null
  }
}
```

### Register
```bash
POST /api/register
Content-Type: application/json

{
  "name": "Nama Lengkap",
  "email": "user@gmail.com",
  "password": "password123"
}
```

### Gunakan Token dalam Request
Header semua request authenticated:
```
Authorization: Bearer <token_dari_login>
```

---

## 📡 Endpoint API

### Authentication
- `POST /api/login` - Login pengguna
- `POST /api/register` - Registrasi akun baru
- `POST /api/logout` - Logout (memerlukan token)
- `GET /api/me` - Ambil profil user (memerlukan token)

### Products
- `GET /api/products` - List semua produk
- `GET /api/products?search=<query>` - Cari produk
- `GET /api/products/:id` - Detail produk
- `GET /api/products/top-rated` - Produk top-rated
- `GET /api/categories` - List kategori

### Orders (Memerlukan Token)
- `GET /api/orders` - List pesanan user
- `POST /api/orders` - Buat pesanan baru
- `GET /api/orders/:id` - Detail pesanan

---

## 👤 Akun Login Test

### Admin/User
- **Email:** `budi@gmail.com`
- **Password:** `123456`

Gunakan akun ini untuk login di aplikasi Flutter.

---

## 📂 Struktur Project

```
Project-Sayur/
├── backend-sayur/          # Laravel API
│   ├── app/
│   │   ├── Http/Controllers/Api/
│   │   ├── Models/
│   │   └── ...
│   ├── database/migrations/
│   ├── routes/api.php
│   └── ...
│
├── frontend/               # Flutter App
│   ├── lib/
│   │   ├── features/
│   │   ├── services/api_service.dart
│   │   ├── theme/
│   │   └── main.dart
│   ├── pubspec.yaml
│   └── ...
│
└── README.md
```

---

## 🐛 Troubleshooting

### Backend tidak terhubung
1. Pastikan Laravel server berjalan: `php artisan serve`
2. Cek API URL di `lib/services/api_service.dart`
3. Untuk Android: gunakan `http://10.0.2.2:8000/api`

### Login error "Email atau password salah"
- Pastikan akun sudah terdaftar di database
- Default akun: `budi@gmail.com` / `123456`

### Flutter tidak terhubung ke API
- Pastikan `baseUrl` sudah benar di `api_service.dart`
- Cek koneksi internet
- Lihat error di terminal dengan `flutter run -v`

### Database error
```bash
# Reset dan setup ulang
php artisan migrate:reset
php artisan migrate
```

---

## 📝 Catatan Pengembangan

- Aplikasi menggunakan **SharedPreferences** untuk menyimpan token lokal
- Profile user ditampilkan berdasarkan data yang di-login
- Order dan produk fetched dari backend API
- Tema dark/light mode tersedia

---

## 👨‍💻 Author
Project Sayur - Semester 6 APB

**Last Updated:** Juni 2026
