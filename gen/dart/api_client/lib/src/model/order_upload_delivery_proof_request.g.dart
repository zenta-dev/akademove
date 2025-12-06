// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_upload_delivery_proof_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderUploadDeliveryProofRequestCWProxy {
  OrderUploadDeliveryProofRequest file(Object? file);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderUploadDeliveryProofRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderUploadDeliveryProofRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderUploadDeliveryProofRequest call({Object? file});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderUploadDeliveryProofRequest.copyWith(...)` or call `instanceOfOrderUploadDeliveryProofRequest.copyWith.fieldName(value)` for a single field.
class _$OrderUploadDeliveryProofRequestCWProxyImpl
    implements _$OrderUploadDeliveryProofRequestCWProxy {
  const _$OrderUploadDeliveryProofRequestCWProxyImpl(this._value);

  final OrderUploadDeliveryProofRequest _value;

  @override
  OrderUploadDeliveryProofRequest file(Object? file) => call(file: file);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderUploadDeliveryProofRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderUploadDeliveryProofRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderUploadDeliveryProofRequest call({
    Object? file = const $CopyWithPlaceholder(),
  }) {
    return OrderUploadDeliveryProofRequest(
      file: file == const $CopyWithPlaceholder()
          ? _value.file
          // ignore: cast_nullable_to_non_nullable
          : file as Object?,
    );
  }
}

extension $OrderUploadDeliveryProofRequestCopyWith
    on OrderUploadDeliveryProofRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderUploadDeliveryProofRequest.copyWith(...)` or `instanceOfOrderUploadDeliveryProofRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderUploadDeliveryProofRequestCWProxy get copyWith =>
      _$OrderUploadDeliveryProofRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderUploadDeliveryProofRequest _$OrderUploadDeliveryProofRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderUploadDeliveryProofRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['file']);
  final val = OrderUploadDeliveryProofRequest(
    file: $checkedConvert('file', (v) => v),
  );
  return val;
});

Map<String, dynamic> _$OrderUploadDeliveryProofRequestToJson(
  OrderUploadDeliveryProofRequest instance,
) => <String, dynamic>{'file': instance.file};
