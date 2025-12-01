import 'package:flutter/material.dart' as material;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog for rejecting a food order with predefined reasons and optional note
class OrderRejectionDialog extends material.StatefulWidget {
  const OrderRejectionDialog({super.key});

  @override
  material.State<OrderRejectionDialog> createState() =>
      _OrderRejectionDialogState();
}

class _OrderRejectionDialogState extends material.State<OrderRejectionDialog> {
  String _selectedReason = 'OUT_OF_STOCK';
  final _noteController = material.TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  material.Widget build(material.BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text('Reject Order'),
      content: material.SingleChildScrollView(
        child: material.SizedBox(
          width: material.MediaQuery.of(context).size.width * 0.8,
          child: material.Column(
            mainAxisSize: material.MainAxisSize.min,
            crossAxisAlignment: material.CrossAxisAlignment.start,
            children: [
              Text(
                'Please select a reason for rejecting this order:',
                style: theme.typography.small,
              ),
              material.SizedBox(height: 16.h),

              // Reason selector (radio buttons)
              ..._buildReasonOptions(),

              material.SizedBox(height: 16.h),

              // Optional note field
              Text(
                'Additional Note (Optional)',
                style: theme.typography.semiBold.copyWith(fontSize: 14.sp),
              ),
              material.SizedBox(height: 8.h),
              material.TextField(
                controller: _noteController,
                maxLines: 3,
                maxLength: 200,
                decoration: const material.InputDecoration(
                  hintText:
                      'e.g., "We ran out of chicken, will restock tomorrow"',
                  border: material.OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Button.ghost(
          onPressed: () => material.Navigator.of(context).pop(null),
          child: const Text('Cancel'),
        ),
        Button.destructive(
          onPressed: () {
            final note = _noteController.text.trim();
            material.Navigator.of(context).pop({
              'reason': _selectedReason,
              'note': note.isEmpty ? null : note,
            });
          },
          child: const Text('Reject Order'),
        ),
      ],
    );
  }

  List<material.Widget> _buildReasonOptions() {
    const reasons = {
      'OUT_OF_STOCK': 'Out of Stock',
      'TOO_BUSY': 'Too Busy / High Order Volume',
      'INGREDIENT_UNAVAILABLE': 'Ingredient Unavailable',
      'CLOSED': 'Store Closed / Closing Soon',
      'OTHER': 'Other',
    };

    return reasons.entries.map((entry) {
      final isSelected = _selectedReason == entry.key;
      return material.InkWell(
        onTap: () {
          setState(() => _selectedReason = entry.key);
        },
        child: material.Padding(
          padding: material.EdgeInsets.symmetric(vertical: 8.h),
          child: material.Row(
            children: [
              material.Container(
                width: 20,
                height: 20,
                decoration: material.BoxDecoration(
                  shape: material.BoxShape.circle,
                  border: material.Border.all(
                    color: isSelected
                        ? material.Colors.blue
                        : material.Colors.grey,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? material.Center(
                        child: material.Container(
                          width: 12,
                          height: 12,
                          decoration: const material.BoxDecoration(
                            shape: material.BoxShape.circle,
                            color: material.Colors.blue,
                          ),
                        ),
                      )
                    : null,
              ),
              material.SizedBox(width: 12.w),
              material.Expanded(child: Text(entry.value)),
            ],
          ),
        ),
      );
    }).toList();
  }
}

/// Helper function to show the rejection dialog
Future<Map<String, dynamic>?> showOrderRejectionDialog({
  required material.BuildContext context,
}) async {
  return material.showDialog<Map<String, dynamic>>(
    context: context,
    barrierDismissible: false,
    builder: (context) => const OrderRejectionDialog(),
  );
}
