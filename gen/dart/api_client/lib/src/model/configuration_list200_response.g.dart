// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfigurationList200ResponseCWProxy {
  ConfigurationList200Response message(String message);

  ConfigurationList200Response data(List<Configuration> data);

  ConfigurationList200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfigurationList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfigurationList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfigurationList200Response call({
    String message,
    List<Configuration> data,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConfigurationList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConfigurationList200Response.copyWith.fieldName(...)`
class _$ConfigurationList200ResponseCWProxyImpl
    implements _$ConfigurationList200ResponseCWProxy {
  const _$ConfigurationList200ResponseCWProxyImpl(this._value);

  final ConfigurationList200Response _value;

  @override
  ConfigurationList200Response message(String message) =>
      this(message: message);

  @override
  ConfigurationList200Response data(List<Configuration> data) =>
      this(data: data);

  @override
  ConfigurationList200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfigurationList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfigurationList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfigurationList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ConfigurationList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Configuration>,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $ConfigurationList200ResponseCopyWith
    on ConfigurationList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfConfigurationList200Response.copyWith(...)` or like so:`instanceOfConfigurationList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfigurationList200ResponseCWProxy get copyWith =>
      _$ConfigurationList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationList200Response _$ConfigurationList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ConfigurationList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ConfigurationList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Configuration.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$ConfigurationList200ResponseToJson(
  ConfigurationList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalPages': ?instance.totalPages,
};
