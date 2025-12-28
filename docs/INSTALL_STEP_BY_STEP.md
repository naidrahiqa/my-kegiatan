# 🚀 INSTALL FLUTTER - STEP BY STEP (Windows)

## ⚠️ IKUTI LANGKAH INI DENGAN URUT!

---

## 📥 STEP 1: Download Flutter SDK

### Option A: Download Manual (RECOMMENDED)

1. Buka browser
2. Kunjungi: https://docs.flutter.dev/get-started/install/windows/mobile
3. Klik **"Download Flutter SDK"** (besar biru)
4. Simpan file `flutter_windows_3.x.x-stable.zip` (~1.2 GB)

### Option B: Direct Link

Download langsung: https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip

**⏱️ Tunggu sampai download selesai (~1.2 GB)**

---

## 📂 STEP 2: Extract Flutter

### Recommended Location:

```
C:\src\flutter
```

### Cara Extract:

1. Buka folder `Downloads`
2. Klik kanan file `flutter_windows_xxx.zip`
3. Pilih **"Extract All..."**
4. Browse ke `C:\` → Buat folder baru `src`
5. Extract ke `C:\src\`
6. Setelah extract, folder akan menjadi: `C:\src\flutter`

### ⚠️ PENTING:

- Pastikan path-nya: `C:\src\flutter\bin\flutter.bat` ✅
- **JANGAN** extract ke `C:\Program Files\` ❌
- **JANGAN** extract ke folder dengan spasi ❌

---

## 🔧 STEP 3: Tambahkan ke PATH

### Cara 1: Via Environment Variables (GUI)

1. **Buka Environment Variables:**

   - Tekan `Win + Pause` → **Advanced system settings**
   - ATAU search "Environment Variables" di Start Menu
   - Klik **"Environment Variables"**

2. **Edit User PATH:**
   - Di **User variables**, pilih **Path**
   - Klik **Edit**
   - Klik **New**
   - Ketik: `C:\src\flutter\bin`
   - Klik **OK** sampai semua dialog tertutup

### Cara 2: Via PowerShell (QUICK)

Jalankan di PowerShell sebagai **Administrator**:

```powershell
[Environment]::SetEnvironmentVariable(
    "Path",
    [Environment]::GetEnvironmentVariable("Path", "User") + ";C:\src\flutter\bin",
    "User"
)
```

---

## ✅ STEP 4: Verify Installation

### PENTING: Buka PowerShell/CMD BARU!

```bash
# Tutup PowerShell yang lama, buka yang baru
# Kemudian jalankan:

flutter --version
```

**Output yang benar:**

```
Flutter 3.x.x • channel stable
Framework • revision xxxxx
Engine • revision xxxxx
Tools • Dart 3.x.x
```

**Jika masih error "not recognized":**

- Pastikan Anda buka PowerShell/CMD **BARU** (setelah edit PATH)
- Restart komputer jika perlu
- Verify path: `echo $env:Path` (cek apakah ada C:\src\flutter\bin)

---

## 🤖 STEP 5: Install Android Studio (untuk Android Development)

### Download:

https://developer.android.com/studio

### Install:

1. Jalankan installer
2. Gunakan **default settings** (Next, Next, Next)
3. Wait sampai download components selesai (~2-3 GB)

### Setup Android SDK:

1. Buka Android Studio
2. **Configure** (di welcome screen) → **SDK Manager**
3. Pastikan terinstall:
   - ✅ Android SDK Platform-Tools
   - ✅ Android SDK Build-Tools
   - ✅ Android SDK Command-line Tools

---

## ⚖️ STEP 6: Accept Android Licenses

```bash
flutter doctor --android-licenses
```

**Tekan `y` untuk accept semua licenses**

---

## 📱 STEP 7: Setup Emulator (OPTIONAL tapi RECOMMENDED)

### Buat Virtual Device:

1. Buka Android Studio
2. **Configure** → **AVD Manager**
3. **Create Virtual Device**
4. Pilih device: **Pixel 6** (atau yang lain)
5. Pilih system image: **API 33 - Android 13** (Tiramisu)
6. Next → **Finish**

### Start Emulator:

- Klik ▶️ Play button di AVD Manager
- Tunggu emulator booting (~1-2 menit pertama kali)

---

## 🔍 STEP 8: Flutter Doctor Check

```bash
flutter doctor
```

**Target Output:**

```
Doctor summary:
[✓] Flutter (Channel stable, 3.x.x)
[✓] Android toolchain - develop for Android devices
[✓] Android Studio (version 2023.x)
[!] VS Code (optional)
[✓] Connected device (jika emulator running)
[✓] Network resources

