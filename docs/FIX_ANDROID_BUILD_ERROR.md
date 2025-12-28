# Cara Mengatasi Error Android Build

## Error yang Terjadi

```
Could not create task ':path_provider_android:compileDebugUnitTestSources'.
this and base files have different roots: D:\IMPHNEN\schedule-tuneup\build\path_provider_android
and C:\Users\CASTORICE\AppData\Local\Pub\Cache\hosted\pub.dev\path_provider_android-2.2.22\android.
```

## Penyebab

Error ini terjadi karena konflik path antara build folder lokal dan cache Pub. Biasanya terjadi setelah:

- Update dependency
- Move project ke folder lain
- Corrupted build cache

## Solusi

### Opsi 1: Menggunakan Flutter CLI (Recommended)

Jika Flutter sudah terinstall dan ada di PATH:

```bash
# 1. Bersihkan build cache
flutter clean

# 2. Install ulang dependencies
flutter pub get

# 3. Rebuild project
flutter run
```

### Opsi 2: Manual Clean (Jika Flutter CLI tidak tersedia)

Jika command `flutter` tidak dikenali di terminal (seperti kasus ini):

#### **Langkah 1: Hapus Folder Cache (✅ SUDAH DILAKUKAN)**

```powershell
# Dari folder project
Remove-Item -Path "build" -Recurse -Force
Remove-Item -Path ".dart_tool" -Recurse -Force
Remove-Item -Path "android/.gradle" -Recurse -Force
```

#### **Langkah 2: Rebuild di IDE**

**Untuk VS Code:**

1. Buka Command Palette (`Ctrl+Shift+P`)
2. Ketik dan pilih: `Flutter: Clean`
3. Kemudian: `Flutter: Pub Get`
4. Tekan `F5` untuk run

**Untuk Android Studio:**

1. Menu **Tools** → **Flutter** → **Flutter Clean**
2. Menu **Tools** → **Flutter** → **Flutter Pub Get**
3. Klik tombol **Run** (▶️)

**Untuk IntelliJ IDEA:**

1. Klik kanan pada `pubspec.yaml`
2. Pilih **Flutter** → **Flutter Clean**
3. Pilih **Flutter** → **Flutter Pub Get**
4. Run project

#### **Langkah 3: Rebuild Gradle (Jika masih error)**

Buka terminal di folder `android/`:

```bash
cd android
./gradlew clean
./gradlew build
cd ..
```

Di Windows PowerShell:

```powershell
cd android
.\gradlew.bat clean
.\gradlew.bat build
cd ..
```

### Opsi 3: Setup Flutter PATH (Solusi Permanen)

Agar command `flutter` bisa dipakai di terminal:

**Windows:**

1. Cari lokasi instalasi Flutter (contoh: `C:\flutter`)
2. Buka **System Properties** → **Environment Variables**
3. Edit variable **Path**
4. Tambahkan: `C:\flutter\bin` (sesuaikan dengan lokasi Flutter Anda)
5. Klik **OK**
6. Restart terminal / IDE

**Verify:**

```powershell
flutter --version
```

## Troubleshooting Lanjutan

### Jika masih error setelah clean:

1. **Hapus Pub Cache secara manual:**

   ```powershell
   # Windows
   Remove-Item -Path "$env:APPDATA\Pub\Cache" -Recurse -Force

   # Kemudian pub get ulang
   flutter pub get
   ```

2. **Update Flutter dan dependencies:**

   ```bash
   flutter upgrade
   flutter pub upgrade
   ```

3. **Invalidate IDE Cache:**

   - **Android Studio**: File → Invalidate Caches → Invalidate and Restart
   - **VS Code**: Reload window (Ctrl+Shift+P → Reload Window)

4. **Reinstall path_provider:**
   ```bash
   flutter pub remove shared_preferences path_provider
   flutter pub add shared_preferences path_provider
   ```

## Prevention (Mencegah Error di Masa Depan)

1. **Selalu clean sebelum build release:**

   ```bash
   flutter clean && flutter pub get
   ```

2. **Jangan move project saat build sedang berlangsung**

3. **Update dependencies secara teratur:**

   ```bash
   flutter pub upgrade
   ```

4. **Gunakan version lock di pubspec.yaml untuk production**

## Status Saat Ini

✅ **Build cache sudah dibersihkan!**

- Folder `build/` - Deleted
- Folder `.dart_tool/` - Deleted
- Folder `android/.gradle` - Deleted

## Next Steps

1. **Buka IDE Anda** (VS Code / Android Studio / IntelliJ)
2. **Jalankan Flutter: Pub Get** melalui command palette atau menu
3. **Run project** dengan menekan F5 atau tombol Run
4. Build seharusnya berjalan normal sekarang! 🚀

## Catatan

- Color palette update **TIDAK menyebabkan** error Android build ini
- Error ini murni masalah Gradle/cache, bukan dari perubahan kode
- Semua kode yang sudah diupdate tetap aman dan benar

---

**Last Updated**: 2025-12-28  
**Status**: ✅ Cache Cleaned - Ready to Rebuild
