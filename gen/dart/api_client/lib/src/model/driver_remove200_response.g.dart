// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_remove200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverRemove200ResponseCWProxy {
  DriverRemove200Response message(String message);

  DriverRemove200Response data(Object? data);

  DriverRemove200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverRemove200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverRemove200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverRemove200Response call({String message, Object? data, int? totalPages});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDriverRemove200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDriverRemove200Response.copyWith.fieldName(...)`
class _$DriverRemove200ResponseCWProxyImpl
    implements _$DriverRemove200ResponseCWProxy {
  const _$DriverRemove200ResponseCWProxyImpl(this._value);

  final DriverRemove200Response _value;

  @override
  DriverRemove200Response message(String message) => this(message: message);

  @override
  DriverRemove200Response data(Object? data) => this(data: data);

  @override
  DriverRemove200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverRemove200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverRemove200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverRemove200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverRemove200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Object?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $DriverRemove200ResponseCopyWith on DriverRemove200Response {
  /// Returns a callable class that can be used as follows: `instanceOfDriverRemove200Response.copyWith(...)` or like so:`instanceOfDriverRemove200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverRemove200ResponseCWProxy get copyWith =>
      _$DriverRemove200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverRemove200Response _$DriverRemove200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverRemove200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverRemove200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert('data', (v) => v),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$DriverRemove200ResponseToJson(
  DriverRemove200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data,
  'totalPages': ?instance.totalPages,
};
