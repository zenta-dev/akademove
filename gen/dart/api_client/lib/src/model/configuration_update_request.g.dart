// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfigurationUpdateRequestCWProxy {
  ConfigurationUpdateRequest name(String? name);

  ConfigurationUpdateRequest value(Object? value);

  ConfigurationUpdateRequest description(String? description);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfigurationUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfigurationUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfigurationUpdateRequest call({
    String? name,
    Object? value,
    String? description,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConfigurationUpdateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConfigurationUpdateRequest.copyWith.fieldName(...)`
class _$ConfigurationUpdateRequestCWProxyImpl
    implements _$ConfigurationUpdateRequestCWProxy {
  const _$ConfigurationUpdateRequestCWProxyImpl(this._value);

  final ConfigurationUpdateRequest _value;

  @override
  ConfigurationUpdateRequest name(String? name) => this(name: name);

  @override
  ConfigurationUpdateRequest value(Object? value) => this(value: value);

  @override
  ConfigurationUpdateRequest description(String? description) =>
      this(description: description);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfigurationUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfigurationUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfigurationUpdateRequest call({
    Object? name = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
  }) {
    return ConfigurationUpdateRequest(
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

extension $ConfigurationUpdateRequestCopyWith on ConfigurationUpdateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfConfigurationUpdateRequest.copyWith(...)` or like so:`instanceOfConfigurationUpdateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfigurationUpdateRequestCWProxy get copyWith =>
      _$ConfigurationUpdateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationUpdateRequest _$ConfigurationUpdateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ConfigurationUpdateRequest', json, ($checkedConvert) {
  final val = ConfigurationUpdateRequest(
    name: $checkedConvert('name', (v) => v as String?),
    value: $checkedConvert('value', (v) => v),
    description: $checkedConvert('description', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$ConfigurationUpdateRequestToJson(
  ConfigurationUpdateRequest instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'value': ?instance.value,
  'description': ?instance.description,
};
