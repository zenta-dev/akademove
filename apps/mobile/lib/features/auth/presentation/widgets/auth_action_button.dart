import "package:akademove/core/_export.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A reusable action button widget for multi-step authentication forms.
///
/// This widget creates consistent navigation buttons for step forms.
class AuthActionButton extends StatelessWidget {
  const AuthActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    super.key,
    this.isPrimary = false,
    this.isTrailing = false,
    this.textStyle,
  });

  /// The icon to display.
  final IconData icon;

  /// The button label.
  final String label;

  /// Callback when button is pressed.
  final VoidCallback onPressed;

  /// Whether this is a primary (filled) button.
  final bool isPrimary;

  /// Whether the icon should be trailing (after text).
  final bool isTrailing;

  /// Optional custom text style for the label.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(
      icon,
      size: 16.sp,
      color: isPrimary ? Colors.white : null,
    );

    final defaultStyle = isPrimary
        ? context.theme.typography.small.copyWith(color: Colors.white)
        : null;
    final textWidget = Text(label, style: textStyle ?? defaultStyle);

    final content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 4.w,
      children: isTrailing
          ? [textWidget, iconWidget]
          : [iconWidget, textWidget],
    );

    return Expanded(
      child: isPrimary
          ? PrimaryButton(onPressed: onPressed, child: content)
          : OutlineButton(onPressed: onPressed, child: content),
    );
  }
}
