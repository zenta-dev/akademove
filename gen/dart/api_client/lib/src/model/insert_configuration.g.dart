// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_configuration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertConfigurationCWProxy {
  InsertConfiguration name(String name);

  InsertConfiguration value(Object? value);

  InsertConfiguration description(String? description);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertConfiguration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertConfiguration(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertConfiguration call({String name, Object? value, String? description});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertConfiguration.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertConfiguration.copyWith.fieldName(...)`
class _$InsertConfigurationCWProxyImpl implements _$InsertConfigurationCWProxy {
  const _$InsertConfigurationCWProxyImpl(this._value);

  final InsertConfiguration _value;

  @override
  InsertConfiguration name(String name) => this(name: name);

  @override
  InsertConfiguration value(Object? value) => this(value: value);

  @override
  InsertConfiguration description(String? description) =>
      this(description: description);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertConfiguration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertConfiguration(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertConfiguration call({
    Object? name = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
  }) {
    return InsertConfiguration(
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
    );
  }
}

extension $InsertConfigurationCopyWith on InsertConfiguration {
  /// Returns a callable class that can be used as follows: `instanceOfInsertConfiguration.copyWith(...)` or like so:`instanceOfInsertConfiguration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertConfigurationCWProxy get copyWith =>
      _$InsertConfigurationCWProxyImpl(this);
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

Map<String, dynamic> _$InsertConfigurationToJson(
  InsertConfiguration instance,
) => <String, dynamic>{
  'name': instance.name,
  'value': ?instance.value,
  'description': ?instance.description,
};
