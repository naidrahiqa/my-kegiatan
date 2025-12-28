# Schedule TuneUp - Panduan Pengembangan

## 📋 Daftar Isi

1. [Arsitektur Aplikasi](#arsitektur-aplikasi)
2. [State Management](#state-management)
3. [Database](#database)
4. [AI Integration](#ai-integration)
5. [Menambah Fitur Baru](#menambah-fitur-baru)

## 🏗️ Arsitektur Aplikasi

Aplikasi ini menggunakan arsitektur **Provider Pattern** dengan separasi yang jelas:

```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│    (Screens & Widgets)              │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│         Business Logic Layer        │
│         (Providers)                 │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│         Data Layer                  │
│    (Models, Services, Database)     │
└─────────────────────────────────────┘
```

### Komponen Utama:

1. **Models**: Data structures (Activity, ChatMessage)
2. **Providers**: State management (ScheduleProvider, ThemeProvider, ChatProvider)
3. **Services**: Business logic (AIService)
4. **Utils**: Helper functions (DatabaseHelper)
5. **Screens**: UI pages
6. **Widgets**: Reusable components

## 🔄 State Management

Menggunakan **Provider** package:

### ScheduleProvider

```dart
// Mengelola:
- List aktivitas
- Selected date
- Filtered activities
- Statistics (completion rate, etc)

// Methods utama:
- loadActivities()
- addActivity(Activity)
- updateActivity(Activity)
- deleteActivity(String id)
- toggleActivityCompletion(String id)
```

### ThemeProvider

```dart
// Mengelola:
- Dark/Light mode
- Persistent theme storage

// Methods:
- toggleTheme()
```

### ChatProvider

```dart
// Mengelola:
- Chat messages
- Loading state

// Methods:
- sendMessage(String, ScheduleProvider)
- clearMessages()
```

## 💾 Database

Menggunakan **SQLite** melalui `sqflite` package.

### Schema

```sql
CREATE TABLE activities (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  scheduledTime TEXT NOT NULL,
  durationMinutes INTEGER NOT NULL,
  category TEXT NOT NULL,
  isCompleted INTEGER NOT NULL,
  notes TEXT,
  priority INTEGER NOT NULL,
  isRecurring INTEGER NOT NULL,
  recurrenceType TEXT,
  recurringDays TEXT
)
```

### CRUD Operations

```dart
// Create
await DatabaseHelper.instance.insertActivity(activity);

// Read
List<Activity> activities = await DatabaseHelper.instance.getAllActivities();

// Update
await DatabaseHelper.instance.updateActivity(activity);

// Delete
await DatabaseHelper.instance.deleteActivity(id);
```

## 🤖 AI Integration

### Current Implementation

Saat ini menggunakan **rule-based AI** yang sederhana namun efektif:

```dart
AIService
├── _analyzeSchedule()      // Analisis jadwal
├── _getProductivityTips()  // Tips produktivitas
├── _getTimeManagementAdvice() // Saran waktu
└── _getMotivation()        // Motivasi
```

### Upgrade ke Google Gemini AI

1. Install dependency (sudah ada di pubspec.yaml):

   ```yaml
   google_generative_ai: ^0.2.2
   ```

2. Dapatkan API key dari Google AI Studio

3. Uncomment kode di `lib/services/ai_service.dart`

4. Implementasi custom prompts untuk response yang lebih personal

## ➕ Menambah Fitur Baru

### 1. Menambah Screen Baru

```dart
// 1. Buat file di lib/screens/
// lib/screens/new_screen.dart

import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Screen')),
      body: Center(child: Text('New Screen')),
    );
  }
}

// 2. Tambahkan ke navigation di home_screen.dart
final List<Widget> _screens = const [
  ScheduleScreen(),
  CalendarScreen(),
  ChatScreen(),
  AnalyticsScreen(),
  NewScreen(), // <-- Tambahkan di sini
];
```

### 2. Menambah Field di Activity Model

```dart
// 1. Update model (lib/models/activity.dart)
class Activity {
  // ... existing fields
  final String? newField; // Tambah field baru

  Activity({
    // ... existing params
    this.newField,
  });

  // Update toMap()
  Map<String, dynamic> toMap() {
    return {
      // ... existing fields
      'newField': newField,
    };
  }

  // Update fromMap()
  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      // ... existing fields
      newField: map['newField'],
    );
  }
}

// 2. Update database schema (lib/utils/database_helper.dart)
Future<void> _createDB(Database db, int version) async {
  await db.execute('''
    CREATE TABLE activities (
      -- ... existing columns
      newField TEXT
    )
  ''');
}

// 3. Update UI untuk input field baru
```

### 3. Menambah Provider Baru

```dart
// 1. Buat file provider (lib/providers/new_provider.dart)
import 'package:flutter/material.dart';

class NewProvider extends ChangeNotifier {
  String _data = '';

  String get data => _data;

  void updateData(String newData) {
    _data = newData;
    notifyListeners();
  }
}

// 2. Register di main.dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => ScheduleProvider()),
    ChangeNotifierProvider(create: (_) => ChatProvider()),
    ChangeNotifierProvider(create: (_) => NewProvider()), // <-- Add
  ],
  child: ...
)

// 3. Gunakan di widget
final newProvider = Provider.of<NewProvider>(context);
```

## 🎨 Customization

### Mengubah Warna Tema

Edit `main.dart`:

```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: const Color(0xFF6C5CE7), // <-- Ubah warna di sini
  brightness: Brightness.light,
),
```

### Menambah Kategori Baru

Edit `lib/models/activity.dart`:

```dart
class ActivityCategory {
  static const String work = 'Pekerjaan';
  static const String health = 'Kesehatan';
  static const String personal = 'Personal';
  static const String learning = 'Belajar';
  static const String social = 'Sosial';
  static const String newCategory = 'Kategori Baru'; // <-- Add
  static const String other = 'Lainnya';

  static List<String> get all => [
    work, health, personal, learning, social,
    newCategory, // <-- Add
    other
  ];

  static String getIcon(String category) {
    switch (category) {
      case work: return '💼';
      case health: return '🏃';
      case personal: return '🏠';
      case learning: return '📚';
      case social: return '👥';
      case newCategory: return '🎯'; // <-- Add
      default: return '📌';
    }
  }
}
```

## 🐛 Debugging Tips

### Debug Provider State

```dart
// Tambahkan print di provider
void updateData(String newData) {
  print('Before: $_data');
  _data = newData;
  print('After: $_data');
  notifyListeners();
}
```

### Debug Database

```dart
// Lihat semua data
final activities = await DatabaseHelper.instance.getAllActivities();
print('Total activities: ${activities.length}');
activities.forEach((a) => print(a.toMap()));
```

### Flutter DevTools

```bash
flutter run
# Tekan 'v' untuk membuka DevTools
# Atau buka: http://127.0.0.1:9100
```

## 📦 Build & Release

### Android APK

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (untuk Play Store)

```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

### iOS

```bash
flutter build ios --release
# Buka di Xcode untuk archive & upload
```

## 🧪 Testing

### Unit Test

```dart
// test/models/activity_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:schedule_tuneup/models/activity.dart';

void main() {
  test('Activity toMap test', () {
    final activity = Activity(
      title: 'Test',
      description: 'Test desc',
      scheduledTime: DateTime.now(),
      durationMinutes: 30,
      category: ActivityCategory.work,
    );

    final map = activity.toMap();
    expect(map['title'], 'Test');
  });
}
```

### Widget Test

```dart
// test/widgets/activity_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ActivityCard displays title', (WidgetTester tester) async {
    // Test implementation
  });
}
```

## 🚀 Performance Tips

1. **Use const constructors** wherever possible
2. **ListView.builder** untuk list panjang
3. **Cached images** untuk gambar yang sering digunakan
4. **Lazy loading** untuk data besar
5. **Profile mode** untuk test performance:
   ```bash
   flutter run --profile
   ```

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [SQLite in Flutter](https://pub.dev/packages/sqflite)
- [Material Design 3](https://m3.material.io/)
- [Google Generative AI](https://pub.dev/packages/google_generative_ai)

---

Happy Coding! 💙🚀
