import "dart:io";

import "package:akademove/core/_export.dart";
import "package:akademove/l10n/l10n.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A reusable image picker widget for authentication forms.
///
/// This widget wraps ImagePickerWidget with label and error display.
class AuthImagePicker extends StatelessWidget {
  const AuthImagePicker({
    required this.label,
    required this.onChanged,
    super.key,
    this.error,
    this.height,
  });

  /// The label displayed above the picker.
  final String label;

  /// Callback when a file is selected.
  final ValueChanged<File?> onChanged;

  /// Optional error message to display.
  final String? error;

  /// Optional height for the picker.
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(label),
        ImagePickerWidget(
          size: Size(double.infinity, height ?? 64.h),
          onValueChanged: onChanged,
        ),
        if (error != null)
          DefaultTextStyle.merge(
            style: TextStyle(color: context.theme.colorScheme.destructive),
            child: Text(
              error ?? context.l10n.error_photo_pick_failed,
            ).xSmall().medium(),
          ),
      ],
    );
  }
}
