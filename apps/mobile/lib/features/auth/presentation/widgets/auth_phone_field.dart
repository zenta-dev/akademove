import "package:akademove/l10n/l10n.dart";
import "package:api_client/api_client.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A reusable phone input field widget for authentication forms.
///
/// This widget wraps shadcn_flutter's PhoneInput with common
/// configurations used across auth screens.
class AuthPhoneField extends StatelessWidget {
  const AuthPhoneField({
    this.onChanged,
    super.key,
    this.enabled = true,
    this.label,
    this.labelStyle,
  });

  /// Callback when the phone number changes.
  /// Returns the country code and phone number.
  /// If null, the field is read-only.
  final void Function(CountryCode countryCode, String? phoneNumber)? onChanged;

  /// Whether the field is enabled.
  final bool enabled;

  /// Optional label override.
  final String? label;

  /// Optional custom style for the label.
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final labelWidget = labelStyle != null
        ? Text(label ?? context.l10n.phone, style: labelStyle)
        : Text(label ?? context.l10n.phone).small(fontWeight: FontWeight.w500);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        labelWidget,
        ComponentTheme(
          data: PhoneInputTheme(
            flagWidth: 22.w,
            popupConstraints: BoxConstraints(maxHeight: 0.2.sh),
          ),
          child: PhoneInput(
            initialCountry: Country.indonesia,
            countries: const [Country.indonesia],
            onChanged: (value) {
              final callback = onChanged;
              if (callback == null) return;
              CountryCode countryCode = CountryCode.ID;
              switch (value.country) {
                case Country.indonesia:
                  countryCode = CountryCode.ID;
                default:
              }
              callback(countryCode, value.number);
            },
          ),
        ),
      ],
    );
  }
}
