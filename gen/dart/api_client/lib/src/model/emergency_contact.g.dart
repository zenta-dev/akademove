// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_contact.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyContactCWProxy {
  EmergencyContact id(String id);

  EmergencyContact name(String name);

  EmergencyContact phone(String phone);

  EmergencyContact description(String? description);

  EmergencyContact isActive(bool isActive);

  EmergencyContact priority(int? priority);

  EmergencyContact createdAt(DateTime createdAt);

  EmergencyContact updatedAt(DateTime updatedAt);

  EmergencyContact createdById(String? createdById);

  EmergencyContact updatedById(String? updatedById);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyContact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyContact(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyContact call({
    String id,
    String name,
    String phone,
    String? description,
    bool isActive,
    int? priority,
    DateTime createdAt,
    DateTime updatedAt,
    String? createdById,
    String? updatedById,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyContact.copyWith(...)` or call `instanceOfEmergencyContact.copyWith.fieldName(value)` for a single field.
class _$EmergencyContactCWProxyImpl implements _$EmergencyContactCWProxy {
  const _$EmergencyContactCWProxyImpl(this._value);

  final EmergencyContact _value;

  @override
  EmergencyContact id(String id) => call(id: id);

  @override
  EmergencyContact name(String name) => call(name: name);

  @override
  EmergencyContact phone(String phone) => call(phone: phone);

  @override
  EmergencyContact description(String? description) =>
      call(description: description);

  @override
  EmergencyContact isActive(bool isActive) => call(isActive: isActive);

  @override
  EmergencyContact priority(int? priority) => call(priority: priority);

  @override
  EmergencyContact createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  EmergencyContact updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  EmergencyContact createdById(String? createdById) =>
      call(createdById: createdById);

  @override
  EmergencyContact updatedById(String? updatedById) =>
      call(updatedById: updatedById);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyContact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyContact(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyContact call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? priority = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? createdById = const $CopyWithPlaceholder(),
    Object? updatedById = const $CopyWithPlaceholder(),
  }) {
    return EmergencyContact(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
      createdById: createdById == const $CopyWithPlaceholder()
          ? _value.createdById
          // ignore: cast_nullable_to_non_nullable
          : createdById as String?,
      updatedById: updatedById == const $CopyWithPlaceholder()
          ? _value.updatedById
          // ignore: cast_nullable_to_non_nullable
          : updatedById as String?,
    );
  }
}

extension $EmergencyContactCopyWith on EmergencyContact {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyContact.copyWith(...)` or `instanceOfEmergencyContact.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyContactCWProxy get copyWith => _$EmergencyContactCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyContact _$EmergencyContactFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmergencyContact', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'phone',
      'isActive',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = EmergencyContact(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    phone: $checkedConvert('phone', (v) => v as String),
    description: $checkedConvert('description', (v) => v as String?),
    isActive: $checkedConvert('isActive', (v) => v as bool),
    priority: $checkedConvert('priority', (v) => (v as num?)?.toInt() ?? 0),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
    createdById: $checkedConvert('createdById', (v) => v as String?),
    updatedById: $checkedConvert('updatedById', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$EmergencyContactToJson(EmergencyContact instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'description': ?instance.description,
      'isActive': instance.isActive,
      'priority': ?instance.priority,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'createdById': ?instance.createdById,
      'updatedById': ?instance.updatedById,
    };
