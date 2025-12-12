import "package:akademove/app/router/router.dart";
import "package:akademove/core/_export.dart";
import "package:akademove/l10n/l10n.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A reusable terms and conditions checkbox widget for authentication forms.
///
/// This widget displays a checkbox with a link to the terms of service page.
class AuthTermsCheckbox extends StatelessWidget {
  const AuthTermsCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
    this.enabled = true,
  });

  /// Whether the terms are accepted.
  final bool value;

  /// Callback when the checkbox state changes.
  final ValueChanged<bool> onChanged;

  /// Whether the checkbox is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.w,
      children: [
        Checkbox(
          state: value ? CheckboxState.checked : CheckboxState.unchecked,
          enabled: enabled,
          onChanged: (checkboxState) {
            onChanged(checkboxState == CheckboxState.checked);
          },
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              await context.pushNamed(Routes.termsOfService.name);
            },
            child: RichText(
              text: TextSpan(
                style: context.theme.typography.small.copyWith(fontSize: 12.sp),
                children: [
                  TextSpan(text: context.l10n.i_agree_to_the),
                  TextSpan(
                    text: " ${context.l10n.terms_and_conditions}",
                    style: TextStyle(
                      color: context.theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
