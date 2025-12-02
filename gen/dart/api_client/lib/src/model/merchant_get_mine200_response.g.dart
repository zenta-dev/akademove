// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_get_mine200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantGetMine200ResponseCWProxy {
  MerchantGetMine200Response status(Object? status);

  MerchantGetMine200Response body(MerchantGetMine200ResponseBody body);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGetMine200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGetMine200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGetMine200Response call({Object? status, MerchantGetMine200ResponseBody body});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantGetMine200Response.copyWith(...)` or call `instanceOfMerchantGetMine200Response.copyWith.fieldName(value)` for a single field.
class _$MerchantGetMine200ResponseCWProxyImpl implements _$MerchantGetMine200ResponseCWProxy {
  const _$MerchantGetMine200ResponseCWProxyImpl(this._value);

  final MerchantGetMine200Response _value;

  @override
  MerchantGetMine200Response status(Object? status) => call(status: status);

  @override
  MerchantGetMine200Response body(MerchantGetMine200ResponseBody body) => call(body: body);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGetMine200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGetMine200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGetMine200Response call({
    Object? status = const $CopyWithPlaceholder(),
    Object? body = const $CopyWithPlaceholder(),
  }) {
    return MerchantGetMine200Response(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as Object?,
      body: body == const $CopyWithPlaceholder() || body == null
          ? _value.body
          // ignore: cast_nullable_to_non_nullable
          : body as MerchantGetMine200ResponseBody,
    );
  }
}

extension $MerchantGetMine200ResponseCopyWith on MerchantGetMine200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantGetMine200Response.copyWith(...)` or `instanceOfMerchantGetMine200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantGetMine200ResponseCWProxy get copyWith => _$MerchantGetMine200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantGetMine200Response _$MerchantGetMine200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantGetMine200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['status', 'body']);
      final val = MerchantGetMine200Response(
        status: $checkedConvert('status', (v) => v),
        body: $checkedConvert('body', (v) => MerchantGetMine200ResponseBody.fromJson(v as Map<String, dynamic>)),
      );
      return val;
    });

Map<String, dynamic> _$MerchantGetMine200ResponseToJson(MerchantGetMine200Response instance) => <String, dynamic>{
  'status': instance.status,
  'body': instance.body.toJson(),
};
