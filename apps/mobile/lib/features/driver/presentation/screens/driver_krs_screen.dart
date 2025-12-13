import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverKrsScreen extends StatefulWidget {
  const DriverKrsScreen({super.key});

  @override
  State<DriverKrsScreen> createState() => _DriverKrsScreenState();
}

class _DriverKrsScreenState extends State<DriverKrsScreen> {
  @override
  void initState() {
    super.initState();
    _initSchedules();
  }

  void _initSchedules() {
    // Get driverId from DriverProfileCubit (single source of truth)
    final driverId = context.read<DriverProfileCubit>().driver?.id;
    if (driverId != null) {
      final scheduleCubit = context.read<DriverScheduleCubit>();
      scheduleCubit.setDriverId(driverId);
      scheduleCubit.getSchedules();
    }
  }

  Future<void> _onRefresh() async {
    await context.read<DriverScheduleCubit>().getSchedules();
  }

  void _navigateToUpsert({DriverSchedule? schedule}) async {
    final result = await context.pushNamed<bool>(
      Routes.driverKrsUpsert.name,
      extra: schedule,
    );
    if (result == true) {
      await context.read<DriverScheduleCubit>().getSchedules();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        DefaultAppBar(
          title: context.l10n.my_schedule,
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 9.r),
          trailing: [
            IconButton(
              icon: const Icon(LucideIcons.plus),
              onPressed: () => _navigateToUpsert(),
              variance: ButtonVariance.ghost,
            ),
          ],
        ),
      ],
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: RefreshTrigger(
          onRefresh: _onRefresh,
          child: BlocConsumer<DriverScheduleCubit, DriverScheduleState>(
            listener: (context, state) {
              // Handle fetch schedules failure
              if (state.fetchSchedulesResult.isFailure) {
                context.showMyToast(
                  state.fetchSchedulesResult.error?.message ??
                      context.l10n.an_error_occurred,
                  type: ToastType.failed,
                );
              }

              // Handle delete schedule result
              if (state.deleteScheduleResult.isSuccess) {
                context.showMyToast(
                  context.l10n.schedule_deleted_successfully,
                  type: ToastType.success,
                );
              }
              if (state.deleteScheduleResult.isFailure) {
                context.showMyToast(
                  state.deleteScheduleResult.error?.message ??
                      context.l10n.failed_to_delete_schedule,
                  type: ToastType.failed,
                );
              }
            },
            builder: (context, state) {
              if (state.fetchSchedulesResult.isLoading) {
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: 4,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    return _buildScheduleCard(dummyDriverSchedule);
                  },
                ).asSkeleton();
              }

              final schedules = state.fetchSchedulesResult.value ?? [];

              if (schedules.isEmpty) {
                return _buildEmptyState();
              }

              return ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: schedules.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  if (index >= schedules.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return _buildScheduleCard(schedules[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // -------------------------
  // EMPTY STATE
  // -------------------------
  Widget _buildEmptyState() {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.dg),
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
                    textAlign: TextAlign.center,
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
                    onPressed: () => _navigateToUpsert(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8,
                      children: [
                        const Icon(LucideIcons.plus),
                        Text(context.l10n.button_add_schedule),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // -------------------------
  // SCHEDULE CARD
  // -------------------------
  Widget _buildScheduleCard(DriverSchedule schedule) {
    final dayColor = _getDayColor(schedule.dayOfWeek);
    final isActive = schedule.isActive ?? true;

    return IntrinsicHeight(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
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
                      ? const Color(0xFF4CAF50)
                      : context.colorScheme.mutedForeground,
                ),
              ],
            ),

            const Divider(),

            // Time
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
                      color: context.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      context.l10n.recurring,
                      style: context.typography.small.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),

            // Buttons
            Row(
              spacing: 8.w,
              children: [
                Expanded(
                  child: OutlineButton(
                    onPressed: () => _navigateToUpsert(schedule: schedule),
                    child: Text(context.l10n.button_edit),
                  ),
                ),
                Expanded(
                  child: DestructiveButton(
                    onPressed: () => _showDeleteConfirmation(schedule),
                    child: Text(context.l10n.button_delete),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------
  // HELPERS
  // -------------------------
  Color _getDayColor(DayOfWeek day) {
    switch (day) {
      case DayOfWeek.MONDAY:
        return const Color(0xFFF44336);
      case DayOfWeek.TUESDAY:
        return const Color(0xFFFF9800);
      case DayOfWeek.WEDNESDAY:
        return const Color(0xFFFFEB3B);
      case DayOfWeek.THURSDAY:
        return const Color(0xFF4CAF50);
      case DayOfWeek.FRIDAY:
        return const Color(0xFF2196F3);
      case DayOfWeek.SATURDAY:
        return const Color(0xFF9C27B0);
      case DayOfWeek.SUNDAY:
        return const Color(0xFFE91E63);
    }
  }

  String _getDayText(DayOfWeek day) {
    return day.name.substring(0, 3);
  }

  String _formatTime(Time time) {
    final h = time.h.toString().padLeft(2, '0');
    final m = time.m.toString().padLeft(2, '0');
    return '$h:$m';
  }

  void _showDeleteConfirmation(DriverSchedule schedule) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.delete_schedule),
        content: Text(
          context.l10n.are_you_sure_you_want_to_delete_schedule(schedule.name),
        ),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.button_cancel),
          ),
          DestructiveButton(
            onPressed: () {
              context.read<DriverScheduleCubit>().removeSchedule(
                scheduleId: schedule.id,
              );
              Navigator.of(dialogContext).pop();
            },
            child: Text(context.l10n.button_delete),
          ),
        ],
      ),
    );
  }
}
