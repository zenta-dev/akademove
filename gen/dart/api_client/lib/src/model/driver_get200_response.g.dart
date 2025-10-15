// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_get200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverGet200ResponseCWProxy {
  DriverGet200Response message(String message);

  DriverGet200Response data(Driver data);

  DriverGet200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverGet200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverGet200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverGet200Response call({String message, Driver data, num? totalPages});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDriverGet200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDriverGet200Response.copyWith.fieldName(...)`
class _$DriverGet200ResponseCWProxyImpl
    implements _$DriverGet200ResponseCWProxy {
  const _$DriverGet200ResponseCWProxyImpl(this._value);

  final DriverGet200Response _value;

  @override
  DriverGet200Response message(String message) => this(message: message);

  @override
  DriverGet200Response data(Driver data) => this(data: data);

  @override
  DriverGet200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverGet200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverGet200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverGet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverGet200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Driver,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $DriverGet200ResponseCopyWith on DriverGet200Response {
  /// Returns a callable class that can be used as follows: `instanceOfDriverGet200Response.copyWith(...)` or like so:`instanceOfDriverGet200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverGet200ResponseCWProxy get copyWith =>
      _$DriverGet200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverGet200Response _$DriverGet200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverGet200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverGet200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Driver.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$DriverGet200ResponseToJson(
  DriverGet200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
