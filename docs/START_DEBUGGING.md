# 🐛 DEBUGGING GUIDE - Start Here!

## ⚠️ Current Issue

Ada masalah dengan **Gradle build** saat compile APK via command line. Ini kemungkinan karena:

- Java version compatibility
- Gradle daemon issues
- NDK configuration

## **SOLUSI RECOMMENDED: Pakai Android Studio** ✅

### ✅ Method 1: Run dari Android Studio (PALING MUDAH!)

1. **Buka Android Studio**

   - File → Open → Pilih folder: `d:\IMPHNEN\schedule-tuneup`

2. **Trust the Project**

   - Klik "Trust Project" kalau ditanya

3. **Wait for Indexing**

   - Tunggu Android Studio selesai index project (progress di bawah)

4. **Setup Device**

   - Di toolbar atas, pilih dropdown device
   - Pilih HP kamu (`23053RN02A`) atau emulator
   - Kalau device tidak muncul:
     - Pastikan HP connected via USB
     - USB Debugging enabled
     - Klik refresh icon di device dropdown

5. **Run App**
   - Klik tombol **▶️ Run 'main.dart'** (hijau, di toolbar atas)
   - Atau tekan **Shift + F10**
6. **Wait for Build**

   - First build akan lama (5-10 menit)
   - Android Studio lebih reliable untuk build pertama kali
   - Progress ditampilkan di **Build** tab bawah

7. **App Running!** 🎉
   - App akan otomatis install & launch di HP/emulator
   - Sekarang bisa dev dengan **Hot Reload**!

### 🔧 Debug Mode Features di Android Studio:

1. **Hot Reload** - Edit code, save, langsung lihat perubahan
   - Cara 1: Klik icon 🔥 (lightning bolt) di toolbar
   - Cara 2: Tekan **Ctrl + S** (auto hot reload)
2. **Hot Restart** - Restart app dari awal

   - Klik icon ♻️ di toolbar
   - Atau tekan **Ctrl + Shift + \\**

3. **Set Breakpoints**
   - Klik di sebelah line number
   - Run dalam Debug mode (🐛 icon)
   - App akan pause di breakpoint
4. **Flutter Inspector**

   - View → Tool Windows → Flutter Inspector
   - Lihat widget tree, properties, layout

5. **Logcat** (Android logs)
   - View → Tool Windows → Logcat
   - Filter by package: `schedule_tuneup`

---

## 🔄 Method 2: Fix Command Line Build

Kalau tetap mau run dari command line, coba steps ini:

### Step 1: Verify Java Version

```powershell
java -version
# Should show Java 17 or higher
```

Kalau bukan Java 17, download dari Android Studio:

- Settings → Build, Execution, Deployment → Build Tools → Gradle
- Gunakan embedded JDK

### Step 2: Set JAVA_HOME

```powershell
# Check Android Studio's JDK location, usually:
$env:JAVA_HOME = "C:\Program Files\Android\Android Studio\jbr"
$env:Path = "$env:JAVA_HOME\bin;$env:Path"
```

### Step 3: Clean & Rebuild

```powershell
$env:Path += ";C:\src\flutter\bin"
flutter clean
flutter pub get
flutter run
```

### Step 4: If Still Failing - Manual Gradle Build

```powershell
cd android
./gradlew clean
./gradlew assembleDebug --warning-mode all
```

---

## 📱 Method 3: Build APK & Install Manual

Kalau semua gagal, build APK dan install manual:

```powershell
# Build APK
$env:Path += ";C:\src\flutter\bin"
flutter build apk --debug

# Install ke HP
adb install -r build\app\outputs\flutter-apk\app-debug.apk

# Launch app (ganti dengan package name yang benar)
adb shell am start -n com.example.schedule_tuneup/.MainActivity
```

---

## 🎯 Quick Troubleshooting

| Problem                  | Solution                                                                                             |
| ------------------------ | ---------------------------------------------------------------------------------------------------- |
| "SDK location not found" | Di `android/local.properties`, set:<br>`sdk.dir=C:\\Users\\<USERNAME>\\AppData\\Local\\Android\\Sdk` |
| "License not accepted"   | Run: `flutter doctor --android-licenses`                                                             |
| "Gradle build failed"    | Use Android Studio (lebih reliable!)                                                                 |
| "No devices"             | `adb devices` untuk check connection                                                                 |
| Device unauthorized      | Di HP, allow USB debugging permission                                                                |

---

## ✅ RECOMMENDED WORKFLOW

Untuk development yang smooth:

1. **First Build**: Pakai **Android Studio** → paling reliable
2. **Daily Dev**: Bisa pakai command line **ATAU** Android Studio
3. **Debugging**: Selalu pakai **Android Studio** → best tools
4. **Release Build**: Command line OK (`flutter build apk --release`)

---

## 🚀 After Success First Run

Setelah berhasil run pertama kali dari Android Studio:

**Hot Reload Development:**

```
1. Edit code di VS Code atau Android Studio
2. Save file (Ctrl + S)
3. Perubahan langsung terlihat di app! ⚡
```

**No need to rebuild** untuk UI changes - hot reload super cepat!

---

## 📞 Still Having Issues?

1. Check `flutter doctor -v` → pastikan semua ✅
2. Restart Android Studio
3. Invalidate Caches (File → Invalidate Caches → Restart)
4. Try emulator instead of physical device
5. Check firewall/antivirus tidak block Gradle download

---

## 🎉 Next Steps After App Running

Once app berhasil running, check out:

- `DEBUG_GUIDE.md` → debugging features
- `DEVELOPMENT.md` → development workflow
- `PROJECT_STRUCTURE.md` → codebase structure

Happy Coding! 🚀
