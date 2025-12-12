import "package:akademove/core/_export.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A reusable enum select widget for authentication forms.
///
/// This widget wraps shadcn_flutter's Select for enum values.
class AuthEnumSelect<T extends Enum> extends StatelessWidget {
  const AuthEnumSelect({
    required this.items,
    required this.onChanged,
    super.key,
    this.label,
    this.placeholder,
    this.value,
    this.enabled = true,
    this.showError = false,
    this.errorMessage,
    this.itemBuilder,
    this.labelStyle,
    this.placeholderStyle,
  });

  /// Optional label displayed above the select.
  final String? label;

  /// The placeholder text when no value is selected.
  final String? placeholder;

  /// The currently selected value.
  final T? value;

  /// The list of enum values to display.
  final List<T> items;

  /// Callback when the selection changes.
  final ValueChanged<T?> onChanged;

  /// Whether the select is enabled.
  final bool enabled;

  /// Whether to show error state when value is null.
  final bool showError;

  /// Custom error message.
  final String? errorMessage;

  /// Optional custom item builder.
  final Widget Function(BuildContext context, T item)? itemBuilder;

  /// Optional custom style for the label.
  final TextStyle? labelStyle;

  /// Optional custom style for the placeholder.
  final TextStyle? placeholderStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        if (label != null) Text(label!, style: labelStyle),
        SizedBox(
          width: double.infinity,
          child: Select<T>(
            enabled: enabled,
            itemBuilder: itemBuilder ?? (context, item) => Text(item.name),
            value: value,
            placeholder: placeholder != null
                ? Text(placeholder!, style: placeholderStyle)
                : null,
            onChanged: onChanged,
            popup: SelectPopup<T>(
              items: SelectItemList(
                children: items.map((e) {
                  final builder = itemBuilder;
                  return SelectItemButton(
                    value: e,
                    child: builder != null ? builder(context, e) : Text(e.name),
                  );
                }).toList(),
              ),
            ).call,
          ),
        ),
        if (showError && value == null)
          DefaultTextStyle.merge(
            style: TextStyle(color: context.theme.colorScheme.destructive),
            child: Text(errorMessage ?? "Must be selected").xSmall().medium(),
          ),
      ],
    );
  }
}
