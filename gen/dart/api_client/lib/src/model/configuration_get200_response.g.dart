// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_get200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfigurationGet200ResponseCWProxy {
  ConfigurationGet200Response message(String message);

  ConfigurationGet200Response data(Configuration data);

  ConfigurationGet200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfigurationGet200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfigurationGet200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfigurationGet200Response call({
    String message,
    Configuration data,
    num? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConfigurationGet200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConfigurationGet200Response.copyWith.fieldName(...)`
class _$ConfigurationGet200ResponseCWProxyImpl
    implements _$ConfigurationGet200ResponseCWProxy {
  const _$ConfigurationGet200ResponseCWProxyImpl(this._value);

  final ConfigurationGet200Response _value;

  @override
  ConfigurationGet200Response message(String message) => this(message: message);

  @override
  ConfigurationGet200Response data(Configuration data) => this(data: data);

  @override
  ConfigurationGet200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfigurationGet200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfigurationGet200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfigurationGet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ConfigurationGet200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Configuration,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $ConfigurationGet200ResponseCopyWith on ConfigurationGet200Response {
  /// Returns a callable class that can be used as follows: `instanceOfConfigurationGet200Response.copyWith(...)` or like so:`instanceOfConfigurationGet200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfigurationGet200ResponseCWProxy get copyWith =>
      _$ConfigurationGet200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationGet200Response _$ConfigurationGet200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ConfigurationGet200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ConfigurationGet200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Configuration.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$ConfigurationGet200ResponseToJson(
  ConfigurationGet200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
