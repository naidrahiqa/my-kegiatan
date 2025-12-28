import 'package:uuid/uuid.dart';

class Activity {
  final String id;
  final String title;
  final String description;
  final DateTime scheduledTime;
  final int durationMinutes;
  final String category;
  final bool isCompleted;
  final String? notes;
  final int priority; // 1=Low, 2=Medium, 3=High
  final bool isRecurring;
  final RecurrenceType? recurrenceType;
  final List<int>? recurringDays; // 1=Monday, 7=Sunday
  
  Activity({
    String? id,
    required this.title,
    required this.description,
    required this.scheduledTime,
    required this.durationMinutes,
    required this.category,
    this.isCompleted = false,
    this.notes,
    this.priority = 2,
    this.isRecurring = false,
    this.recurrenceType,
    this.recurringDays,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'scheduledTime': scheduledTime.toIso8601String(),
      'durationMinutes': durationMinutes,
      'category': category,
      'isCompleted': isCompleted ? 1 : 0,
      'notes': notes,
      'priority': priority,
      'isRecurring': isRecurring ? 1 : 0,
      'recurrenceType': recurrenceType?.toString(),
      'recurringDays': recurringDays?.join(','),
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      scheduledTime: DateTime.parse(map['scheduledTime']),
      durationMinutes: map['durationMinutes'],
      category: map['category'],
      isCompleted: map['isCompleted'] == 1,
      notes: map['notes'],
      priority: map['priority'] ?? 2,
      isRecurring: map['isRecurring'] == 1,
      recurrenceType: map['recurrenceType'] != null
          ? RecurrenceType.values.firstWhere(
              (e) => e.toString() == map['recurrenceType'],
            )
          : null,
      recurringDays: map['recurringDays'] != null
          ? (map['recurringDays'] as String).split(',').map(int.parse).toList()
          : null,
    );
  }

  Activity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? scheduledTime,
    int? durationMinutes,
    String? category,
    bool? isCompleted,
    String? notes,
    int? priority,
    bool? isRecurring,
    RecurrenceType? recurrenceType,
    List<int>? recurringDays,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      notes: notes ?? this.notes,
      priority: priority ?? this.priority,
      isRecurring: isRecurring ?? this.isRecurring,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      recurringDays: recurringDays ?? this.recurringDays,
    );
  }
}

enum RecurrenceType {
  daily,
  weekly,
  monthly,
}

// Category constants
class ActivityCategory {
  static const String work = 'Pekerjaan';
  static const String health = 'Kesehatan';
  static const String personal = 'Personal';
  static const String learning = 'Belajar';
  static const String social = 'Sosial';
  static const String other = 'Lainnya';
  
  static List<String> get all => [work, health, personal, learning, social, other];
  
  static String getIcon(String category) {
    switch (category) {
      case work: return '💼';
      case health: return '🏃';
      case personal: return '🏠';
      case learning: return '📚';
      case social: return '👥';
      default: return '📌';
    }
  }
}
