// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_emergency_contact.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertEmergencyContactCWProxy {
  InsertEmergencyContact name(String name);

  InsertEmergencyContact phone(String phone);

  InsertEmergencyContact description(String? description);

  InsertEmergencyContact isActive(bool isActive);

  InsertEmergencyContact priority(int? priority);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertEmergencyContact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertEmergencyContact(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertEmergencyContact call({
    String name,
    String phone,
    String? description,
    bool isActive,
    int? priority,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertEmergencyContact.copyWith(...)` or call `instanceOfInsertEmergencyContact.copyWith.fieldName(value)` for a single field.
class _$InsertEmergencyContactCWProxyImpl
    implements _$InsertEmergencyContactCWProxy {
  const _$InsertEmergencyContactCWProxyImpl(this._value);

  final InsertEmergencyContact _value;

  @override
  InsertEmergencyContact name(String name) => call(name: name);

  @override
  InsertEmergencyContact phone(String phone) => call(phone: phone);

  @override
  InsertEmergencyContact description(String? description) =>
      call(description: description);

  @override
  InsertEmergencyContact isActive(bool isActive) => call(isActive: isActive);

  @override
  InsertEmergencyContact priority(int? priority) => call(priority: priority);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertEmergencyContact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertEmergencyContact(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertEmergencyContact call({
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? priority = const $CopyWithPlaceholder(),
  }) {
    return InsertEmergencyContact(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      phone: phone == const $CopyWithPlaceholder() || phone == null
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      isActive: isActive == const $CopyWithPlaceholder() || isActive == null
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      priority: priority == const $CopyWithPlaceholder()
          ? _value.priority
          // ignore: cast_nullable_to_non_nullable
          : priority as int?,
    );
  }
}

extension $InsertEmergencyContactCopyWith on InsertEmergencyContact {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertEmergencyContact.copyWith(...)` or `instanceOfInsertEmergencyContact.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertEmergencyContactCWProxy get copyWith =>
      _$InsertEmergencyContactCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertEmergencyContact _$InsertEmergencyContactFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('InsertEmergencyContact', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['name', 'phone', 'isActive']);
  final val = InsertEmergencyContact(
    name: $checkedConvert('name', (v) => v as String),
    phone: $checkedConvert('phone', (v) => v as String),
    description: $checkedConvert('description', (v) => v as String?),
    isActive: $checkedConvert('isActive', (v) => v as bool),
    priority: $checkedConvert('priority', (v) => (v as num?)?.toInt() ?? 0),
  );
  return val;
});

Map<String, dynamic> _$InsertEmergencyContactToJson(
  InsertEmergencyContact instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'description': ?instance.description,
  'isActive': instance.isActive,
  'priority': ?instance.priority,
};
