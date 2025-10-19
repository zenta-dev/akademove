// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_get_mine200_response_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverGetMine200ResponseBodyCWProxy {
  DriverGetMine200ResponseBody message(String message);

  DriverGetMine200ResponseBody data(Driver data);

  DriverGetMine200ResponseBody totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverGetMine200ResponseBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverGetMine200ResponseBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverGetMine200ResponseBody call({
    String message,
    Driver data,
    num? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDriverGetMine200ResponseBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDriverGetMine200ResponseBody.copyWith.fieldName(...)`
class _$DriverGetMine200ResponseBodyCWProxyImpl
    implements _$DriverGetMine200ResponseBodyCWProxy {
  const _$DriverGetMine200ResponseBodyCWProxyImpl(this._value);

  final DriverGetMine200ResponseBody _value;

  @override
  DriverGetMine200ResponseBody message(String message) =>
      this(message: message);

  @override
  DriverGetMine200ResponseBody data(Driver data) => this(data: data);

  @override
  DriverGetMine200ResponseBody totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverGetMine200ResponseBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverGetMine200ResponseBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverGetMine200ResponseBody call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverGetMine200ResponseBody(
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

extension $DriverGetMine200ResponseBodyCopyWith
    on DriverGetMine200ResponseBody {
  /// Returns a callable class that can be used as follows: `instanceOfDriverGetMine200ResponseBody.copyWith(...)` or like so:`instanceOfDriverGetMine200ResponseBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverGetMine200ResponseBodyCWProxy get copyWith =>
      _$DriverGetMine200ResponseBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverGetMine200ResponseBody _$DriverGetMine200ResponseBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverGetMine200ResponseBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverGetMine200ResponseBody(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Driver.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$DriverGetMine200ResponseBodyToJson(
  DriverGetMine200ResponseBody instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
