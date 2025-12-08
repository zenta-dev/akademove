import 'package:akademove/core/_export.dart';
import 'package:akademove/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:akademove/features/emergency/presentation/cubits/emergency_cubit.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog for triggering an emergency during active trip
/// Allows user/driver to select emergency type and provide description
class EmergencyTriggerDialog extends StatefulWidget {
  const EmergencyTriggerDialog({
    required this.orderId,
    required this.currentLocation,
    super.key,
  });

  final String orderId;
  final EmergencyLocation currentLocation;

  @override
  State<EmergencyTriggerDialog> createState() => _EmergencyTriggerDialogState();
}

class _EmergencyTriggerDialogState extends State<EmergencyTriggerDialog> {
  EmergencyType _selectedType = EmergencyType.OTHER;
  final _descriptionController = TextEditingController();
  bool _confirmed = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  String _getTypeLabel(BuildContext context, EmergencyType type) {
    switch (type) {
      case EmergencyType.ACCIDENT:
        return context.l10n.accident;
      case EmergencyType.HARASSMENT:
        return context.l10n.harassment;
      case EmergencyType.THEFT:
        return context.l10n.theft;
      case EmergencyType.MEDICAL:
        return context.l10n.medical;
      case EmergencyType.OTHER:
        return context.l10n.other;
    }
  }

  IconData _getTypeIcon(EmergencyType type) {
    switch (type) {
      case EmergencyType.ACCIDENT:
        return LucideIcons.car;
      case EmergencyType.HARASSMENT:
        return LucideIcons.userX;
      case EmergencyType.THEFT:
        return LucideIcons.triangleAlert;
      case EmergencyType.MEDICAL:
        return LucideIcons.heartPulse;
      case EmergencyType.OTHER:
        return LucideIcons.triangleAlert;
    }
  }

  void _handleTrigger() {
    if (_descriptionController.text.trim().isEmpty) {
      context.showMyToast(
        context.l10n.error_description_required,
        type: ToastType.failed,
      );
      return;
    }

    final cubit = context.read<EmergencyCubit>();
    final userId = context.read<AuthCubit>().state.user.data?.value.id;

    if (userId == null) {
      context.showMyToast('User not authenticated', type: ToastType.failed);
      return;
    }

    cubit.trigger(
      orderId: widget.orderId,
      userId: userId,
      type: _selectedType,
      description: _descriptionController.text.trim(),
      location: widget.currentLocation,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (!_confirmed) {
      return AlertDialog(
        title: Row(
          spacing: 12.w,
          children: [
            Icon(
              LucideIcons.triangleAlert,
              color: context.colorScheme.destructive,
              size: 28.sp,
            ),
            Text(context.l10n.emergency_alert_title),
          ],
        ),
        content: Text(
          context.l10n.message_confirmation,
          style: context.typography.p.copyWith(fontSize: 16.sp),
        ),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.l10n.cancel),
          ),
          DestructiveButton(
            onPressed: () {
              setState(() {
                _confirmed = true;
              });
            },
            child: Text(context.l10n.button_continue),
          ),
        ],
      );
    }

    return AlertDialog(
      title: Text(context.l10n.emergency_report_title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8.h,
          children: [
            Text(
              context.l10n.emergency_select_type,
              style: context.typography.semiBold.copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 4.h),
            // Emergency type selector
            ...EmergencyType.values.map((type) {
              final isSelected = _selectedType == type;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedType = type;
                  });
                },
                child: Card(
                  padding: EdgeInsets.all(12.dg),
                  borderWidth: isSelected ? 2 : 1,
                  borderColor: isSelected
                      ? context.colorScheme.destructive
                      : context.colorScheme.border,
                  child: Row(
                    spacing: 12.w,
                    children: [
                      Icon(
                        _getTypeIcon(type),
                        color: isSelected
                            ? context.colorScheme.destructive
                            : context.colorScheme.mutedForeground,
                      ),
                      Text(
                        _getTypeLabel(context, type),
                        style: context.typography.base.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: isSelected
                              ? context.colorScheme.destructive
                              : context.colorScheme.foreground,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(height: 8.h),
            Text(
              context.l10n.description,
              style: context.typography.semiBold.copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 4.h),
            TextField(
              controller: _descriptionController,
              placeholder: Text(context.l10n.emergency_describe_situation),
              maxLines: 4,
              maxLength: 500,
            ),
          ],
        ),
      ),
      actions: [
        OutlineButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.cancel),
        ),
        DestructiveButton(
          onPressed: _handleTrigger,
          child: Text(context.l10n.emergency_send_alert),
        ),
      ],
    );
  }
}
