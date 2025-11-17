// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_list200_response_data_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfigurationList200ResponseDataInnerCWProxy {
  ConfigurationList200ResponseDataInner key(String key);

  ConfigurationList200ResponseDataInner name(String name);

  ConfigurationList200ResponseDataInner value(Object? value);

  ConfigurationList200ResponseDataInner description(String? description);

  ConfigurationList200ResponseDataInner updatedById(String updatedById);

  ConfigurationList200ResponseDataInner updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfigurationList200ResponseDataInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfigurationList200ResponseDataInner(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfigurationList200ResponseDataInner call({
    String key,
    String name,
    Object? value,
    String? description,
    String updatedById,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConfigurationList200ResponseDataInner.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConfigurationList200ResponseDataInner.copyWith.fieldName(...)`
class _$ConfigurationList200ResponseDataInnerCWProxyImpl
    implements _$ConfigurationList200ResponseDataInnerCWProxy {
  const _$ConfigurationList200ResponseDataInnerCWProxyImpl(this._value);

  final ConfigurationList200ResponseDataInner _value;

  @override
  ConfigurationList200ResponseDataInner key(String key) => this(key: key);

  @override
  ConfigurationList200ResponseDataInner name(String name) => this(name: name);

  @override
  ConfigurationList200ResponseDataInner value(Object? value) =>
      this(value: value);

  @override
  ConfigurationList200ResponseDataInner description(String? description) =>
      this(description: description);

  @override
  ConfigurationList200ResponseDataInner updatedById(String updatedById) =>
      this(updatedById: updatedById);

  @override
  ConfigurationList200ResponseDataInner updatedAt(DateTime updatedAt) =>
      this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfigurationList200ResponseDataInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfigurationList200ResponseDataInner(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfigurationList200ResponseDataInner call({
    Object? key = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? updatedById = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return ConfigurationList200ResponseDataInner(
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as Object?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      updatedById: updatedById == const $CopyWithPlaceholder()
          ? _value.updatedById
          // ignore: cast_nullable_to_non_nullable
          : updatedById as String,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $ConfigurationList200ResponseDataInnerCopyWith
    on ConfigurationList200ResponseDataInner {
  /// Returns a callable class that can be used as follows: `instanceOfConfigurationList200ResponseDataInner.copyWith(...)` or like so:`instanceOfConfigurationList200ResponseDataInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfigurationList200ResponseDataInnerCWProxy get copyWith =>
      _$ConfigurationList200ResponseDataInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationList200ResponseDataInner
_$ConfigurationList200ResponseDataInnerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ConfigurationList200ResponseDataInner', json, (
      $checkedConvert,
    ) {
      $checkKeys(
        json,
        requiredKeys: const ['key', 'name', 'updatedById', 'updatedAt'],
      );
      final val = ConfigurationList200ResponseDataInner(
        key: $checkedConvert('key', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        value: $checkedConvert('value', (v) => v),
        description: $checkedConvert('description', (v) => v as String?),
        updatedById: $checkedConvert('updatedById', (v) => v as String),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ConfigurationList200ResponseDataInnerToJson(
  ConfigurationList200ResponseDataInner instance,
) => <String, dynamic>{
  'key': instance.key,
  'name': instance.name,
  'value': ?instance.value,
  'description': ?instance.description,
  'updatedById': instance.updatedById,
  'updatedAt': instance.updatedAt.toIso8601String(),
};
