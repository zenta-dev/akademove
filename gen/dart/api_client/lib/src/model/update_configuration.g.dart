// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_configuration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateConfigurationCWProxy {
  UpdateConfiguration name(String? name);

  UpdateConfiguration value(Object? value);

  UpdateConfiguration description(String? description);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateConfiguration call({String? name, Object? value, String? description});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateConfiguration.copyWith(...)` or call `instanceOfUpdateConfiguration.copyWith.fieldName(value)` for a single field.
class _$UpdateConfigurationCWProxyImpl implements _$UpdateConfigurationCWProxy {
  const _$UpdateConfigurationCWProxyImpl(this._value);

  final UpdateConfiguration _value;

  @override
  UpdateConfiguration name(String? name) => call(name: name);

  @override
  UpdateConfiguration value(Object? value) => call(value: value);

  @override
  UpdateConfiguration description(String? description) => call(description: description);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateConfiguration call({
    Object? name = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
  }) {
    return UpdateConfiguration(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
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

extension $UpdateConfigurationCopyWith on UpdateConfiguration {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateConfiguration.copyWith(...)` or `instanceOfUpdateConfiguration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateConfigurationCWProxy get copyWith => _$UpdateConfigurationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateConfiguration _$UpdateConfigurationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateConfiguration', json, ($checkedConvert) {
      final val = UpdateConfiguration(
        name: $checkedConvert('name', (v) => v as String?),
        value: $checkedConvert('value', (v) => v),
        description: $checkedConvert('description', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$UpdateConfigurationToJson(UpdateConfiguration instance) => <String, dynamic>{
  'name': ?instance.name,
  'value': ?instance.value,
  'description': ?instance.description,
};
