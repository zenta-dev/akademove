// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_with_contact_driver_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyWithContactDriverInfoCWProxy {
  EmergencyWithContactDriverInfo id(String id);

  EmergencyWithContactDriverInfo userId(String userId);

  EmergencyWithContactDriverInfo name(String name);

  EmergencyWithContactDriverInfo phone(String? phone);

  EmergencyWithContactDriverInfo gender(String? gender);

  EmergencyWithContactDriverInfo vehiclePlate(String? vehiclePlate);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyWithContactDriverInfo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyWithContactDriverInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyWithContactDriverInfo call({
    String id,
    String userId,
    String name,
    String? phone,
    String? gender,
    String? vehiclePlate,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyWithContactDriverInfo.copyWith(...)` or call `instanceOfEmergencyWithContactDriverInfo.copyWith.fieldName(value)` for a single field.
class _$EmergencyWithContactDriverInfoCWProxyImpl
    implements _$EmergencyWithContactDriverInfoCWProxy {
  const _$EmergencyWithContactDriverInfoCWProxyImpl(this._value);

  final EmergencyWithContactDriverInfo _value;

  @override
  EmergencyWithContactDriverInfo id(String id) => call(id: id);

  @override
  EmergencyWithContactDriverInfo userId(String userId) => call(userId: userId);

  @override
  EmergencyWithContactDriverInfo name(String name) => call(name: name);

  @override
  EmergencyWithContactDriverInfo phone(String? phone) => call(phone: phone);

  @override
  EmergencyWithContactDriverInfo gender(String? gender) => call(gender: gender);

  @override
  EmergencyWithContactDriverInfo vehiclePlate(String? vehiclePlate) =>
      call(vehiclePlate: vehiclePlate);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyWithContactDriverInfo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyWithContactDriverInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyWithContactDriverInfo call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? vehiclePlate = const $CopyWithPlaceholder(),
  }) {
    return EmergencyWithContactDriverInfo(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
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
      vehiclePlate: vehiclePlate == const $CopyWithPlaceholder()
          ? _value.vehiclePlate
          // ignore: cast_nullable_to_non_nullable
          : vehiclePlate as String?,
    );
  }
}

extension $EmergencyWithContactDriverInfoCopyWith
    on EmergencyWithContactDriverInfo {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyWithContactDriverInfo.copyWith(...)` or `instanceOfEmergencyWithContactDriverInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyWithContactDriverInfoCWProxy get copyWith =>
      _$EmergencyWithContactDriverInfoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyWithContactDriverInfo _$EmergencyWithContactDriverInfoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmergencyWithContactDriverInfo', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'userId', 'name']);
  final val = EmergencyWithContactDriverInfo(
    id: $checkedConvert('id', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    phone: $checkedConvert('phone', (v) => v as String?),
    gender: $checkedConvert('gender', (v) => v as String?),
    vehiclePlate: $checkedConvert('vehiclePlate', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$EmergencyWithContactDriverInfoToJson(
  EmergencyWithContactDriverInfo instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'name': instance.name,
  'phone': ?instance.phone,
  'gender': ?instance.gender,
  'vehiclePlate': ?instance.vehiclePlate,
};
