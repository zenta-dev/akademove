// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_lookup_result_phone.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserLookupResultPhoneCWProxy {
  UserLookupResultPhone countryCode(String countryCode);

  UserLookupResultPhone maskedNumber(String maskedNumber);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserLookupResultPhone(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserLookupResultPhone(...).copyWith(id: 12, name: "My name")
  /// ```
  UserLookupResultPhone call({String countryCode, String maskedNumber});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserLookupResultPhone.copyWith(...)` or call `instanceOfUserLookupResultPhone.copyWith.fieldName(value)` for a single field.
class _$UserLookupResultPhoneCWProxyImpl
    implements _$UserLookupResultPhoneCWProxy {
  const _$UserLookupResultPhoneCWProxyImpl(this._value);

  final UserLookupResultPhone _value;

  @override
  UserLookupResultPhone countryCode(String countryCode) =>
      call(countryCode: countryCode);

  @override
  UserLookupResultPhone maskedNumber(String maskedNumber) =>
      call(maskedNumber: maskedNumber);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserLookupResultPhone(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserLookupResultPhone(...).copyWith(id: 12, name: "My name")
  /// ```
  UserLookupResultPhone call({
    Object? countryCode = const $CopyWithPlaceholder(),
    Object? maskedNumber = const $CopyWithPlaceholder(),
  }) {
    return UserLookupResultPhone(
      countryCode:
          countryCode == const $CopyWithPlaceholder() || countryCode == null
          ? _value.countryCode
          // ignore: cast_nullable_to_non_nullable
          : countryCode as String,
      maskedNumber:
          maskedNumber == const $CopyWithPlaceholder() || maskedNumber == null
          ? _value.maskedNumber
          // ignore: cast_nullable_to_non_nullable
          : maskedNumber as String,
    );
  }
}

extension $UserLookupResultPhoneCopyWith on UserLookupResultPhone {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserLookupResultPhone.copyWith(...)` or `instanceOfUserLookupResultPhone.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserLookupResultPhoneCWProxy get copyWith =>
      _$UserLookupResultPhoneCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLookupResultPhone _$UserLookupResultPhoneFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UserLookupResultPhone', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['countryCode', 'maskedNumber']);
  final val = UserLookupResultPhone(
    countryCode: $checkedConvert('countryCode', (v) => v as String),
    maskedNumber: $checkedConvert('maskedNumber', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$UserLookupResultPhoneToJson(
  UserLookupResultPhone instance,
) => <String, dynamic>{
  'countryCode': instance.countryCode,
  'maskedNumber': instance.maskedNumber,
};
