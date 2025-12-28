import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/activity.dart';
import '../providers/schedule_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_colors.dart';

class AddActivityDialog extends StatefulWidget {
  final Activity? activity; // For editing

  const AddActivityDialog({super.key, this.activity});

  @override
  State<AddActivityDialog> createState() => _AddActivityDialogState();
}

class _AddActivityDialogState extends State<AddActivityDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _notesController = TextEditingController();
  
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  int _durationMinutes = 30;
  String _selectedCategory = ActivityCategory.work;
  int _priority = 2;
  bool _isRecurring = false;

  @override
  void initState() {
    super.initState();
    
    if (widget.activity != null) {
      // Edit mode
      final activity = widget.activity!;
      _titleController.text = activity.title;
      _descriptionController.text = activity.description;
      _notesController.text = activity.notes ?? '';
      _selectedDate = activity.scheduledTime;
      _selectedTime = TimeOfDay.fromDateTime(activity.scheduledTime);
      _durationMinutes = activity.durationMinutes;
      _selectedCategory = activity.category;
      _priority = activity.priority;
      _isRecurring = activity.isRecurring;
    } else {
      // Add mode
      final provider = Provider.of<ScheduleProvider>(context, listen: false);
      _selectedDate = provider.selectedDate;
      _selectedTime = TimeOfDay.now();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.activity == null ? 'Tambah Aktivitas' : 'Edit Aktivitas',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),

              // Title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Judul',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  prefixIcon: const Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Category
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Kategori',
                  prefixIcon: const Icon(Icons.category),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: ActivityCategory.all.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        Text(ActivityCategory.getIcon(category)),
                        const SizedBox(width: 8),
                        Text(category),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Date and Time
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Tanggal',
                          prefixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(_selectedDate),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectTime(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Waktu',
                          prefixIcon: const Icon(Icons.access_time),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _selectedTime.format(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Duration
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Durasi: $_durationMinutes menit',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Slider(
                    value: _durationMinutes.toDouble(),
                    min: 15,
                    max: 240,
                    divisions: 15,
                    label: '$_durationMinutes menit',
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      setState(() {
                        _durationMinutes = value.toInt();
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Priority
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prioritas',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  SegmentedButton<int>(
                    segments: const [
                      ButtonSegment(
                        value: 1,
                        label: Text('Rendah'),
                        icon: Icon(Icons.low_priority),
                      ),
                      ButtonSegment(
                        value: 2,
                        label: Text('Sedang'),
                        icon: Icon(Icons.flag_outlined),
                      ),
                      ButtonSegment(
                        value: 3,
                        label: Text('Tinggi'),
                        icon: Icon(Icons.priority_high),
                      ),
                    ],
                    selected: {_priority},
                    onSelectionChanged: (Set<int> newSelection) {
                      setState(() {
                        _priority = newSelection.first;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Notes (optional)
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Catatan (opsional)',
                  prefixIcon: const Icon(Icons.note),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveActivity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    widget.activity == null ? 'Tambah Aktivitas' : 'Simpan Perubahan',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveActivity() {
    if (_formKey.currentState!.validate()) {
      final scheduledDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final activity = Activity(
        id: widget.activity?.id,
        title: _titleController.text,
        description: _descriptionController.text,
        scheduledTime: scheduledDateTime,
        durationMinutes: _durationMinutes,
        category: _selectedCategory,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
        priority: _priority,
        isRecurring: _isRecurring,
        isCompleted: widget.activity?.isCompleted ?? false,
      );

      final provider = Provider.of<ScheduleProvider>(context, listen: false);
      
      if (widget.activity == null) {
        provider.addActivity(activity);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aktivitas ditambahkan')),
        );
      } else {
        provider.updateActivity(activity);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aktivitas diperbarui')),
        );
      }

      Navigator.pop(context);
    }
  }
}
