import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/schedule_provider.dart';
import '../providers/theme_provider.dart';
import '../models/activity.dart';
import '../utils/app_colors.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              pinned: true,
              expandedHeight: 100,
              backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Dashboard Analitik',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary,
                        AppColors.purpleLight,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverTabBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.calendar_view_week_rounded),
                      text: 'Mingguan',
                    ),
                    Tab(
                      icon: Icon(Icons.calendar_month_rounded),
                      text: 'Bulanan',
                    ),
                  ],
                ),
                isDark,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _WeeklyAnalytics(isDark: isDark),
            _MonthlyAnalytics(isDark: isDark),
          ],
        ),
      ),
    );
  }
}

// Tab Bar Delegate
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final bool isDark;

  _SliverTabBarDelegate(this.tabBar, this.isDark);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar || isDark != oldDelegate.isDark;
  }
}

// ========== WEEKLY ANALYTICS ==========
class _WeeklyAnalytics extends StatelessWidget {
  final bool isDark;

  const _WeeklyAnalytics({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);
    final weeklyStats = scheduleProvider.getWeeklyStats();
    final weeklyData = scheduleProvider.getWeeklyCompletionData();

    return ListView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      children: [
        // Header
        Text(
          '📊 Ringkasan 7 Hari Terakhir',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),

        // Stats Grid
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.assignment_rounded,
                title: 'Total Kegiatan',
                value: '${weeklyStats['total']}',
                color: Colors.blue,
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.check_circle_rounded,
                title: 'Selesai',
                value: '${weeklyStats['completed']}',
                color: Colors.green,
                isDark: isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.timelapse_rounded,
                title: 'Total Waktu',
                value: '${(weeklyStats['totalMinutes'] as int) ~/ 60}j',
                color: Colors.orange,
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.trending_up_rounded,
                title: 'Tingkat Sukses',
                value: '${(weeklyStats['completionRate'] as double).toStringAsFixed(0)}%',
                color: AppColors.primary,
                isDark: isDark,
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Chart Title
        Text(
          '📈 Diagram Kegiatan Mingguan',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),

        // Bar Chart
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Chart Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ChartLegend(color: Colors.green, label: 'Selesai'),
                  const SizedBox(width: 24),
                  _ChartLegend(color: Colors.grey.shade300, label: 'Pending'),
                ],
              ),
              const SizedBox(height: 20),
              
              // Bar Chart
              SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: weeklyData.entries.map((entry) {
                    final total = entry.value['total'] ?? 0;
                    final completed = entry.value['completed'] ?? 0;
                    final isToday = entry.key.contains('*');
                    final label = entry.key.replaceAll('*', '');
                    
                    return _BarChartColumn(
                      label: label,
                      total: total,
                      completed: completed,
                      maxValue: 8, // Max activities per day
                      isHighlighted: isToday,
                      isDark: isDark,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Daily Breakdown
        Text(
          '📋 Detail Per Hari',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        
        ...weeklyData.entries.map((entry) {
          final total = entry.value['total'] ?? 0;
          final completed = entry.value['completed'] ?? 0;
          final isToday = entry.key.contains('*');
          final label = entry.key.replaceAll('*', '');
          final rate = total > 0 ? (completed / total * 100) : 0.0;
          
          return _DailyDetailCard(
            day: label,
            total: total,
            completed: completed,
            rate: rate,
            isToday: isToday,
            isDark: isDark,
          );
        }),

        const SizedBox(height: 100),
      ],
    );
  }
}

// ========== MONTHLY ANALYTICS ==========
class _MonthlyAnalytics extends StatelessWidget {
  final bool isDark;

