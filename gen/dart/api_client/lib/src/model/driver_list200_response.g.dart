// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverList200ResponseCWProxy {
  DriverList200Response message(String message);

  DriverList200Response data(List<Driver> data);

  DriverList200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverList200Response call({
    String message,
    List<Driver> data,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDriverList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDriverList200Response.copyWith.fieldName(...)`
class _$DriverList200ResponseCWProxyImpl
    implements _$DriverList200ResponseCWProxy {
  const _$DriverList200ResponseCWProxyImpl(this._value);

  final DriverList200Response _value;

  @override
  DriverList200Response message(String message) => this(message: message);

  @override
  DriverList200Response data(List<Driver> data) => this(data: data);

  @override
  DriverList200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Driver>,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $DriverList200ResponseCopyWith on DriverList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfDriverList200Response.copyWith(...)` or like so:`instanceOfDriverList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverList200ResponseCWProxy get copyWith =>
      _$DriverList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverList200Response _$DriverList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Driver.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$DriverList200ResponseToJson(
  DriverList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalPages': ?instance.totalPages,
};
