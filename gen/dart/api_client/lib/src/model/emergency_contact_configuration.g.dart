// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_contact_configuration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyContactConfigurationCWProxy {
  EmergencyContactConfiguration name(String name);

  EmergencyContactConfiguration phone(String phone);

  EmergencyContactConfiguration type(
    EmergencyContactConfigurationTypeEnum type,
  );

  EmergencyContactConfiguration description(String? description);

  EmergencyContactConfiguration isActive(bool? isActive);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyContactConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyContactConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyContactConfiguration call({
    String name,
    String phone,
    EmergencyContactConfigurationTypeEnum type,
    String? description,
    bool? isActive,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyContactConfiguration.copyWith(...)` or call `instanceOfEmergencyContactConfiguration.copyWith.fieldName(value)` for a single field.
class _$EmergencyContactConfigurationCWProxyImpl
    implements _$EmergencyContactConfigurationCWProxy {
  const _$EmergencyContactConfigurationCWProxyImpl(this._value);

  final EmergencyContactConfiguration _value;

  @override
  EmergencyContactConfiguration name(String name) => call(name: name);

  @override
  EmergencyContactConfiguration phone(String phone) => call(phone: phone);

  @override
  EmergencyContactConfiguration type(
    EmergencyContactConfigurationTypeEnum type,
  ) => call(type: type);

  @override
  EmergencyContactConfiguration description(String? description) =>
      call(description: description);

  @override
  EmergencyContactConfiguration isActive(bool? isActive) =>
      call(isActive: isActive);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyContactConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyContactConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyContactConfiguration call({
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return EmergencyContactConfiguration(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      phone: phone == const $CopyWithPlaceholder() || phone == null
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as EmergencyContactConfigurationTypeEnum,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
    );
  }
}

extension $EmergencyContactConfigurationCopyWith
    on EmergencyContactConfiguration {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyContactConfiguration.copyWith(...)` or `instanceOfEmergencyContactConfiguration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyContactConfigurationCWProxy get copyWith =>
      _$EmergencyContactConfigurationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyContactConfiguration _$EmergencyContactConfigurationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmergencyContactConfiguration', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['name', 'phone', 'type']);
  final val = EmergencyContactConfiguration(
    name: $checkedConvert('name', (v) => v as String),
    phone: $checkedConvert('phone', (v) => v as String),
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$EmergencyContactConfigurationTypeEnumEnumMap, v),
    ),
    description: $checkedConvert('description', (v) => v as String?),
    isActive: $checkedConvert('isActive', (v) => v as bool? ?? true),
  );
  return val;
});

Map<String, dynamic> _$EmergencyContactConfigurationToJson(
  EmergencyContactConfiguration instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'type': _$EmergencyContactConfigurationTypeEnumEnumMap[instance.type]!,
  'description': ?instance.description,
  'isActive': ?instance.isActive,
};

const _$EmergencyContactConfigurationTypeEnumEnumMap = {
  EmergencyContactConfigurationTypeEnum.CAMPUS_SECURITY: 'CAMPUS_SECURITY',
  EmergencyContactConfigurationTypeEnum.POLICE: 'POLICE',
  EmergencyContactConfigurationTypeEnum.AMBULANCE: 'AMBULANCE',
  EmergencyContactConfigurationTypeEnum.FIRE_DEPT: 'FIRE_DEPT',
  EmergencyContactConfigurationTypeEnum.OTHER: 'OTHER',
};
