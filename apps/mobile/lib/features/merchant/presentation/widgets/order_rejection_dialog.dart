import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Typed result class for order rejection dialog
class OrderRejectionResult {
  const OrderRejectionResult({required this.reason, this.note});

  final String reason;
  final String? note;
}

/// Dialog for rejecting a food order with predefined reasons and optional note
class OrderRejectionDialog extends StatefulWidget {
  const OrderRejectionDialog({super.key});

  @override
  State<OrderRejectionDialog> createState() => _OrderRejectionDialogState();
}

class _OrderRejectionDialogState extends State<OrderRejectionDialog> {
  String _selectedReason = 'OUT_OF_STOCK';
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.title_reject_order),
      content: SingleChildScrollView(
        child: SizedBox(
          width: context.mediaQuerySize.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              Text(
                context.l10n.text_select_rejection_reason,
                style: context.typography.small,
              ),
              SizedBox(height: 4.h),

              // Reason selector (radio buttons)
              ..._buildReasonOptions(),

              SizedBox(height: 4.h),

              // Optional note field
              Text(
                context.l10n.label_additional_note_optional,
                style: context.typography.semiBold.copyWith(fontSize: 14.sp),
              ),
              SizedBox(height: 4.h),
              TextField(
                controller: _noteController,
                maxLines: 3,
                maxLength: 200,
                placeholder: Text(context.l10n.placeholder_rejection_note),
              ),
            ],
          ),
        ),
      ),
      actions: [
        GhostButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(context.l10n.button_cancel),
        ),
        DestructiveButton(
          onPressed: () {
            final note = _noteController.text.trim();
            Navigator.of(context).pop(
              OrderRejectionResult(
                reason: _selectedReason,
                note: note.isEmpty ? null : note,
              ),
            );
          },
          child: Text(context.l10n.button_reject_order),
        ),
      ],
    );
  }

  List<Widget> _buildReasonOptions() {
    final reasons = {
      'OUT_OF_STOCK': context.l10n.rejection_reason_out_of_stock,
      'TOO_BUSY': context.l10n.rejection_reason_too_busy,
      'INGREDIENT_UNAVAILABLE':
          context.l10n.rejection_reason_ingredient_unavailable,
      'CLOSED': context.l10n.rejection_reason_closed,
      'OTHER': context.l10n.rejection_reason_other,
    };

    return reasons.entries.map((entry) {
      final isSelected = _selectedReason == entry.key;
      return GestureDetector(
        onTap: () {
          setState(() => _selectedReason = entry.key);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            spacing: 12.w,
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? context.colorScheme.primary
                        : context.colorScheme.border,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      )
                    : null,
              ),
              Expanded(child: Text(entry.value)),
            ],
          ),
        ),
      );
    }).toList();
  }
}

/// Helper function to show the rejection dialog
Future<OrderRejectionResult?> showOrderRejectionDialog({
  required BuildContext context,
}) async {
  return showDialog<OrderRejectionResult>(
    context: context,
    barrierDismissible: false,
    builder: (context) => const OrderRejectionDialog(),
  );
}
