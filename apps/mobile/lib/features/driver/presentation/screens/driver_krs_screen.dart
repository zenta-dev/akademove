import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
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
    } on BaseError catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        context.showMyToast(
          e.message ?? context.l10n.an_error_occurred,
          type: ToastType.failed,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        context.showMyToast(
          context.l10n.an_error_occurred,
          type: ToastType.failed,
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
        context.showMyToast(
          context.l10n.schedule_deleted_successfully,
          type: ToastType.success,
        );
        _loadDriverAndSchedules();
      }
    } on BaseError catch (e) {
      if (mounted) {
        context.showMyToast(
          e.message ?? context.l10n.failed_to_delete_schedule,
          type: ToastType.failed,
        );
      }
    } catch (e) {
      if (mounted) {
        context.showMyToast(
          context.l10n.failed_to_delete_schedule,
          type: ToastType.failed,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          title: Text(context.l10n.my_schedule),
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
            context.l10n.no_schedules_yet,
            style: context.typography.h3.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            context
                .l10n
                .add_your_class_schedule_to_automatically_disable_order_acceptance_during_class_time,
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
                      context.l10n.recurring,
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
                  decoration: material.InputDecoration(
                    labelText: context.l10n.schedule_name,
                    hintText: 'e.g., Mobile Programming',
                    border: material.OutlineInputBorder(),
                  ),
                ),
                // Day of week dropdown
                material.DropdownButtonFormField<DayOfWeek>(
                  initialValue: selectedDay,
                  decoration: material.InputDecoration(
                    labelText: context.l10n.day_of_week,
                    border: material.OutlineInputBorder(),
                  ),
                  items: DayOfWeek.values.map((day) {
                    return material.DropdownMenuItem(
                      value: day,
                      child: Text(_getDayFullText(context, day)),
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
                  title: Text(context.l10n.start_time),
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
                  title: Text(context.l10n.end_time),
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
                  title: Text(context.l10n.recurring),
                  subtitle: Text(context.l10n.repeat_every_week),
                  value: isRecurring,
                  onChanged: (value) {
                    setState(() => isRecurring = value);
                  },
                ),
                // Active toggle
                material.SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(context.l10n.active),
                  subtitle: Text(context.l10n.disable_orders_during_this_time),
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
              child: Text(context.l10n.cancel),
            ),
            material.TextButton(
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) {
                  if (mounted) {
                    context.showMyToast(
                      context.l10n.please_enter_a_schedule_name,
                      type: ToastType.failed,
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
              child: Text(isEditing ? context.l10n.update : context.l10n.add),
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
        context.showMyToast(
          isEditing
              ? context.l10n.schedule_updated_successfully
              : context.l10n.schedule_added_successfully,
          type: ToastType.success,
        );
        _loadDriverAndSchedules();
      }
    } on BaseError catch (e) {
      if (mounted) {
        context.showMyToast(
          e.message ??
              (isEditing
                  ? context.l10n.failed_to_update_schedule
                  : context.l10n.failed_to_add_schedule),
          type: ToastType.failed,
        );
      }
    } catch (e) {
      if (mounted) {
        context.showMyToast(
          isEditing
              ? context.l10n.failed_to_update_schedule
              : context.l10n.failed_to_add_schedule,
          type: ToastType.failed,
        );
      }
    }
  }

  String _formatTimeOfDay(material.TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _getDayFullText(BuildContext context, DayOfWeek day) {
    switch (day) {
      case DayOfWeek.MONDAY:
        return context.l10n.monday;
      case DayOfWeek.TUESDAY:
        return context.l10n.tuesday;
      case DayOfWeek.WEDNESDAY:
        return context.l10n.wednesday;
      case DayOfWeek.THURSDAY:
        return context.l10n.thursday;
      case DayOfWeek.FRIDAY:
        return context.l10n.friday;
      case DayOfWeek.SATURDAY:
        return context.l10n.saturday;
      case DayOfWeek.SUNDAY:
        return context.l10n.sunday;
    }
  }

  void _showDeleteConfirmation(DriverSchedule schedule) {
    material.showDialog(
      context: context,
      builder: (dialogContext) => material.AlertDialog(
        title: Text(context.l10n.delete_schedule),
        content: Text(
          context.l10n.are_you_sure_you_want_to_delete_schedule(schedule.name),
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
