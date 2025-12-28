import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../utils/database_helper.dart';

class ScheduleProvider extends ChangeNotifier {
  List<Activity> _activities = [];
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'Semua';
  
  List<Activity> get activities => _activities;
  DateTime get selectedDate => _selectedDate;
  String get selectedCategory => _selectedCategory;
  
  // Get activities for selected date
  List<Activity> get activitiesForSelectedDate {
    return _activities.where((activity) {
      final activityDate = activity.scheduledTime;
      return activityDate.year == _selectedDate.year &&
             activityDate.month == _selectedDate.month &&
             activityDate.day == _selectedDate.day;
    }).toList()
      ..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
  }
  
  // Get activities by category
  List<Activity> get filteredActivities {
    if (_selectedCategory == 'Semua') {
      return activitiesForSelectedDate;
    }
    return activitiesForSelectedDate
        .where((activity) => activity.category == _selectedCategory)
        .toList();
  }
  
  // Statistics
  int get totalActivities => _activities.length;
  int get completedToday => activitiesForSelectedDate.where((a) => a.isCompleted).length;
  int get pendingToday => activitiesForSelectedDate.where((a) => !a.isCompleted).length;
  
  double get completionRate {
    final total = activitiesForSelectedDate.length;
    if (total == 0) return 0.0;
    return (completedToday / total) * 100;
  }
  
  ScheduleProvider() {
    loadActivities();
  }
  
  Future<void> loadActivities() async {
    _activities = await DatabaseHelper.instance.getAllActivities();
    
    // If no activities exist, load sample data for better UX
    if (_activities.isEmpty) {
      await loadSampleData();
      _activities = await DatabaseHelper.instance.getAllActivities();
    }
    
    notifyListeners();
  }
  
  Future<void> loadSampleData() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    // Generate sample data for past 7 days
    final sampleActivities = <Activity>[];
    
    for (int i = 0; i <= 7; i++) {
      final date = today.subtract(Duration(days: i));
      final baseActivities = [
        Activity(
          id: 'sample_exercise_$i',
          title: 'Olahraga Pagi',
          description: 'Jogging 30 menit',
          category: ActivityCategory.health,
          scheduledTime: date.add(const Duration(hours: 6)),
          durationMinutes: 30,
          isCompleted: i != 0 ? true : false,
        ),
        Activity(
          id: 'sample_work_$i',
          title: 'Kerja & Produktif',
          description: 'Fokus pada tugas utama',
          category: ActivityCategory.work,
          scheduledTime: date.add(const Duration(hours: 9)),
          durationMinutes: 120,
          isCompleted: i != 0 ? true : false,
        ),
        Activity(
          id: 'sample_learning_$i',
          title: 'Belajar Skill Baru',
          description: 'Online course / membaca buku',
          category: ActivityCategory.learning,
          scheduledTime: date.add(const Duration(hours: 14)),
          durationMinutes: 60,
          isCompleted: i > 1 ? true : false,
        ),
        Activity(
          id: 'sample_personal_$i',
          title: 'Me Time',
          description: 'Relaksasi dan hobi',
          category: ActivityCategory.personal,
          scheduledTime: date.add(const Duration(hours: 19)),
          durationMinutes: 45,
          isCompleted: i > 2 ? true : false,
        ),
      ];
      sampleActivities.addAll(baseActivities);
    }
    
