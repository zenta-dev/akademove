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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Configuration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Configuration(...).copyWith(id: 12, name: "My name")
  /// ```
  Configuration call({
    String key,
    String name,
    Object? value,
    String? description,
    String updatedById,
    DateTime updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfConfiguration.copyWith(...)` or call `instanceOfConfiguration.copyWith.fieldName(value)` for a single field.
class _$ConfigurationCWProxyImpl implements _$ConfigurationCWProxy {
  const _$ConfigurationCWProxyImpl(this._value);

  final Configuration _value;

  @override
  Configuration key(String key) => call(key: key);

  @override
  Configuration name(String name) => call(name: name);

  @override
  Configuration value(Object? value) => call(value: value);

  @override
  Configuration description(String? description) =>
      call(description: description);

  @override
  Configuration updatedById(String updatedById) =>
      call(updatedById: updatedById);

  @override
  Configuration updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Configuration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Configuration(...).copyWith(id: 12, name: "My name")
  /// ```
  Configuration call({
    Object? key = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? updatedById = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Configuration(
      key: key == const $CopyWithPlaceholder() || key == null
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String,
      name: name == const $CopyWithPlaceholder() || name == null
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
      updatedById:
          updatedById == const $CopyWithPlaceholder() || updatedById == null
          ? _value.updatedById
          // ignore: cast_nullable_to_non_nullable
          : updatedById as String,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $ConfigurationCopyWith on Configuration {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfConfiguration.copyWith(...)` or `instanceOfConfiguration.copyWith.fieldName(...)`.
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
