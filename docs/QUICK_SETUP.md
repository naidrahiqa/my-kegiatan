# ⚡ QUICK SETUP - Flutter Installation Commands

## 🎯 Untuk Anda yang ingin CEPAT!

Ikuti langkah ini **SATU PER SATU**:

---

## 1️⃣ Download Flutter SDK

**Buka link ini di browser:**

```
https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip
```

**Tunggu sampai download selesai** (~1.2 GB)

---

## 2️⃣ Extract Flutter

Setelah download selesai, jalankan di PowerShell:

```powershell
# Buat folder src
New-Item -Path "C:\src" -ItemType Directory -Force

# Extract (ganti path Downloads jika berbeda)
Expand-Archive -Path "$env:USERPROFILE\Downloads\flutter_windows_*-stable.zip" -DestinationPath "C:\src" -Force
```

---

## 3️⃣ Tambahkan ke PATH

**Di PowerShell (sebagai Administrator):**

```powershell
# Tambah Flutter ke PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
$flutterPath = "C:\src\flutter\bin"

if ($currentPath -notlike "*$flutterPath*") {
    [Environment]::SetEnvironmentVariable(
        "Path",
        "$currentPath;$flutterPath",
        "User"
    )
    Write-Host "✅ Flutter PATH added successfully!" -ForegroundColor Green
} else {
    Write-Host "✅ Flutter PATH already exists!" -ForegroundColor Yellow
}
```

---

## 4️⃣ Verify Installation

**TUTUP PowerShell lama, BUKA yang BARU, lalu:**

```bash
flutter --version
```

**Jika berhasil, akan muncul:**

```
Flutter 3.24.5 • channel stable • https://github.com/flutter/flutter.git
Framework • revision xxxxx
Engine • revision xxxxx
Tools • Dart 3.5.4 • DevTools 2.37.3
```

---

## 5️⃣ Install Android Studio

**Download & Install:**

1. Buka: https://developer.android.com/studio
2. Download Android Studio
3. Install dengan **default settings**
4. Buka Android Studio setelah install
5. Complete setup wizard (download SDK, etc)

---

## 6️⃣ Accept Licenses

```bash
flutter doctor --android-licenses
```

**Tekan `y` untuk semua!**

---

## 7️⃣ Setup Emulator (OPTIONAL)

Di Android Studio:

1. **Configure** → **AVD Manager**
2. **Create Virtual Device**
3. Pilih **Pixel 6**
4. System Image: **API 33 (Android 13)**
5. **Finish**

---

## 8️⃣ Final Check

```bash
flutter doctor -v
```

**Target:**

- ✅ Flutter
- ✅ Android toolchain
- ✅ Android Studio

---

## 9️⃣ Jalankan Schedule TuneUp!

```bash
cd d:\IMPHNEN\schedule-tuneup
flutter pub get
flutter run
```

**DONE! 🎉**

---

## 🆘 Jika Masih Error

### Error: "flutter is not recognized"

1. Pastikan file ada di: `C:\src\flutter\bin\flutter.bat`
2. **TUTUP PowerShell lama**
3. **BUKA PowerShell BARU**
4. Coba lagi: `flutter --version`

### Error: "No devices available"

**Enable Windows Desktop:**

```bash
flutter config --enable-windows-desktop
flutter run -d windows
```

### Error: Build failed

```bash
flutter clean
flutter pub get
flutter run
```

---

## 📞 Still Stuck?

Baca file lengkapnya:

- **INSTALL_STEP_BY_STEP.md** (detailed guide)
- **INSTALL_FLUTTER.md** (comprehensive guide)

---

**Good Luck! 💪**
