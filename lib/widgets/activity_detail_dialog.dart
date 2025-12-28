import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/activity.dart';
import '../providers/schedule_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_colors.dart';
import 'add_activity_dialog.dart';

class ActivityDetailDialog extends StatelessWidget {
  final Activity activity;

  const ActivityDetailDialog({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final priorityColor = _getPriorityColor(activity.priority);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        ActivityCategory.getIcon(activity.category),
                        style: const TextStyle(fontSize: 28),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          activity.title,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Status Badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: activity.isCompleted
                        ? Colors.green.withOpacity(0.2)
                        : Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        activity.isCompleted
                            ? Icons.check_circle
                            : Icons.pending,
                        size: 16,
                        color: activity.isCompleted ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        activity.isCompleted ? 'Selesai' : 'Pending',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: activity.isCompleted ? Colors.green : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getPriorityText(activity.priority),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: priorityColor,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 32),

            // Description
            _buildInfoRow(
              context,
              Icons.description,
              'Deskripsi',
              activity.description,
            ),

            const SizedBox(height: 16),

            // Category
            _buildInfoRow(
              context,
              Icons.category,
              'Kategori',
              activity.category,
            ),

            const SizedBox(height: 16),

            // Date & Time
            _buildInfoRow(
              context,
              Icons.calendar_today,
              'Tanggal & Waktu',
              DateFormat('EEEE, d MMMM y • HH:mm', 'id_ID')
                  .format(activity.scheduledTime),
            ),

            const SizedBox(height: 16),

            // Duration
            _buildInfoRow(
              context,
              Icons.timer,
              'Durasi',
              '${activity.durationMinutes} menit',
            ),

            if (activity.notes != null && activity.notes!.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildInfoRow(
                context,
                Icons.note,
                'Catatan',
                activity.notes!,
              ),
            ],

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _editActivity(context);
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final provider = Provider.of<ScheduleProvider>(
                        context,
                        listen: false,
                      );
                      provider.toggleActivityCompletion(activity.id);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      activity.isCompleted
                          ? Icons.restart_alt
                          : Icons.check_circle,
                    ),
                    label: Text(
                      activity.isCompleted ? 'Tandai Pending' : 'Selesai',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: activity.isCompleted
                          ? Colors.orange
                          : Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Delete Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _deleteActivity(context),
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text(
                  'Hapus Aktivitas',
                  style: TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _editActivity(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddActivityDialog(activity: activity),
    );
  }

  void _deleteActivity(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Aktivitas'),
        content: const Text('Apakah Anda yakin ingin menghapus aktivitas ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              final provider = Provider.of<ScheduleProvider>(
                context,
                listen: false,
              );
              provider.deleteActivity(activity.id);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close detail sheet
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Aktivitas dihapus')),
              );
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 3:
        return AppColors.priorityHigh;
      case 2:
        return AppColors.priorityMedium;
      case 1:
      default:
        return AppColors.priorityLow;
    }
  }

  String _getPriorityText(int priority) {
    switch (priority) {
      case 3:
        return 'Prioritas Tinggi';
      case 2:
        return 'Prioritas Sedang';
      case 1:
      default:
        return 'Prioritas Rendah';
    }
  }
}
