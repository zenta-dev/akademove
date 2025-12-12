import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverKrsUpsertScreen extends StatefulWidget {
  const DriverKrsUpsertScreen({super.key, this.schedule});

  final DriverSchedule? schedule;

  @override
  State<DriverKrsUpsertScreen> createState() => _DriverKrsUpsertScreenState();
}

class _DriverKrsUpsertScreenState extends State<DriverKrsUpsertScreen> {
  late final TextEditingController _nameController;
  late DayOfWeek _selectedDay;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late bool _isRecurring;
  late bool _isActive;

  bool get _isEditing => widget.schedule != null;

  @override
  void initState() {
    super.initState();
    final schedule = widget.schedule;

    _nameController = TextEditingController(text: schedule?.name);
    _selectedDay = schedule?.dayOfWeek ?? DayOfWeek.MONDAY;
    _startTime = schedule != null
        ? TimeOfDay(
            hour: schedule.startTime.h.toInt(),
            minute: schedule.startTime.m.toInt(),
          )
        : const TimeOfDay(hour: 8, minute: 0);
    _endTime = schedule != null
        ? TimeOfDay(
            hour: schedule.endTime.h.toInt(),
            minute: schedule.endTime.m.toInt(),
          )
        : const TimeOfDay(hour: 10, minute: 0);
    _isRecurring = schedule?.isRecurring ?? true;
    _isActive = schedule?.isActive ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSave() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      context.showMyToast(
        context.l10n.please_enter_a_schedule_name,
        type: ToastType.failed,
      );
      return;
    }

    final timeStart = Time(h: _startTime.hour, m: _startTime.minute);
    final timeEnd = Time(h: _endTime.hour, m: _endTime.minute);

    if (_isEditing) {
      context.read<DriverScheduleCubit>().updateSchedule(
        scheduleId: widget.schedule!.id,
        request: DriverScheduleUpdateRequest(
          name: name,
          dayOfWeek: _selectedDay,
          startTime: timeStart,
          endTime: timeEnd,
          isRecurring: _isRecurring,
          isActive: _isActive,
        ),
      );
    } else {
      context.read<DriverScheduleCubit>().createSchedule(
        request: DriverScheduleCreateRequest(
          name: name,
          driverId: '',
          dayOfWeek: _selectedDay,
          startTime: timeStart,
          endTime: timeEnd,
          isRecurring: _isRecurring,
          isActive: _isActive,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        DefaultAppBar(
          title: _isEditing
              ? context.l10n.title_edit_schedule
              : context.l10n.title_add_schedule,
        ),
      ],
      child: SafeArea(
        child: BlocConsumer<DriverScheduleCubit, DriverScheduleState>(
          listener: (context, state) {
            // Handle create schedule result
            if (!_isEditing && state.createScheduleResult.isSuccess) {
              context.showMyToast(
                context.l10n.schedule_added_successfully,
                type: ToastType.success,
              );
              context.pop(true);
            }
            if (!_isEditing && state.createScheduleResult.isFailure) {
              context.showMyToast(
                state.createScheduleResult.error?.message ??
                    context.l10n.failed_to_add_schedule,
                type: ToastType.failed,
              );
            }

            // Handle update schedule result
            if (_isEditing && state.updateScheduleResult.isSuccess) {
              context.showMyToast(
                context.l10n.schedule_updated_successfully,
                type: ToastType.success,
              );
              context.pop(true);
            }
            if (_isEditing && state.updateScheduleResult.isFailure) {
              context.showMyToast(
                state.updateScheduleResult.error?.message ??
                    context.l10n.failed_to_update_schedule,
                type: ToastType.failed,
              );
            }
          },
          builder: (context, state) {
            final isLoading =
                state.createScheduleResult.isLoading ||
                state.updateScheduleResult.isLoading;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.dg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Course name
                        Text(
                          context.l10n.placeholder_course_name,
                          style: context.typography.p.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: _nameController,
                          placeholder: Text(
                            context.l10n.placeholder_course_name,
                          ),
                          enabled: !isLoading,
                        ),
                        SizedBox(height: 24.h),

                        // Day of week
                        Text(
                          context.l10n.day_of_week,
                          style: context.typography.p.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Select<DayOfWeek>(
                          value: _selectedDay,
                          onChanged: isLoading
                              ? null
                              : (value) {
                                  if (value != null) {
                                    setState(() => _selectedDay = value);
                                  }
                                },
                          placeholder: Text(context.l10n.day_of_week),
                          itemBuilder: (itemContext, item) {
                            return Text(_getDayFullText(context, item));
                          },
                          popupConstraints: BoxConstraints(
                            maxHeight: 300.h,
                            maxWidth: 300.w,
                          ),
                          popup: SelectPopup(
                            items: SelectItemList(
                              children: [
                                for (final day in DayOfWeek.values)
                                  SelectItemButton(
                                    value: day,
                                    child: Text(_getDayFullText(context, day)),
                                  ),
                              ],
                            ),
                          ).call,
                        ),
                        SizedBox(height: 24.h),

                        // Start time
                        Text(
                          context.l10n.start_time,
                          style: context.typography.p.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TimePicker(
                          value: _startTime,
                          mode: PromptMode.dialog,
                          dialogTitle: Text(context.l10n.start_time),
                          onChanged: isLoading
                              ? null
                              : (value) {
                                  setState(() {
                                    _startTime = value ?? _startTime;
                                  });
                                },
                        ),
                        SizedBox(height: 24.h),

                        // End time
                        Text(
                          context.l10n.end_time,
                          style: context.typography.p.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TimePicker(
                          value: _endTime,
                          mode: PromptMode.dialog,
                          dialogTitle: Text(context.l10n.end_time),
                          onChanged: isLoading
                              ? null
                              : (value) {
                                  setState(() {
                                    _endTime = value ?? _endTime;
                                  });
                                },
                        ),
                        SizedBox(height: 24.h),

                        // Recurring switch
                        _buildSwitchTile(
                          title: context.l10n.recurring,
                          subtitle: context.l10n.repeat_every_week,
                          value: _isRecurring,
                          enabled: !isLoading,
                          onChanged: (value) =>
                              setState(() => _isRecurring = value),
                        ),
                        SizedBox(height: 16.h),

                        // Active switch
                        _buildSwitchTile(
                          title: context.l10n.active,
                          subtitle:
                              context.l10n.disable_orders_during_this_time,
                          value: _isActive,
                          enabled: !isLoading,
                          onChanged: (value) =>
                              setState(() => _isActive = value),
                        ),
                      ],
                    ),
                  ),
                ),

                // Save button
                Padding(
                  padding: EdgeInsets.all(16.dg),
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      onPressed: isLoading ? null : _handleSave,
                      child: isLoading
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              _isEditing
                                  ? context.l10n.update
                                  : context.l10n.add,
                            ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required bool enabled,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: enabled ? () => onChanged(!value) : null,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.typography.p.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: enabled ? onChanged : null),
        ],
      ),
    );
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
}
