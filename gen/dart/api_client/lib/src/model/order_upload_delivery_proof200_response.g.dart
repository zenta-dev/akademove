// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_upload_delivery_proof200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderUploadDeliveryProof200ResponseCWProxy {
  OrderUploadDeliveryProof200Response message(String? message);

  OrderUploadDeliveryProof200Response data(
    OrderUploadDeliveryProof200ResponseData data,
  );

  OrderUploadDeliveryProof200Response pagination(PaginationResult? pagination);

  OrderUploadDeliveryProof200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderUploadDeliveryProof200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderUploadDeliveryProof200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderUploadDeliveryProof200Response call({
    String? message,
    OrderUploadDeliveryProof200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderUploadDeliveryProof200Response.copyWith(...)` or call `instanceOfOrderUploadDeliveryProof200Response.copyWith.fieldName(value)` for a single field.
class _$OrderUploadDeliveryProof200ResponseCWProxyImpl
    implements _$OrderUploadDeliveryProof200ResponseCWProxy {
  const _$OrderUploadDeliveryProof200ResponseCWProxyImpl(this._value);

  final OrderUploadDeliveryProof200Response _value;

  @override
  OrderUploadDeliveryProof200Response message(String? message) =>
      call(message: message);

  @override
  OrderUploadDeliveryProof200Response data(
    OrderUploadDeliveryProof200ResponseData data,
  ) => call(data: data);

  @override
  OrderUploadDeliveryProof200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  OrderUploadDeliveryProof200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderUploadDeliveryProof200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderUploadDeliveryProof200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderUploadDeliveryProof200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderUploadDeliveryProof200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as OrderUploadDeliveryProof200ResponseData,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as PaginationResult?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $OrderUploadDeliveryProof200ResponseCopyWith
    on OrderUploadDeliveryProof200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderUploadDeliveryProof200Response.copyWith(...)` or `instanceOfOrderUploadDeliveryProof200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderUploadDeliveryProof200ResponseCWProxy get copyWith =>
      _$OrderUploadDeliveryProof200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderUploadDeliveryProof200Response
_$OrderUploadDeliveryProof200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderUploadDeliveryProof200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = OrderUploadDeliveryProof200Response(
        message: $checkedConvert('message', (v) => v as String?),
        data: $checkedConvert(
          'data',
          (v) => OrderUploadDeliveryProof200ResponseData.fromJson(
            v as Map<String, dynamic>,
          ),
        ),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null
              ? null
              : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$OrderUploadDeliveryProof200ResponseToJson(
  OrderUploadDeliveryProof200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
