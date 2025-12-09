import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
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
    material.showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => ScheduledOrderEditBottomSheet(
        order: order,
        onSave: (newDateTime) async {
          final result = await context
              .read<UserOrderCubit>()
              .updateScheduledOrder(order.id, newDateTime);
          if (result != null && mounted) {
            context.showMyToast(context.l10n.scheduled_order_updated);
          }
        },
      ),
    );
  }

  void _showCancelConfirmDialog(BuildContext context, Order order) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.cancel_scheduled_order),
        content: Text(context.l10n.cancel_scheduled_order_confirm),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.no),
          ),
          DestructiveButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              final result = await context
                  .read<UserOrderCubit>()
                  .cancelScheduledOrder(order.id);
              if (result != null && mounted) {
                context.showMyToast(context.l10n.scheduled_order_cancelled);
              }
            },
            child: Text(context.l10n.yes_cancel),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserOrderCubit, UserOrderState>(
      builder: (context, state) {
        final scheduledOrders = state.scheduledOrders ?? [];
        final isLoading = state.state == CubitState.loading;

        return MyScaffold(
          headers: [
            DefaultAppBar(
              title: context.l10n.scheduled_orders,
              padding: EdgeInsets.all(16.r),
            ),
          ],
          scrollable: false,
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshTrigger(
                  onRefresh: _onRefresh,
                  child: scheduledOrders.isEmpty
                      ? _buildEmptyState()
                      : ListView.separated(
                          padding: EdgeInsets.all(16.dg),
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
    super.key,
  });

  final Order order;
  final Future<void> Function(DateTime newDateTime) onSave;

  @override
  State<ScheduledOrderEditBottomSheet> createState() =>
      _ScheduledOrderEditBottomSheetState();
}

class _ScheduledOrderEditBottomSheetState
    extends State<ScheduledOrderEditBottomSheet> {
  late DateTime _selectedDate;
  late material.TimeOfDay _selectedTime;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final scheduledAt =
        widget.order.scheduledAt ??
        DateTime.now().add(const Duration(hours: 1));
    _selectedDate = scheduledAt;
    _selectedTime = material.TimeOfDay.fromDateTime(scheduledAt);
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final minDate = now.add(const Duration(minutes: 30));
    final maxDate = now.add(const Duration(days: 7));

    final picked = await material.showDatePicker(
      context: context,
      initialDate: _selectedDate.isBefore(minDate) ? minDate : _selectedDate,
      firstDate: minDate,
      lastDate: maxDate,
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime() async {
    final picked = await material.showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  Future<void> _onSave() async {
    final newDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    // Validate the selected time
    final now = DateTime.now();
    final minTime = now.add(const Duration(minutes: 30));
    final maxTime = now.add(const Duration(days: 7));

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
      await widget.onSave(newDateTime);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  String _formatTimeOfDay(material.TimeOfDay t) {
    return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
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
          GhostButton(
            onPressed: _selectDate,
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.border),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
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
                        Text(
                          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          style: context.typography.p.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(LucideIcons.chevronRight, size: 20.sp),
                ],
              ),
            ),
          ),

          // Time picker
          GhostButton(
            onPressed: _selectTime,
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.border),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
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
                        Text(
                          _formatTimeOfDay(_selectedTime),
                          style: context.typography.p.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(LucideIcons.chevronRight, size: 20.sp),
                ],
              ),
            ),
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
                  onPressed: _isSaving
                      ? null
                      : () => Navigator.of(context).pop(),
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
