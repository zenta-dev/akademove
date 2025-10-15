// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfigurationCWProxy {
  Configuration key(String key);

  Configuration name(String name);

  Configuration value(Object? value);

  Configuration description(String? description);

  Configuration updatedById(String updatedById);

  Configuration updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Configuration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Configuration(...).copyWith(id: 12, name: "My name")
  /// ````
  Configuration call({
    String key,
    String name,
    Object? value,
    String? description,
    String updatedById,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConfiguration.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConfiguration.copyWith.fieldName(...)`
class _$ConfigurationCWProxyImpl implements _$ConfigurationCWProxy {
  const _$ConfigurationCWProxyImpl(this._value);

  final Configuration _value;

  @override
  Configuration key(String key) => this(key: key);

  @override
  Configuration name(String name) => this(name: name);

  @override
  Configuration value(Object? value) => this(value: value);

  @override
  Configuration description(String? description) =>
      this(description: description);

  @override
  Configuration updatedById(String updatedById) =>
      this(updatedById: updatedById);

  @override
  Configuration updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Configuration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Configuration(...).copyWith(id: 12, name: "My name")
  /// ````
  Configuration call({
    Object? key = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? updatedById = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Configuration(
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

extension $ConfigurationCopyWith on Configuration {
  /// Returns a callable class that can be used as follows: `instanceOfConfiguration.copyWith(...)` or like so:`instanceOfConfiguration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfigurationCWProxy get copyWith => _$ConfigurationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Configuration', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['key', 'name', 'updatedById', 'updatedAt'],
      );
      final val = Configuration(
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

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'value': ?instance.value,
      'description': ?instance.description,
      'updatedById': instance.updatedById,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
