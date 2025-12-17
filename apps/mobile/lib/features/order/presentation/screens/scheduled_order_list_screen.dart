import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ScheduledOrderListScreen extends StatefulWidget {
  const ScheduledOrderListScreen({super.key});

  @override
  State<ScheduledOrderListScreen> createState() =>
      _ScheduledOrderListScreenState();
}

class _ScheduledOrderListScreenState extends State<ScheduledOrderListScreen> {
  @override
  void initState() {
    super.initState();
    _loadScheduledOrders();
  }

  Future<void> _loadScheduledOrders() async {
    try {
      await context.read<UserOrderCubit>().listScheduledOrders();
    } on BaseError catch (e) {
      if (mounted) {
        context.showMyToast(e.message);
      }
    } catch (e) {
      if (mounted) {
        context.showMyToast(context.l10n.failed_to_load_scheduled_orders);
      }
    }
  }

  Future<void> _onRefresh() async {
    await _loadScheduledOrders();
  }

  void _onEditScheduledOrder(Order order) {
    _showEditScheduleBottomSheet(context, order);
  }

  void _onCancelScheduledOrder(Order order) {
    _showCancelConfirmDialog(context, order);
  }

  void _showEditScheduleBottomSheet(BuildContext context, Order order) {
    final cubit = context.read<UserOrderCubit>();
    final successMessage = context.l10n.scheduled_order_updated;
    final configCubit = context.read<SharedConfigurationCubit>();
    final businessConfig = configCubit.state.businessConfiguration.value;
    final minAdvanceMinutes =
        businessConfig?.scheduledOrderMinAdvanceMinutes?.toInt() ?? 30;
    final maxAdvanceDays =
        businessConfig?.scheduledOrderMaxAdvanceDays?.toInt() ?? 7;
    openDrawer(
      context: context,
      position: OverlayPosition.bottom,
      builder: (drawerContext) => ScheduledOrderEditBottomSheet(
        order: order,
        minAdvanceMinutes: minAdvanceMinutes,
        maxAdvanceDays: maxAdvanceDays,
        onSave: (newDateTime) async {
          final result = await cubit.updateScheduledOrder(
            order.id,
            newDateTime,
          );
          if (result != null && mounted) {
            this.context.showMyToast(successMessage);
          }
        },
        onClose: () => closeDrawer(drawerContext),
      ),
    );
  }

