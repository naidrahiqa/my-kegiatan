import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/schedule_provider.dart';
import '../providers/theme_provider.dart';
import '../models/activity.dart';
import '../utils/app_colors.dart';
import '../widgets/activity_card.dart';
import '../widgets/add_activity_dialog.dart';
import '../widgets/stats_card.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar
          SliverAppBar.large(
            floating: true,
            pinned: true,
            expandedHeight: 140,
            backgroundColor: isDark ? const Color(0xFF0D0D0D) : Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'My Kegiatan',
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
            actions: [
              IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () => themeProvider.toggleTheme(),
                tooltip: 'Toggle Theme',
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Date Header - Fixed overflow
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('EEEE, d MMM y', 'id_ID').format(scheduleProvider.selectedDate),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Kelola rutinitas harianmu',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton.filledTonal(
                        icon: const Icon(Icons.add_rounded),
                        onPressed: () => _showAddActivityDialog(context),
                        iconSize: 28,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Statistics Cards
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: StatsCard(
                      icon: Icons.check_circle_outline,
                      title: 'Selesai',
                      value: '${scheduleProvider.completedToday}',
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatsCard(
                      icon: Icons.pending_outlined,
                      title: 'Pending',
                      value: '${scheduleProvider.pendingToday}',
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatsCard(
                      icon: Icons.trending_up,
                      title: 'Progress',
                      value: '${scheduleProvider.completionRate.toStringAsFixed(0)}%',
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Category Filter
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildCategoryChip(context, 'Semua', scheduleProvider),
                    ...ActivityCategory.all.map(
                      (category) => _buildCategoryChip(context, category, scheduleProvider),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Activities List
          scheduleProvider.filteredActivities.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy_rounded,
                          size: 80,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada kegiatan',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap tombol + untuk menambah kegiatan',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final activity = scheduleProvider.filteredActivities[index];
                        return ActivityCard(activity: activity);
                      },
                      childCount: scheduleProvider.filteredActivities.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String category, ScheduleProvider provider) {
    final isSelected = provider.selectedCategory == category;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : null,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        onSelected: (_) => provider.setSelectedCategory(category),
        selectedColor: AppColors.primary,
        checkmarkColor: Colors.white,
        elevation: isSelected ? 4 : 0,
        shadowColor: AppColors.primary.withOpacity(0.5),
      ),
    );
  }

  void _showAddActivityDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddActivityDialog(),
    );
  }
}
