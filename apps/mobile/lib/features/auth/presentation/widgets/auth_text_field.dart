import "package:flutter/services.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A reusable text field widget for authentication forms.
///
/// This widget wraps shadcn_flutter's FormField and TextField
/// with common configurations used across auth screens.
class AuthTextField<T> extends StatelessWidget {
  const AuthTextField({
    required this.formKey,
    required this.label,
    required this.placeholder,
    required this.icon,
    required this.validator,
    required this.enabled,
    super.key,
    this.keyboardType,
    this.isPassword = false,
    this.textInputAction,
    this.focusNode,
    this.onSubmitted,
  });

  /// The form key for this field.
  final FormKey<String> formKey;

  /// The label displayed above the field.
  final String label;

  /// The placeholder text shown when field is empty.
  final String placeholder;

  /// The leading icon for the field.
  final IconData icon;

  /// The validator for this field.
  final Validator<T> validator;

  /// Whether the field is enabled.
  final bool enabled;

  /// The keyboard type for this field.
  final TextInputType? keyboardType;

  /// Whether this is a password field.
  final bool isPassword;

  /// The text input action for this field.
  final TextInputAction? textInputAction;

  /// The focus node for this field.
  final FocusNode? focusNode;

  /// Callback when the field is submitted.
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return FormField(
      key: formKey,
      label: Text(label),
      validator: validator,
      showErrors: const {
        FormValidationMode.changed,
        FormValidationMode.submitted,
      },
      child: TextField(
        placeholder: Text(placeholder),
        enabled: enabled,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        features: [
          InputFeature.leading(Icon(icon)),
          if (isPassword) const InputFeature.passwordToggle(),
        ],
      ),
    );
  }
}