    for (var activity in sampleActivities) {
      await DatabaseHelper.instance.insertActivity(activity);
    }
  }
  
  Future<void> addActivity(Activity activity) async {
    await DatabaseHelper.instance.insertActivity(activity);
    await loadActivities();
  }
  
  Future<void> updateActivity(Activity activity) async {
    await DatabaseHelper.instance.updateActivity(activity);
    await loadActivities();
  }
  
  Future<void> deleteActivity(String id) async {
    await DatabaseHelper.instance.deleteActivity(id);
    await loadActivities();
  }
  
  Future<void> toggleActivityCompletion(String id) async {
    final activity = _activities.firstWhere((a) => a.id == id);
    final updated = activity.copyWith(isCompleted: !activity.isCompleted);
    await updateActivity(updated);
  }
  
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
  
  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
  
  // Get activities for a specific date (for calendar markers)
  List<Activity> getActivitiesForDate(DateTime date) {
    return _activities.where((activity) {
      final activityDate = activity.scheduledTime;
      return activityDate.year == date.year &&
             activityDate.month == date.month &&
             activityDate.day == date.day;
    }).toList();
  }
  
  // Analytics helpers
  Map<String, int> getCategoryDistribution() {
    final Map<String, int> distribution = {};
    for (var activity in activitiesForSelectedDate) {
      distribution[activity.category] = (distribution[activity.category] ?? 0) + 1;
    }
    return distribution;
  }
  
  int getTotalTimeScheduled() {
    return activitiesForSelectedDate.fold(0, (sum, activity) => sum + activity.durationMinutes);
  }
  
  // ========== WEEKLY ANALYTICS ==========
  
  /// Get activities for past 7 days
  List<Activity> getWeeklyActivities() {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    
    return _activities.where((activity) {
      return activity.scheduledTime.isAfter(weekAgo) && 
             activity.scheduledTime.isBefore(now.add(const Duration(days: 1)));
    }).toList();
  }
  
  /// Get daily completion data for past 7 days
  /// Returns a map with day name as key and {total, completed} as value
  Map<String, Map<String, int>> getWeeklyCompletionData() {
    final now = DateTime.now();
    final Map<String, Map<String, int>> data = {};
    
    final dayNames = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dayName = dayNames[date.weekday - 1];
      final dayActivities = getActivitiesForDate(date);
      
      data['$dayName${i == 0 ? "*" : ""}'] = {
        'total': dayActivities.length,
        'completed': dayActivities.where((a) => a.isCompleted).length,
      };
    }
    
    return data;
  }
  
  /// Get weekly statistics summary
  Map<String, dynamic> getWeeklyStats() {
    final activities = getWeeklyActivities();
    final completed = activities.where((a) => a.isCompleted).length;
    final total = activities.length;
    
    return {
      'total': total,
      'completed': completed,
      'pending': total - completed,
      'completionRate': total > 0 ? (completed / total * 100) : 0.0,
      'totalMinutes': activities.fold<int>(0, (sum, a) => sum + a.durationMinutes),
    };
  }
  
  // ========== MONTHLY ANALYTICS ==========
  
  /// Get activities for current month
  List<Activity> getMonthlyActivities() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    
    return _activities.where((activity) {
      return activity.scheduledTime.isAfter(startOfMonth.subtract(const Duration(days: 1))) && 
             activity.scheduledTime.isBefore(endOfMonth.add(const Duration(days: 1)));
    }).toList();
  }
  
  /// Get weekly completion data for current month (4 weeks)
  Map<String, Map<String, int>> getMonthlyCompletionData() {
    final now = DateTime.now();
    final Map<String, Map<String, int>> data = {};
    
    for (int week = 1; week <= 4; week++) {
      final weekStart = DateTime(now.year, now.month, (week - 1) * 7 + 1);
      final weekEnd = DateTime(now.year, now.month, week * 7);
      
      final weekActivities = _activities.where((activity) {
        return activity.scheduledTime.isAfter(weekStart.subtract(const Duration(days: 1))) && 
               activity.scheduledTime.isBefore(weekEnd.add(const Duration(days: 1)));
      }).toList();
      
      data['Minggu $week'] = {
        'total': weekActivities.length,
        'completed': weekActivities.where((a) => a.isCompleted).length,
      };
    }
    
    return data;
  }
  
  /// Get monthly statistics summary
  Map<String, dynamic> getMonthlyStats() {
    final activities = getMonthlyActivities();
    final completed = activities.where((a) => a.isCompleted).length;
    final total = activities.length;
    
    // Category breakdown
    final Map<String, int> categoryCount = {};
    for (var activity in activities) {
      categoryCount[activity.category] = (categoryCount[activity.category] ?? 0) + 1;
    }
    
    // Find most productive category
    String? topCategory;
    int maxCount = 0;
    categoryCount.forEach((category, count) {
      if (count > maxCount) {
        maxCount = count;
        topCategory = category;
      }
    });
    
    return {
      'total': total,
      'completed': completed,
      'pending': total - completed,
      'completionRate': total > 0 ? (completed / total * 100) : 0.0,
      'totalMinutes': activities.fold<int>(0, (sum, a) => sum + a.durationMinutes),
      'categoryBreakdown': categoryCount,
      'topCategory': topCategory ?? 'Belum ada',
    };
  }
}
