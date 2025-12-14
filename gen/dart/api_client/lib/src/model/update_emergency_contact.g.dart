// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_emergency_contact.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateEmergencyContactCWProxy {
  UpdateEmergencyContact name(String? name);

  UpdateEmergencyContact phone(String? phone);

  UpdateEmergencyContact description(String? description);

  UpdateEmergencyContact isActive(bool? isActive);

  UpdateEmergencyContact priority(int? priority);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateEmergencyContact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateEmergencyContact(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateEmergencyContact call({
    String? name,
    String? phone,
    String? description,
    bool? isActive,
    int? priority,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateEmergencyContact.copyWith(...)` or call `instanceOfUpdateEmergencyContact.copyWith.fieldName(value)` for a single field.
class _$UpdateEmergencyContactCWProxyImpl
    implements _$UpdateEmergencyContactCWProxy {
  const _$UpdateEmergencyContactCWProxyImpl(this._value);

  final UpdateEmergencyContact _value;

  @override
  UpdateEmergencyContact name(String? name) => call(name: name);

  @override
  UpdateEmergencyContact phone(String? phone) => call(phone: phone);

  @override
  UpdateEmergencyContact description(String? description) =>
      call(description: description);

  @override
  UpdateEmergencyContact isActive(bool? isActive) => call(isActive: isActive);

  @override
  UpdateEmergencyContact priority(int? priority) => call(priority: priority);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateEmergencyContact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateEmergencyContact(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateEmergencyContact call({
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? priority = const $CopyWithPlaceholder(),
  }) {
    return UpdateEmergencyContact(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      priority: priority == const $CopyWithPlaceholder()
          ? _value.priority
          // ignore: cast_nullable_to_non_nullable
          : priority as int?,
    );
  }
}

extension $UpdateEmergencyContactCopyWith on UpdateEmergencyContact {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateEmergencyContact.copyWith(...)` or `instanceOfUpdateEmergencyContact.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateEmergencyContactCWProxy get copyWith =>
      _$UpdateEmergencyContactCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateEmergencyContact _$UpdateEmergencyContactFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateEmergencyContact', json, ($checkedConvert) {
  final val = UpdateEmergencyContact(
    name: $checkedConvert('name', (v) => v as String?),
    phone: $checkedConvert('phone', (v) => v as String?),
    description: $checkedConvert('description', (v) => v as String?),
    isActive: $checkedConvert('isActive', (v) => v as bool?),
    priority: $checkedConvert('priority', (v) => (v as num?)?.toInt() ?? 0),
  );
  return val;
});

Map<String, dynamic> _$UpdateEmergencyContactToJson(
  UpdateEmergencyContact instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'phone': ?instance.phone,
  'description': ?instance.description,
  'isActive': ?instance.isActive,
  'priority': ?instance.priority,
};
