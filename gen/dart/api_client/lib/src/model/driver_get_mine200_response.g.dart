// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_get_mine200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverGetMine200ResponseCWProxy {
  DriverGetMine200Response status(Object? status);

  DriverGetMine200Response body(DriverGetMine200ResponseBody body);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetMine200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetMine200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetMine200Response call({
    Object? status,
    DriverGetMine200ResponseBody body,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverGetMine200Response.copyWith(...)` or call `instanceOfDriverGetMine200Response.copyWith.fieldName(value)` for a single field.
class _$DriverGetMine200ResponseCWProxyImpl
    implements _$DriverGetMine200ResponseCWProxy {
  const _$DriverGetMine200ResponseCWProxyImpl(this._value);

  final DriverGetMine200Response _value;

  @override
  DriverGetMine200Response status(Object? status) => call(status: status);

  @override
  DriverGetMine200Response body(DriverGetMine200ResponseBody body) =>
      call(body: body);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetMine200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetMine200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetMine200Response call({
    Object? status = const $CopyWithPlaceholder(),
    Object? body = const $CopyWithPlaceholder(),
  }) {
    return DriverGetMine200Response(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as Object?,
      body: body == const $CopyWithPlaceholder() || body == null
          ? _value.body
          // ignore: cast_nullable_to_non_nullable
          : body as DriverGetMine200ResponseBody,
    );
  }
}

extension $DriverGetMine200ResponseCopyWith on DriverGetMine200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverGetMine200Response.copyWith(...)` or `instanceOfDriverGetMine200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverGetMine200ResponseCWProxy get copyWith =>
      _$DriverGetMine200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverGetMine200Response _$DriverGetMine200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverGetMine200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['status', 'body']);
  final val = DriverGetMine200Response(
    status: $checkedConvert('status', (v) => v),
    body: $checkedConvert(
      'body',
      (v) => DriverGetMine200ResponseBody.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$DriverGetMine200ResponseToJson(
  DriverGetMine200Response instance,
) => <String, dynamic>{
  'status': instance.status,
  'body': instance.body.toJson(),
};
