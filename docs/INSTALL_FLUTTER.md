# 🔧 Instalasi Flutter - Panduan Lengkap

## ⚠️ PENTING: Instalasi Flutter Diperlukan

Aplikasi ini memerlukan Flutter SDK untuk dijalankan. Ikuti langkah-langkah di bawah ini.

---

## 📥 Windows Installation (Recommended untuk Anda)

### Metode 1: Instalasi Manual (Recommended)

#### 1. Download Flutter SDK

1. Buka: https://docs.flutter.dev/get-started/install/windows
2. Download **Flutter SDK** (sekitar 1.2 GB)
3. Extract ke folder yang mudah diakses, contoh: `C:\src\flutter`

#### 2. Setup Environment Path

1. Buka **System Properties** (tekan `Win + Pause`)
2. Klik **Advanced system settings**
3. Klik **Environment Variables**
4. Di **User variables**, edit **Path**
5. Tambahkan: `C:\src\flutter\bin` (sesuaikan dengan lokasi Anda)
6. Klik **OK** sampai semua dialog tertutup

#### 3. Verifikasi Instalasi

```bash
# Buka Command Prompt atau PowerShell BARU
flutter --version

# Output akan menampilkan versi Flutter
```

#### 4. Install Android Studio

1. Download dari: https://developer.android.com/studio
2. Install dengan default settings
3. Buka Android Studio → **Configure** → **SDK Manager**
4. Install **Android SDK Platform-Tools** dan **Android SDK Build-Tools**

#### 5. Accept Android Licenses

```bash
flutter doctor --android-licenses
# Ketik 'y' untuk accept semua licenses
```

#### 6. Setup Android Emulator (Optional tapi Recommended)

1. Buka Android Studio
2. **Configure** → **AVD Manager**
3. **Create Virtual Device**
4. Pilih device (contoh: Pixel 6)
5. Pilih system image (contoh: API 33 - Android 13)
6. **Finish**

#### 7. Verify Setup

```bash
flutter doctor
```

**Output yang baik:**

```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x)
[✓] Android toolchain - develop for Android devices
[✓] Android Studio (version 2023.x)
[✓] VS Code (version 1.x.x)
[✓] Connected device (1 available)
[✓] Network resources

! Doctor found issues in 0 categories.
```

---

### Metode 2: Instalasi dengan Chocolatey (Advanced)

```bash
# 1. Install Chocolatey (Package Manager)
# Buka PowerShell sebagai Administrator dan jalankan:
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# 2. Install Flutter
choco install flutter

# 3. Verify
flutter --version
```

---

## 🍎 macOS Installation

```bash
# 1. Install Homebrew (jika belum)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install Flutter
brew install --cask flutter

# 3. Verify
flutter --version

# 4. Install Xcode (untuk iOS development)
# Download dari Mac App Store

# 5. Accept licenses
sudo xcodebuild -license
flutter doctor --android-licenses
```

---

## 🐧 Linux Installation

```bash
# 1. Download Flutter
cd ~/development
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.x.x-stable.tar.xz

# 2. Extract
tar xf flutter_linux_*.tar.xz

# 3. Add to PATH
echo 'export PATH="$PATH:~/development/flutter/bin"' >> ~/.bashrc
source ~/.bashrc

# 4. Verify
flutter --version

# 5. Install dependencies
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
```

---

## 🔧 Install IDE (Pilih Salah Satu)

### VS Code (Lightweight, Recommended)

1. Download: https://code.visualstudio.com/
2. Install
3. Buka VS Code
4. Install extensions:
   - **Flutter** (by Dart Code)
   - **Dart** (by Dart Code)

### Android Studio (Full Featured)

1. Download: https://developer.android.com/studio
2. Install
3. Buka Android Studio
4. **Plugins** → Install:
   - **Flutter**
   - **Dart**

---

## 🚀 Menjalankan Aplikasi Schedule TuneUp

### Setelah Flutter Terinstall:

```bash
# 1. Masuk ke folder project
cd d:\IMPHNEN\schedule-tuneup

# 2. Install dependencies
flutter pub get

# 3. Check devices
flutter devices

# 4. Run aplikasi
flutter run

# Atau pilih device spesifik:
flutter run -d windows    # Windows desktop
flutter run -d chrome     # Web browser
flutter run -d emulator   # Android emulator
```

---

## 📱 Running Options

### 1. Android Emulator (Recommended untuk Testing)

```bash
# Start emulator dari command line
emulator -avd Pixel_6_API_33

# Di terminal lain, run app
cd d:\IMPHNEN\schedule-tuneup
flutter run
```

### 2. Windows Desktop

```bash
# Enable windows desktop
flutter config --enable-windows-desktop

# Run
flutter run -d windows
```

### 3. Web Browser

```bash
# Enable web
flutter config --enable-web

# Run
flutter run -d chrome
```

### 4. Physical Device (Android)

1. Aktifkan **Developer Options** di Android
2. Aktifkan **USB Debugging**
3. Sambungkan ke PC via USB
4. Run `flutter devices` (device akan muncul)
5. Run `flutter run`

---

## 🐛 Troubleshooting

### Flutter tidak recognize di command line

**Solusi**: Restart terminal/command prompt setelah menambahkan PATH

### Android licenses belum di-accept

```bash
flutter doctor --android-licenses
# Ketik 'y' untuk semua
```

### No devices available

**Solusi**:

1. Pastikan emulator running, ATAU
2. Enable Windows desktop: `flutter config --enable-windows-desktop`
3. Enable web: `flutter config --enable-web`

### Build errors

```bash
# Clean & rebuild
flutter clean
flutter pub get
flutter run
```

### VS Code not detecting Flutter

**Solusi**:

1. Reload VS Code (Ctrl+Shift+P → "Reload Window")
2. Check Flutter extension installed
3. Run `Flutter: Run Flutter Doctor` dari command palette

---

## ✅ Verification Checklist

Pastikan semua ini ✓:

- [ ] `flutter --version` shows version number
- [ ] `flutter doctor` shows no errors (warnings OK)
- [ ] Android Studio installed (untuk Android development)
- [ ] At least 1 device available (`flutter devices`)
- [ ] IDE (VS Code/Android Studio) installed with Flutter plugin
- [ ] `flutter pub get` runs successfully

---

## 📞 Need Help?

### Official Resources:

- Flutter Docs: https://docs.flutter.dev/
- Flutter Discord: https://discord.gg/flutter
- Stack Overflow: https://stackoverflow.com/questions/tagged/flutter

### Common Issues:

- Google: "flutter [your error message]"
- Check: https://docs.flutter.dev/development/tools/sdk/releases
- Update Flutter: `flutter upgrade`

---

## 🎓 Next Steps

Setelah Flutter terinstall:

1. ✅ Run `flutter doctor` (pastikan semua ✓)
2. ✅ Masuk ke folder project
3. ✅ Run `flutter pub get`
4. ✅ Run `flutter run`
5. ✅ Enjoy Schedule TuneUp! 🎉

---

**Happy Coding with Flutter! 💙🚀**

---

_Note: Proses instalasi Flutter pertama kali bisa memakan waktu 30-60 menit tergantung kecepatan internet dan spesifikasi komputer._
