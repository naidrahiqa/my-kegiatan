# 🐛 Debug & Test Guide - Schedule TuneUp

## ✅ Prerequisites

- ✅ Flutter SDK installed at `C:\src\flutter`
- ✅ Android Studio installed
- ✅ Dependencies installed (`flutter pub get` ✅)

---

## 🚀 Method 1: Run dari Android Studio (RECOMMENDED)

### Step-by-step:

1. **Buka Android Studio**

   - Open project: `d:\IMPHNEN\schedule-tuneup`

2. **Start Android Emulator**

   - Di Android Studio → **Tools** → **Device Manager**
   - Pilih emulator yang tersedia → klik **▶️ Run**
   - Tunggu sampai emulator fully loaded

3. **Run App dalam Debug Mode**

   - Pilih device/emulator di dropdown atas (sebelah tombol Run)
   - Klik tombol **▶️ Run 'main.dart'** (atau tekan `Shift+F10`)
   - ATAU klik **🐛 Debug 'main.dart'** untuk debug mode dengan breakpoints

4. **Hot Reload saat Development**
   - Tekan `r` di terminal untuk hot reload
   - Tekan `R` untuk hot restart
   - Tekan `q` untuk quit

---

## 🔧 Method 2: Run dari Command Line

### Option A: Dengan Emulator

```powershell
# 1. Set PATH (temporary untuk session ini)
$env:Path += ";C:\src\flutter\bin"

# 2. Cek available emulators
flutter emulators

# 3. Launch emulator (tunggu sampai fully loaded)
flutter emulators --launch <EMULATOR_ID>

# 4. Tunggu ~30 detik, lalu run app
flutter run
```

### Option B: Dengan Physical Device

```powershell
# 1. Enable USB Debugging di Android phone:
#    Settings → About Phone → tap "Build Number" 7x
#    Settings → Developer Options → Enable "USB Debugging"

# 2. Connect phone ke PC via USB

# 3. Set PATH
$env:Path += ";C:\src\flutter\bin"

# 4. Verify device terdeteksi
adb devices
# Should show: <device_id>    device

# 5. Run app
flutter run
```

---

## 🐛 Debugging Features

### 1. **Hot Reload** (sambil app running)

```
Tekan 'r' → reload UI tanpa restart app
Tekan 'R' → restart app completely
```

### 2. **Debug dengan Breakpoints**

- Di Android Studio, klik di sebelah line number untuk set breakpoint
- Run with Debug mode (🐛 icon)
- App akan pause saat code mencapai breakpoint
- Inspect variables, step through code, dll

### 3. **Flutter DevTools**

```powershell
# Jalankan app dulu, lalu di terminal lain:
$env:Path += ";C:\src\flutter\bin"
flutter pub global activate devtools
flutter pub global run devtools
```

Fitur DevTools:

- **Widget Inspector**: lihat widget tree
- **Performance**: monitor FPS, memory usage
- **Network**: monitor API calls
- **Logging**: debug console
- **App Size**: analyze app size

### 4. **Print Debugging**

Tambahkan di code:

```dart
print('Debug: Variable value = $myVariable');
debugPrint('Important info');
```

Output akan muncul di console saat run.

---

## 🧪 Testing Commands

### Run Tests

```powershell
# Set PATH
$env:Path += ";C:\src\flutter\bin"

# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Check for Issues

```powershell
# Analyze code for issues
flutter analyze

# Check Flutter installation
flutter doctor -v
```

---

## 📱 Build APK untuk Testing

### Debug APK (untuk testing)

```powershell
flutter build apk --debug
# Output: build/app/outputs/flutter-apk/app-debug.apk
```

### Release APK (untuk distribution)

```powershell
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

Install APK ke device:

```powershell
adb install build/app/outputs/flutter-apk/app-debug.apk
```

---

## 🔍 Common Debug Scenarios

### Scenario 1: Debug UI Issues

1. Run dalam debug mode
2. Use **Flutter Inspector** di Android Studio/DevTools
3. Check widget properties, layout constraints
4. Use `Container` with border untuk visualize layout:

```dart
Container(
  decoration: BoxDecoration(border: Border.all(color: Colors.red)),
  child: YourWidget(),
)
```

### Scenario 2: Debug State Management

1. Add print statements di Provider methods
2. Check Provider flow: `notifyListeners()` called?
3. Use DevTools → Provider tab untuk inspect state

### Scenario 3: Debug Performance

1. Run di Release mode: `flutter run --release`
2. Check FPS di DevTools
3. Look for janky animations → use `PerformanceOverlay`:

```dart
MaterialApp(
  showPerformanceOverlay: true,
  // ...
)
```

### Scenario 4: Debug Crash/Errors

1. Check stack trace di console
2. Look for red error text
3. Common issues:
   - Null safety: add null checks `?.` or `??`
   - Async errors: wrap in try-catch
   - Widget lifecycle: use `mounted` check before `setState`

---

## 🎯 Quick Debug Workflow

1. **Make changes** di code
2. **Save** file (Ctrl+S)
3. **Hot reload** tekan `r`
4. **Test** perubahan di emulator
5. **Repeat** 🔄

For bigger changes (add packages, change assets):

- Tekan `R` untuk hot restart
- Or stop & re-run app

---

## 🛠️ Troubleshooting

### "No devices found"

- Start emulator dari Android Studio
- Or connect physical device dengan USB debugging enabled
- Run `adb devices` untuk verify

### "Gradle build failed"

```powershell
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### "License not accepted"

```powershell
flutter doctor --android-licenses
# Tekan 'y' untuk accept all
```

### App tidak update setelah hot reload

- Tekan `R` untuk hot restart
- Or stop app → re-run

---

## 📊 Monitor Log Output

Saat app running, lihat log untuk debug info:

```powershell
# View all logs
flutter logs

# Filter by tag
adb logcat -s flutter
```

---

## 🎉 Ready to Debug!

**Your app is ready for debugging!**

Choose your method:

- 🎨 **Android Studio** → visual debugging, breakpoints, inspector
- ⚡ **Command Line** → fast, lightweight
- 🔧 **DevTools** → advanced profiling

**Recommended:** Start dengan Android Studio method untuk best experience!

---

## 📞 Need Help?

Check these resources:

- [Flutter Debugging Docs](https://docs.flutter.dev/testing/debugging)
- [DevTools Guide](https://docs.flutter.dev/tools/devtools)
- [Android Studio Flutter Plugin](https://docs.flutter.dev/tools/android-studio)
