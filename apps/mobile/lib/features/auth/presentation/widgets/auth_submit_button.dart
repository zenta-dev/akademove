import "package:akademove/core/_export.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A reusable submit button widget for authentication forms.
///
/// This widget wraps FormErrorBuilder and Button with common
/// configurations used across auth screens.
class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    required this.label,
    required this.isLoading,
    super.key,
    this.isDisabled = false,
  });

  /// The button label text.
  final String label;

  /// Whether the form is currently submitting.
  final bool isLoading;

  /// Whether the button is disabled (e.g., terms not accepted).
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return FormErrorBuilder(
      builder: (context, errors, child) {
        final hasErrors = errors.isNotEmpty;

        return Button(
          style: isLoading || hasErrors || isDisabled
              ? const ButtonStyle.outline()
              : const ButtonStyle.primary(),
          onPressed: (!hasErrors && !isLoading && !isDisabled)
              ? () => context.submitForm()
              : null,
          child: isLoading
              ? const Submiting(simpleText: true)
              : Text(
                  label,
                  style: context.theme.typography.medium.copyWith(
                    color: Colors.white,
                  ),
                ),
        );
      },
    );
  }
}