  void _showCancelConfirmDialog(BuildContext context, Order order) {
    final cubit = context.read<UserOrderCubit>();
    final cancelTitle = context.l10n.cancel_scheduled_order;
    final cancelContent = context.l10n.cancel_scheduled_order_confirm;
    final noText = context.l10n.no;
    final yesCancelText = context.l10n.yes_cancel;
    final successMessage = context.l10n.scheduled_order_cancelled;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(cancelTitle),
        content: Text(cancelContent),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(noText),
          ),
          DestructiveButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              final result = await cubit.cancelScheduledOrder(order.id);
              if (result != null && mounted) {
                this.context.showMyToast(successMessage);
              }
            },
            child: Text(yesCancelText),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserOrderCubit, UserOrderState>(
      builder: (context, state) {
        final scheduledOrders = state.scheduledOrders.value ?? [];
        final isLoading = state.scheduledOrders.isLoading;

        return Scaffold(
          headers: [
            DefaultAppBar(
              title: context.l10n.scheduled_orders,
              padding: EdgeInsets.all(16.r),
            ),
          ],
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeRefreshTrigger(
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    child: scheduledOrders.isEmpty
                        ? _buildEmptyState()
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: scheduledOrders.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              final order = scheduledOrders[index];
                              return ScheduledOrderCardWidget(
                                order: order,
                                onTap: () => context
                                    .read<UserOrderCubit>()
                                    .selectScheduledOrder(order),
                                onEdit: () => _onEditScheduledOrder(order),
                                onCancel: () => _onCancelScheduledOrder(order),
                              );
                            },
                          ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16.h,
          children: [
            Icon(
              LucideIcons.calendarClock,
              size: 64.sp,
              color: context.colorScheme.mutedForeground,
            ),
            Text(
              context.l10n.no_scheduled_orders,
              style: context.typography.h3.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              context.l10n.no_scheduled_orders_desc,
              textAlign: TextAlign.center,
              style: context.typography.p.copyWith(
                fontSize: 14.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom sheet for editing scheduled order time
class ScheduledOrderEditBottomSheet extends StatefulWidget {
  const ScheduledOrderEditBottomSheet({
    required this.order,
    required this.onSave,
    required this.onClose,
    this.minAdvanceMinutes = 30,
    this.maxAdvanceDays = 7,
    super.key,
  });

  final Order order;
  final Future<void> Function(DateTime newDateTime) onSave;
  final VoidCallback onClose;
  final int minAdvanceMinutes;
  final int maxAdvanceDays;

  @override
  State<ScheduledOrderEditBottomSheet> createState() =>
      _ScheduledOrderEditBottomSheetState();
}

class _ScheduledOrderEditBottomSheetState
    extends State<ScheduledOrderEditBottomSheet> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Convert UTC to local time for editing
    final scheduledAt =
        widget.order.scheduledAt?.toLocal() ??
        DateTime.now().add(const Duration(hours: 1));
    _selectedDate = scheduledAt;
    _selectedTime = TimeOfDay.fromDateTime(scheduledAt);
  }

  DateTime get _minDate =>
      DateTime.now().add(Duration(minutes: widget.minAdvanceMinutes));
  DateTime get _maxDate =>
      DateTime.now().add(Duration(days: widget.maxAdvanceDays));

  DateState _dateStateBuilder(DateTime date) {
    final dateOnly = DateTime(date.year, date.month, date.day);
    final minDateOnly = DateTime(_minDate.year, _minDate.month, _minDate.day);
    final maxDateOnly = DateTime(_maxDate.year, _maxDate.month, _maxDate.day);

    if (dateOnly.isBefore(minDateOnly) || dateOnly.isAfter(maxDateOnly)) {
      return DateState.disabled;
    }
    return DateState.enabled;
  }

  Future<void> _onSave() async {
    final newDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    // Validate the selected time using local time
    final now = DateTime.now();
    final minTime = now.add(Duration(minutes: widget.minAdvanceMinutes));
    final maxTime = now.add(Duration(days: widget.maxAdvanceDays));

    if (newDateTime.isBefore(minTime)) {
      context.showMyToast(context.l10n.schedule_time_too_soon);
      return;
    }

    if (newDateTime.isAfter(maxTime)) {
      context.showMyToast(context.l10n.schedule_time_too_far);
      return;
    }

    setState(() => _isSaving = true);

    try {
      // Convert to UTC for server consistency
      await widget.onSave(newDateTime.toUtc());
      widget.onClose();
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 400.h),
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.h,
        children: [
          Text(
            context.l10n.edit_schedule,
            style: context.typography.h3.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),

          // Date picker
          Row(
            children: [
              Icon(LucideIcons.calendar, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.schedule_date,
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                    DatePicker(
                      value: _selectedDate,
                      mode: PromptMode.dialog,
                      dialogTitle: Text(context.l10n.schedule_date),
                      stateBuilder: _dateStateBuilder,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedDate = value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Time picker
          Row(
            children: [
              Icon(LucideIcons.clock, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.schedule_time,
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                    TimePicker(
                      value: _selectedTime,
                      mode: PromptMode.dialog,
                      dialogTitle: Text(context.l10n.schedule_time),
                      onChanged: (value) {
                        setState(() {
                          _selectedTime = value ?? TimeOfDay.now();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Info text
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: context.colorScheme.muted.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  LucideIcons.info,
                  size: 16.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    context.l10n.min_schedule_time,
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Save button
          Row(
            spacing: 12.w,
            children: [
              Expanded(
                child: OutlineButton(
                  onPressed: _isSaving ? null : widget.onClose,
                  child: Text(context.l10n.cancel),
                ),
              ),
              Expanded(
                child: PrimaryButton(
                  onPressed: _isSaving ? null : _onSave,
                  child: _isSaving
                      ? SizedBox(
                          width: 20.sp,
                          height: 20.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Text(context.l10n.confirm_schedule),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
