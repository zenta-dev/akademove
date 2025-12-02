import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverKrsScreen extends StatefulWidget {
  const DriverKrsScreen({super.key});

  @override
  State<DriverKrsScreen> createState() => _DriverKrsScreenState();
}

class _DriverKrsScreenState extends State<DriverKrsScreen> {
  String? _driverId;
  List<DriverSchedule> _schedules = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDriverAndSchedules();
  }

  Future<void> _loadDriverAndSchedules() async {
    setState(() => _isLoading = true);

    try {
      // Get driver ID first
      final driverRepo = context.read<DriverRepository>();
      final driverResponse = await driverRepo.getMine();
      final driverId = driverResponse.data.id;

      // Load schedules
      final scheduleResponse = await driverRepo.listSchedules(driverId);

      if (mounted) {
        setState(() {
          _driverId = driverId;
          _schedules = scheduleResponse.data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: 'Error',
            message: 'Failed to load schedules: ${e.toString()}',
          ),
        );
      }
    }
  }

  Future<void> _onRefresh() async {
    await _loadDriverAndSchedules();
  }

  Future<void> _deleteSchedule(String scheduleId) async {
    final driverId = _driverId;
    if (driverId == null) return;

    try {
      await context.read<DriverRepository>().removeSchedule(
        driverId: driverId,
        scheduleId: scheduleId,
      );

      if (mounted) {
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: 'Success',
            message: 'Schedule deleted successfully',
          ),
        );
        _loadDriverAndSchedules();
      }
    } catch (e) {
      if (mounted) {
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: 'Error',
            message: 'Failed to delete schedule: ${e.toString()}',
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          title: const Text('My Schedule (KRS)'),
          trailing: [
            IconButton(
              icon: const Icon(LucideIcons.plus),
              onPressed: _driverId == null
                  ? null
                  : () => _showAddScheduleDialog(),
              variance: ButtonVariance.ghost,
            ),
          ],
        ),
      ],
      body: _isLoading && _schedules.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : material.RefreshIndicator(
              onRefresh: _onRefresh,
              child: _schedules.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: EdgeInsets.all(16.dg),
                      itemCount: _schedules.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        return _buildScheduleCard(_schedules[index]);
                      },
                    ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16.h,
        children: [
          Icon(
            LucideIcons.calendar,
            size: 64.sp,
            color: context.colorScheme.mutedForeground,
          ),
          Text(
            'No schedules yet',
            style: context.typography.h3.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Add your class schedule to automatically\ndisable order acceptance during class time',
            textAlign: TextAlign.center,
            style: context.typography.p.copyWith(
              fontSize: 14.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
          SizedBox(height: 16.h),
          PrimaryButton(
            onPressed: _driverId == null
                ? null
                : () => _showAddScheduleDialog(),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [Icon(LucideIcons.plus), Text('Add Schedule')],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(DriverSchedule schedule) {
    final dayColor = _getDayColor(schedule.dayOfWeek);
    final isActive = schedule.isActive ?? true;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            // Header: Name + Day badge + Active indicator
            Row(
              children: [
                Expanded(
                  child: Text(
                    schedule.name,
                    style: context.typography.h4.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: dayColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(color: dayColor),
                  ),
                  child: Text(
                    _getDayText(schedule.dayOfWeek),
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: dayColor,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  isActive ? LucideIcons.circleCheck : LucideIcons.circleX,
                  size: 20.sp,
                  color: isActive
                      ? material.Colors.green
                      : material.Colors.grey,
                ),
              ],
            ),
            const Divider(),
            // Time info
            Row(
              spacing: 16.w,
              children: [
                Icon(
                  LucideIcons.clock,
                  size: 20.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Text(
                  '${_formatTime(schedule.startTime)} - ${_formatTime(schedule.endTime)}',
                  style: context.typography.p.copyWith(fontSize: 14.sp),
                ),
                const Spacer(),
                if (schedule.isRecurring ?? true)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: material.Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      'Recurring',
                      style: context.typography.small.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: material.Colors.blue,
                      ),
                    ),
                  ),
              ],
            ),
            // Actions
            Row(
              spacing: 8.w,
              children: [
                Expanded(
                  child: OutlineButton(
                    onPressed: () => _showEditScheduleDialog(schedule),
                    child: const Text('Edit'),
                  ),
                ),
                Expanded(
                  child: DestructiveButton(
                    onPressed: () => _showDeleteConfirmation(schedule),
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  material.Color _getDayColor(DayOfWeek day) {
    switch (day) {
      case DayOfWeek.MONDAY:
        return material.Colors.red;
      case DayOfWeek.TUESDAY:
        return material.Colors.orange;
      case DayOfWeek.WEDNESDAY:
        return material.Colors.yellow;
      case DayOfWeek.THURSDAY:
        return material.Colors.green;
      case DayOfWeek.FRIDAY:
        return material.Colors.blue;
      case DayOfWeek.SATURDAY:
        return material.Colors.purple;
      case DayOfWeek.SUNDAY:
        return material.Colors.pink;
    }
  }

  String _getDayText(DayOfWeek day) {
    return day.name.substring(0, 3);
  }

  String _formatTime(Time time) {
    final hour = time.h.toInt().toString().padLeft(2, '0');
    final minute = time.m.toInt().toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _showAddScheduleDialog() {
    _showScheduleDialog();
  }

  void _showEditScheduleDialog(DriverSchedule schedule) {
    _showScheduleDialog(schedule: schedule);
  }

  void _showScheduleDialog({DriverSchedule? schedule}) {
    final isEditing = schedule != null;
    final nameController = TextEditingController(text: schedule?.name);
    DayOfWeek selectedDay = schedule?.dayOfWeek ?? DayOfWeek.MONDAY;
    material.TimeOfDay startTime = schedule != null
        ? material.TimeOfDay(
            hour: schedule.startTime.h.toInt(),
            minute: schedule.startTime.m.toInt(),
          )
        : const material.TimeOfDay(hour: 8, minute: 0);
    material.TimeOfDay endTime = schedule != null
        ? material.TimeOfDay(
            hour: schedule.endTime.h.toInt(),
            minute: schedule.endTime.m.toInt(),
          )
        : const material.TimeOfDay(hour: 10, minute: 0);
    bool isRecurring = schedule?.isRecurring ?? true;
    bool isActive = schedule?.isActive ?? true;

    material.showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => material.AlertDialog(
          title: Text(isEditing ? 'Edit Schedule' : 'Add Schedule'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.h,
              children: [
                // Name field
                material.TextField(
                  controller: nameController,
                  decoration: const material.InputDecoration(
                    labelText: 'Schedule Name',
                    hintText: 'e.g., Mobile Programming',
                    border: material.OutlineInputBorder(),
                  ),
                ),
                // Day of week dropdown
                material.DropdownButtonFormField<DayOfWeek>(
                  initialValue: selectedDay,
                  decoration: const material.InputDecoration(
                    labelText: 'Day of Week',
                    border: material.OutlineInputBorder(),
                  ),
                  items: DayOfWeek.values.map((day) {
                    return material.DropdownMenuItem(
                      value: day,
                      child: Text(_getDayFullText(day)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedDay = value);
                    }
                  },
                ),
                // Start time
                material.ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Start Time'),
                  subtitle: Text(_formatTimeOfDay(startTime)),
                  trailing: const Icon(LucideIcons.clock),
                  onTap: () async {
                    final picked = await material.showTimePicker(
                      context: context,
                      initialTime: startTime,
                    );
                    if (picked != null) {
                      setState(() => startTime = picked);
                    }
                  },
                ),
                // End time
                material.ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('End Time'),
                  subtitle: Text(_formatTimeOfDay(endTime)),
                  trailing: const Icon(LucideIcons.clock),
                  onTap: () async {
                    final picked = await material.showTimePicker(
                      context: context,
                      initialTime: endTime,
                    );
                    if (picked != null) {
                      setState(() => endTime = picked);
                    }
                  },
                ),
                // Recurring toggle
                material.SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Recurring'),
                  subtitle: const Text('Repeats every week'),
                  value: isRecurring,
                  onChanged: (value) {
                    setState(() => isRecurring = value);
                  },
                ),
                // Active toggle
                material.SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Active'),
                  subtitle: const Text('Disable orders during this time'),
                  value: isActive,
                  onChanged: (value) {
                    setState(() => isActive = value);
                  },
                ),
              ],
            ),
          ),
          actions: [
            material.TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            material.TextButton(
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) {
                  if (mounted) {
                    showToast(
                      context: context,
                      builder: (context, overlay) => context.buildToast(
                        title: 'Error',
                        message: 'Please enter a schedule name',
                      ),
                    );
                  }
                  return;
                }

                Navigator.of(dialogContext).pop();
                await _saveSchedule(
                  name: name,
                  dayOfWeek: selectedDay,
                  startTime: startTime,
                  endTime: endTime,
                  isRecurring: isRecurring,
                  isActive: isActive,
                  scheduleId: schedule?.id,
                );
              },
              child: Text(isEditing ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveSchedule({
    required String name,
    required DayOfWeek dayOfWeek,
    required material.TimeOfDay startTime,
    required material.TimeOfDay endTime,
    required bool isRecurring,
    required bool isActive,
    String? scheduleId,
  }) async {
    final driverId = _driverId;
    if (driverId == null) return;

    final isEditing = scheduleId != null;

    try {
      final timeStart = Time(h: startTime.hour, m: startTime.minute);
      final timeEnd = Time(h: endTime.hour, m: endTime.minute);

      if (isEditing) {
        // Update existing schedule
        await context.read<DriverRepository>().updateSchedule(
          driverId: driverId,
          scheduleId: scheduleId,
          request: DriverScheduleUpdateRequest(
            name: name,
            dayOfWeek: dayOfWeek,
            startTime: timeStart,
            endTime: timeEnd,
            isRecurring: isRecurring,
            isActive: isActive,
          ),
        );
      } else {
        // Create new schedule
        await context.read<DriverRepository>().createSchedule(
          driverId: driverId,
          request: DriverScheduleCreateRequest(
            name: name,
            driverId: driverId,
            dayOfWeek: dayOfWeek,
            startTime: timeStart,
            endTime: timeEnd,
            isRecurring: isRecurring,
            isActive: isActive,
          ),
        );
      }

      if (mounted) {
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: 'Success',
            message: isEditing
                ? 'Schedule updated successfully'
                : 'Schedule added successfully',
          ),
        );
        _loadDriverAndSchedules();
      }
    } catch (e) {
      if (mounted) {
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: 'Error',
            message: isEditing
                ? 'Failed to update schedule: ${e.toString()}'
                : 'Failed to add schedule: ${e.toString()}',
          ),
        );
      }
    }
  }

  String _formatTimeOfDay(material.TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _getDayFullText(DayOfWeek day) {
    switch (day) {
      case DayOfWeek.MONDAY:
        return 'Monday';
      case DayOfWeek.TUESDAY:
        return 'Tuesday';
      case DayOfWeek.WEDNESDAY:
        return 'Wednesday';
      case DayOfWeek.THURSDAY:
        return 'Thursday';
      case DayOfWeek.FRIDAY:
        return 'Friday';
      case DayOfWeek.SATURDAY:
        return 'Saturday';
      case DayOfWeek.SUNDAY:
        return 'Sunday';
    }
  }

  void _showDeleteConfirmation(DriverSchedule schedule) {
    material.showDialog(
      context: context,
      builder: (dialogContext) => material.AlertDialog(
        title: const Text('Delete Schedule'),
        content: Text(
          'Are you sure you want to delete "${schedule.name}"? This action cannot be undone.',
        ),
        actions: [
          material.TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          material.TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _deleteSchedule(schedule.id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
