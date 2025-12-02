// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_configuration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertConfigurationCWProxy {
  InsertConfiguration name(String name);

  InsertConfiguration value(Object? value);

  InsertConfiguration description(String? description);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertConfiguration call({String name, Object? value, String? description});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertConfiguration.copyWith(...)` or call `instanceOfInsertConfiguration.copyWith.fieldName(value)` for a single field.
class _$InsertConfigurationCWProxyImpl implements _$InsertConfigurationCWProxy {
  const _$InsertConfigurationCWProxyImpl(this._value);

  final InsertConfiguration _value;

  @override
  InsertConfiguration name(String name) => call(name: name);

  @override
  InsertConfiguration value(Object? value) => call(value: value);

  @override
  InsertConfiguration description(String? description) => call(description: description);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertConfiguration call({
    Object? name = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
  }) {
    return InsertConfiguration(
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
    );
  }
}

extension $InsertConfigurationCopyWith on InsertConfiguration {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertConfiguration.copyWith(...)` or `instanceOfInsertConfiguration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertConfigurationCWProxy get copyWith => _$InsertConfigurationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertConfiguration _$InsertConfigurationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertConfiguration', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['name']);
      final val = InsertConfiguration(
        name: $checkedConvert('name', (v) => v as String),
        value: $checkedConvert('value', (v) => v),
        description: $checkedConvert('description', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$InsertConfigurationToJson(InsertConfiguration instance) => <String, dynamic>{
  'name': instance.name,
  'value': ?instance.value,
  'description': ?instance.description,
};
