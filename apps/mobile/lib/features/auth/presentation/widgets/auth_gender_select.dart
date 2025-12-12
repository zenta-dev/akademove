import "package:akademove/l10n/l10n.dart";
import "package:api_client/api_client.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A reusable gender selection widget for authentication forms.
///
/// This widget wraps shadcn_flutter's Select with common
/// configurations used across auth screens.
class AuthGenderSelect extends StatelessWidget {
  const AuthGenderSelect({
    required this.value,
    required this.onChanged,
    super.key,
    this.enabled = true,
    this.label,
  });

  /// The currently selected gender.
  final UserGender value;

  /// Callback when the gender selection changes.
  final ValueChanged<UserGender?> onChanged;

  /// Whether the select is enabled.
  final bool enabled;

  /// Optional label override.
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(label ?? context.l10n.gender).small(fontWeight: FontWeight.w500),
        SizedBox(
          width: double.infinity,
          child: Select<UserGender>(
            enabled: enabled,
            itemBuilder: (context, item) {
              return Text(item.name);
            },
            value: value,
            onChanged: onChanged,
            popup: SelectPopup<UserGender>(
              items: SelectItemList(
                children: UserGender.values
                    .map((e) => SelectItemButton(value: e, child: Text(e.name)))
                    .toList(),
              ),
            ).call,
          ),
        ),
      ],
    );
  }
}
