// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_with_contact_user_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyWithContactUserInfoCWProxy {
  EmergencyWithContactUserInfo id(String id);

  EmergencyWithContactUserInfo name(String name);

  EmergencyWithContactUserInfo phone(String? phone);

  EmergencyWithContactUserInfo gender(String? gender);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyWithContactUserInfo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyWithContactUserInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyWithContactUserInfo call({
    String id,
    String name,
    String? phone,
    String? gender,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyWithContactUserInfo.copyWith(...)` or call `instanceOfEmergencyWithContactUserInfo.copyWith.fieldName(value)` for a single field.
class _$EmergencyWithContactUserInfoCWProxyImpl
    implements _$EmergencyWithContactUserInfoCWProxy {
  const _$EmergencyWithContactUserInfoCWProxyImpl(this._value);

  final EmergencyWithContactUserInfo _value;

  @override
  EmergencyWithContactUserInfo id(String id) => call(id: id);

  @override
  EmergencyWithContactUserInfo name(String name) => call(name: name);

  @override
  EmergencyWithContactUserInfo phone(String? phone) => call(phone: phone);

  @override
  EmergencyWithContactUserInfo gender(String? gender) => call(gender: gender);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyWithContactUserInfo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyWithContactUserInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyWithContactUserInfo call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
  }) {
    return EmergencyWithContactUserInfo(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      gender: gender == const $CopyWithPlaceholder()
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as String?,
    );
  }
}

extension $EmergencyWithContactUserInfoCopyWith
    on EmergencyWithContactUserInfo {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyWithContactUserInfo.copyWith(...)` or `instanceOfEmergencyWithContactUserInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyWithContactUserInfoCWProxy get copyWith =>
      _$EmergencyWithContactUserInfoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyWithContactUserInfo _$EmergencyWithContactUserInfoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmergencyWithContactUserInfo', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'name']);
  final val = EmergencyWithContactUserInfo(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    phone: $checkedConvert('phone', (v) => v as String?),
    gender: $checkedConvert('gender', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$EmergencyWithContactUserInfoToJson(
  EmergencyWithContactUserInfo instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone': ?instance.phone,
  'gender': ?instance.gender,
};
