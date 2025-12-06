// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_upload_delivery_proof200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderUploadDeliveryProof200ResponseDataCWProxy {
  OrderUploadDeliveryProof200ResponseData url(String url);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderUploadDeliveryProof200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderUploadDeliveryProof200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderUploadDeliveryProof200ResponseData call({String url});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderUploadDeliveryProof200ResponseData.copyWith(...)` or call `instanceOfOrderUploadDeliveryProof200ResponseData.copyWith.fieldName(value)` for a single field.
class _$OrderUploadDeliveryProof200ResponseDataCWProxyImpl
    implements _$OrderUploadDeliveryProof200ResponseDataCWProxy {
  const _$OrderUploadDeliveryProof200ResponseDataCWProxyImpl(this._value);

  final OrderUploadDeliveryProof200ResponseData _value;

  @override
  OrderUploadDeliveryProof200ResponseData url(String url) => call(url: url);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderUploadDeliveryProof200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderUploadDeliveryProof200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderUploadDeliveryProof200ResponseData call({
    Object? url = const $CopyWithPlaceholder(),
  }) {
    return OrderUploadDeliveryProof200ResponseData(
      url: url == const $CopyWithPlaceholder() || url == null
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
    );
  }
}

extension $OrderUploadDeliveryProof200ResponseDataCopyWith
    on OrderUploadDeliveryProof200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderUploadDeliveryProof200ResponseData.copyWith(...)` or `instanceOfOrderUploadDeliveryProof200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderUploadDeliveryProof200ResponseDataCWProxy get copyWith =>
      _$OrderUploadDeliveryProof200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderUploadDeliveryProof200ResponseData
_$OrderUploadDeliveryProof200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderUploadDeliveryProof200ResponseData', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['url']);
      final val = OrderUploadDeliveryProof200ResponseData(
        url: $checkedConvert('url', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$OrderUploadDeliveryProof200ResponseDataToJson(
  OrderUploadDeliveryProof200ResponseData instance,
) => <String, dynamic>{'url': instance.url};
