// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_configuration_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateConfigurationRequestCWProxy {
  UpdateConfigurationRequest name(String name);

  UpdateConfigurationRequest value(Object? value);

  UpdateConfigurationRequest description(String? description);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateConfigurationRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateConfigurationRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateConfigurationRequest call({
    String name,
    Object? value,
    String? description,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateConfigurationRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateConfigurationRequest.copyWith.fieldName(...)`
class _$UpdateConfigurationRequestCWProxyImpl
    implements _$UpdateConfigurationRequestCWProxy {
  const _$UpdateConfigurationRequestCWProxyImpl(this._value);

  final UpdateConfigurationRequest _value;

  @override
  UpdateConfigurationRequest name(String name) => this(name: name);

  @override
  UpdateConfigurationRequest value(Object? value) => this(value: value);

  @override
  UpdateConfigurationRequest description(String? description) =>
      this(description: description);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateConfigurationRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateConfigurationRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateConfigurationRequest call({
    Object? name = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
  }) {
    return UpdateConfigurationRequest(
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

extension $UpdateConfigurationRequestCopyWith on UpdateConfigurationRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateConfigurationRequest.copyWith(...)` or like so:`instanceOfUpdateConfigurationRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateConfigurationRequestCWProxy get copyWith =>
      _$UpdateConfigurationRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateConfigurationRequest _$UpdateConfigurationRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateConfigurationRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['name']);
  final val = UpdateConfigurationRequest(
    name: $checkedConvert('name', (v) => v as String),
    value: $checkedConvert('value', (v) => v),
    description: $checkedConvert('description', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$UpdateConfigurationRequestToJson(
  UpdateConfigurationRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'value': ?instance.value,
  'description': ?instance.description,
};