  const _MonthlyAnalytics({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);
    final monthlyStats = scheduleProvider.getMonthlyStats();
    final monthlyData = scheduleProvider.getMonthlyCompletionData();
    final categoryBreakdown = monthlyStats['categoryBreakdown'] as Map<String, int>;

    return ListView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      children: [
        // Header
        Text(
          '📊 Ringkasan Bulan Ini',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),

        // Highlight Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Kegiatan',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${monthlyStats['total']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${(monthlyStats['completionRate'] as double).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Sukses',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _MiniStat(
                      icon: Icons.check_circle,
                      label: 'Selesai',
                      value: '${monthlyStats['completed']}',
                    ),
                  ),
                  Expanded(
                    child: _MiniStat(
                      icon: Icons.pending,
                      label: 'Pending',
                      value: '${monthlyStats['pending']}',
                    ),
                  ),
                  Expanded(
                    child: _MiniStat(
                      icon: Icons.schedule,
                      label: 'Jam',
                      value: '${monthlyStats['totalMinutes'] ~/ 60}',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Weekly Progress Chart
        Text(
          '📈 Progress Per Minggu',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Chart Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ChartLegend(color: Colors.green, label: 'Selesai'),
                  const SizedBox(width: 24),
                  _ChartLegend(color: Colors.grey.shade300, label: 'Pending'),
                ],
              ),
              const SizedBox(height: 20),
              
              // Bar Chart
              SizedBox(
                height: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: monthlyData.entries.map((entry) {
                    final total = entry.value['total'] ?? 0;
                    final completed = entry.value['completed'] ?? 0;
                    
                    return _BarChartColumn(
                      label: entry.key.replaceAll('Minggu ', 'M'),
                      total: total,
                      completed: completed,
                      maxValue: 30, // Max activities per week
                      isHighlighted: false,
                      isDark: isDark,
                      width: 50,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Category Breakdown
        Text(
          '🏷️ Distribusi Kategori',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),

        if (categoryBreakdown.isEmpty)
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.pie_chart_outline_rounded,
                    size: 48,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Belum ada data',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: categoryBreakdown.entries.map((entry) {
                final total = monthlyStats['total'] as int;
                final percentage = total > 0 ? (entry.value / total * 100) : 0.0;
                
                return _CategoryProgressBar(
                  category: entry.key,
                  count: entry.value,
                  percentage: percentage,
                  isDark: isDark,
                );
              }).toList(),
            ),
          ),

        const SizedBox(height: 32),

        // Top Category
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: Colors.amber,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kategori Paling Aktif',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${ActivityCategory.getIcon(monthlyStats['topCategory'] ?? '')} ${monthlyStats['topCategory']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 100),
      ],
    );
  }
}

// ========== HELPER WIDGETS ==========

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final bool isDark;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _ChartLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _BarChartColumn extends StatelessWidget {
  final String label;
  final int total;
  final int completed;
  final int maxValue;
  final bool isHighlighted;
  final bool isDark;
  final double width;

  const _BarChartColumn({
    required this.label,
    required this.total,
    required this.completed,
    required this.maxValue,
    required this.isHighlighted,
    required this.isDark,
    this.width = 32,
  });

  @override
  Widget build(BuildContext context) {
    final maxHeight = 150.0;
    final totalHeight = total > 0 ? (total / maxValue * maxHeight).clamp(10.0, maxHeight) : 4.0;
    final completedHeight = total > 0 ? (completed / total * totalHeight) : 0.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Value label
        Text(
          '$completed/$total',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        // Bar
        Container(
          width: width,
          height: totalHeight,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: width,
                height: completedHeight,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Label
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: isHighlighted ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              color: isHighlighted ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}

class _DailyDetailCard extends StatelessWidget {
  final String day;
  final int total;
  final int completed;
  final double rate;
  final bool isToday;
  final bool isDark;

  const _DailyDetailCard({
    required this.day,
    required this.total,
    required this.completed,
    required this.rate,
    required this.isToday,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isToday
            ? Border.all(color: AppColors.primary, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isToday
                  ? AppColors.primary
                  : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isToday ? Colors.white : Colors.grey.shade600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$completed dari $total kegiatan',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: rate / 100,
                    minHeight: 6,
                    backgroundColor: isDark
                        ? Colors.grey.shade800
                        : Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      rate >= 80 ? Colors.green : (rate >= 50 ? Colors.orange : Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${rate.toStringAsFixed(0)}%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: rate >= 80 ? Colors.green : (rate >= 50 ? Colors.orange : Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MiniStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _CategoryProgressBar extends StatelessWidget {
  final String category;
  final int count;
  final double percentage;
  final bool isDark;

  const _CategoryProgressBar({
    required this.category,
    required this.count,
    required this.percentage,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    ActivityCategory.getIcon(category),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Text(
                '$count (${percentage.toStringAsFixed(0)}%)',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 8,
              backgroundColor: isDark
                  ? Colors.grey.shade800
                  : Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
