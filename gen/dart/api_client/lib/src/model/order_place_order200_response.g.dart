// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_place_order200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderPlaceOrder200ResponseCWProxy {
  OrderPlaceOrder200Response message(String? message);

  OrderPlaceOrder200Response data(PlaceOrderResponse data);

  OrderPlaceOrder200Response pagination(PaginationResult? pagination);

  OrderPlaceOrder200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderPlaceOrder200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderPlaceOrder200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderPlaceOrder200Response call({
    String? message,
    PlaceOrderResponse data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderPlaceOrder200Response.copyWith(...)` or call `instanceOfOrderPlaceOrder200Response.copyWith.fieldName(value)` for a single field.
class _$OrderPlaceOrder200ResponseCWProxyImpl
    implements _$OrderPlaceOrder200ResponseCWProxy {
  const _$OrderPlaceOrder200ResponseCWProxyImpl(this._value);

  final OrderPlaceOrder200Response _value;

  @override
  OrderPlaceOrder200Response message(String? message) => call(message: message);

  @override
  OrderPlaceOrder200Response data(PlaceOrderResponse data) => call(data: data);

  @override
  OrderPlaceOrder200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  OrderPlaceOrder200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderPlaceOrder200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderPlaceOrder200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderPlaceOrder200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderPlaceOrder200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as PlaceOrderResponse,
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

extension $OrderPlaceOrder200ResponseCopyWith on OrderPlaceOrder200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderPlaceOrder200Response.copyWith(...)` or `instanceOfOrderPlaceOrder200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderPlaceOrder200ResponseCWProxy get copyWith =>
      _$OrderPlaceOrder200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPlaceOrder200Response _$OrderPlaceOrder200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderPlaceOrder200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = OrderPlaceOrder200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => PlaceOrderResponse.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$OrderPlaceOrder200ResponseToJson(
  OrderPlaceOrder200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
