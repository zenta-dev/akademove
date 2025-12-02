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
    showToast(
      context: context,
      builder: (context, overlay) => context.buildToast(
        title: 'Add Schedule',
        message: 'Add schedule feature coming soon',
      ),
    );
  }

  void _showEditScheduleDialog(DriverSchedule schedule) {
    showToast(
      context: context,
      builder: (context, overlay) => context.buildToast(
        title: 'Edit Schedule',
        message: 'Edit schedule feature coming soon',
      ),
    );
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