! Doctor found issues in 0-1 categories.
```

**⚠️ Abaikan warning tentang:**

- VS Code (optional)
- Chrome (optional untuk web)

**✅ Yang PENTING harus centang:**

- Flutter
- Android toolchain
- Android Studio

---

## 🚀 STEP 9: Jalankan Schedule TuneUp!

```bash
# Masuk ke folder project
cd d:\IMPHNEN\schedule-tuneup

# Install dependencies
flutter pub get

# Check devices
flutter devices

# Jalankan aplikasi!
flutter run
```

**Pilih device:**

- Jika ada emulator: Pilih Android emulator
- Atau: `flutter run -d windows` (Windows desktop)
- Atau: `flutter run -d chrome` (Web browser)

---

## 🐛 TROUBLESHOOTING

### ❌ "flutter is not recognized"

**Solusi:**

1. Pastikan PATH sudah ditambahkan: `C:\src\flutter\bin`
2. **TUTUP dan BUKA PowerShell BARU**
3. Restart komputer jika perlu
4. Cek path: `echo $env:Path`

### ❌ "cmdline-tools component is missing"

**Solusi:**

```bash
flutter doctor --android-licenses
```

### ❌ "No devices available"

**Solusi:**

1. Start Android Emulator di Android Studio
2. Atau enable Windows desktop:
   ```bash
   flutter config --enable-windows-desktop
   ```

### ❌ "Unable to locate Android SDK"

**Solusi:**

```bash
flutter config --android-sdk "C:\Users\YourUsername\AppData\Local\Android\Sdk"
```

### ❌ Build errors

**Solusi:**

```bash
flutter clean
flutter pub get
flutter run
```

---

## ⏱️ ESTIMASI WAKTU

| Step                             | Waktu            |
| -------------------------------- | ---------------- |
| Download Flutter (~1.2GB)        | 5-20 menit       |
| Extract                          | 2-5 menit        |
| Setup PATH                       | 2 menit          |
| Download Android Studio (~2-3GB) | 10-30 menit      |
| Install & Setup                  | 10-15 menit      |
| Create Emulator                  | 5-10 menit       |
| **TOTAL**                        | **~40-90 menit** |

---

## ✅ CHECKLIST

Centang setiap step yang sudah selesai:

- [ ] Download Flutter SDK
- [ ] Extract ke C:\src\flutter
- [ ] Tambah C:\src\flutter\bin ke PATH
- [ ] Buka PowerShell baru & test `flutter --version`
- [ ] Download & Install Android Studio
- [ ] Accept Android licenses
- [ ] Create Android Emulator
- [ ] Run `flutter doctor` (semua ✓)
- [ ] cd ke folder project
- [ ] Run `flutter pub get`
- [ ] Run `flutter run`
- [ ] 🎉 **APLIKASI JALAN!**

---

## 📞 Butuh Bantuan?

Jika ada error di step manapun:

1. Screenshot error-nya
2. Cek step mana yang gagal
3. Baca TROUBLESHOOTING di atas
4. Google error message-nya

---

## 🎯 NEXT SETELAH FLUTTER INSTALLED

Setelah `flutter --version` berhasil:

```bash
cd d:\IMPHNEN\schedule-tuneup
flutter pub get
flutter run
```

**Dan aplikasi Schedule TuneUp akan berjalan! 🎉**

---

_Good luck! You got this! 💪_
