# 🚀 Quick Start Guide - Schedule TuneUp

## Instalasi Cepat

### 1️⃣ Install Flutter (Jika belum)

**Windows:**

1. Download Flutter SDK: https://flutter.dev/docs/get-started/install/windows
2. Extract ke `C:\src\flutter`
3. Tambahkan ke PATH: `C:\src\flutter\bin`
4. Buka terminal baru dan jalankan:
   ```bash
   flutter doctor
   ```

**macOS:**

```bash
# Install dengan Homebrew
brew install flutter

# Atau download manual dari flutter.dev
```

**Linux:**

```bash
# Download dan extract
cd ~/development
tar xf flutter_linux_*.tar.xz

# Tambahkan ke PATH di ~/.bashrc
export PATH="$PATH:`pwd`/flutter/bin"
```

### 2️⃣ Setup Android Studio / VS Code

**Android Studio:**

1. Install Android Studio
2. Install Flutter & Dart plugins
3. Setup Android SDK

**VS Code:**

1. Install VS Code
2. Install extensions:
   - Flutter
   - Dart

### 3️⃣ Jalankan Aplikasi

```bash
# Masuk ke direktori project
cd d:\IMPHNEN\schedule-tuneup

# Install dependencies
flutter pub get

# Cek devices yang tersedia
flutter devices

# Jalankan aplikasi
flutter run
```

## 📱 Panduan Penggunaan Cepat

### Pertama Kali Membuka Aplikasi

1. **Aplikasi akan terbuka dengan tampilan kosong** (belum ada aktivitas)
2. **Tap tombol + (plus)** di pojok kanan atas
3. **Isi form aktivitas:**
   - Judul: "Pagi Olahraga"
   - Deskripsi: "Jogging 30 menit"
   - Kategori: Kesehatan
   - Waktu: 06:00
   - Durasi: 30 menit
   - Prioritas: Tinggi
4. **Tap "Tambah Aktivitas"**

### Mengelola Aktivitas

**Tandai Selesai:**

- Tap ✓ checkbox pada card aktivitas

**Lihat Detail:**

- Tap pada card aktivitas

**Edit:**

- Buka detail → Tap tombol "Edit"

**Hapus:**

- Swipe kiri pada card, ATAU
- Buka detail → Tap "Hapus"

### Tips Produktivitas

1. **Pagi Hari**: Buat 3-5 aktivitas penting untuk hari itu
2. **Set Prioritas**: Tandai yang urgent dengan prioritas TINGGI
3. **Realistic Duration**: Set durasi yang realistis
4. **Check Progress**: Lihat tab Analitik untuk tracking
5. **Konsultasi AI**: Tanya AI untuk saran produktivitas

## 🎯 Contoh Jadwal Harian

### Routine Produktif

```
06:00 - 06:30 | Olahraga Pagi (Kesehatan) - Prioritas: Tinggi
07:00 - 08:00 | Sarapan & Persiapan (Personal) - Prioritas: Sedang
08:00 - 12:00 | Deep Work (Pekerjaan) - Prioritas: Tinggi
12:00 - 13:00 | Istirahat Makan Siang (Personal) - Prioritas: Sedang
13:00 - 17:00 | Meeting & Tasks (Pekerjaan) - Prioritas: Sedang
17:00 - 18:00 | Belajar Skill Baru (Belajar) - Prioritas: Tinggi
18:00 - 19:00 | Waktu Keluarga (Sosial) - Prioritas: Tinggi
19:00 - 20:00 | Makan Malam (Personal) - Prioritas: Rendah
20:00 - 21:00 | Review & Planning (Pekerjaan) - Prioritas: Sedang
```

## 💬 Chat AI - Contoh Pertanyaan

**Analisis Jadwal:**

```
"Bagaimana jadwal saya hari ini?"
"Analisis efektivitas rutinitas saya"
```

**Saran Produktivitas:**

```
"Berikan saran produktivitas"
"Bagaimana cara meningkatkan fokus?"
"Tips menghindari prokrastinasi"
```

**Manajemen Waktu:**

```
"Kapan waktu terbaik untuk belajar?"
"Berapa lama sebaiknya waktu istirahat?"
"Tips time blocking yang efektif"
```

**Motivasi:**

```
"Berikan motivasi"
"Saya merasa overwhelmed, apa yang harus dilakukan?"
```

## 🎨 Kustomisasi

### Ubah ke Light Mode

1. Tap icon 🌙/☀️ di pojok kanan atas (ScheduleScreen)
2. Tema akan berubah dan tersimpan otomatis

### Filter Kategori

Di ScheduleScreen, scroll horizontal untuk filter berdasarkan kategori:

- Semua
- Pekerjaan
- Kesehatan
- Personal
- Belajar
- Sosial
- Lainnya

## 🔧 Troubleshooting Cepat

### Aplikasi tidak bisa run

```bash
flutter clean
flutter pub get
flutter run
```

### Hot reload tidak bekerja

Tekan `r` di terminal atau `R` untuk full restart

### Build error

```bash
# Update Flutter
flutter upgrade

# Repair dependencies
flutter pub cache repair
flutter pub get
```

### Database error

Uninstall dan install ulang aplikasi

## 📊 Memahami Analitik

### Dashboard Statistik

**Total Aktivitas**: Jumlah aktivitas terjadwal hari ini
**Total Waktu**: Total menit yang dialokasikan
**Selesai**: Aktivitas yang sudah dikerjakan
**Pending**: Aktivitas yang belum selesai

**Tingkat Penyelesaian**:

- < 50% = Perlu improvement
- 50-80% = Good job!
- > 80% = Excellent! 🎉

**Distribusi Kategori**:
Melihat balance antara berbagai aspek kehidupan

## 🌟 Best Practices

### 1. Morning Routine

- Buat jadwal di pagi hari
- Prioritaskan 3 tugas terpenting
- Alokasikan waktu realistis

### 2. Time Blocking

- Block waktu untuk deep work
- Jangan multitasking
- Sisakan buffer time

### 3. Evening Review

- Review di malam hari
- Lihat completion rate
- Plan untuk esok hari

### 4. Weekly Planning

- Setiap Minggu, evaluasi progress
- Adjust strategi jika perlu
- Set goals untuk minggu depan

## 📞 Butuh Bantuan?

1. **Baca README.md** untuk dokumentasi lengkap
2. **Baca DEVELOPMENT.md** untuk pengembangan lebih lanjut
3. **Chat dengan AI di app** untuk tips produktivitas
4. **Create issue** di repository jika menemukan bug

---

**Selamat menggunakan Schedule TuneUp! 🎯✨**

Mulai hari ini dengan lebih terstruktur dan produktif!
