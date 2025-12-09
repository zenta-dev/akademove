// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_place_scheduled_order200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderPlaceScheduledOrder200ResponseCWProxy {
  OrderPlaceScheduledOrder200Response message(String message);

  OrderPlaceScheduledOrder200Response data(PlaceScheduledOrderResponse data);

  OrderPlaceScheduledOrder200Response pagination(PaginationResult? pagination);

  OrderPlaceScheduledOrder200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderPlaceScheduledOrder200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderPlaceScheduledOrder200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderPlaceScheduledOrder200Response call({
    String message,
    PlaceScheduledOrderResponse data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderPlaceScheduledOrder200Response.copyWith(...)` or call `instanceOfOrderPlaceScheduledOrder200Response.copyWith.fieldName(value)` for a single field.
class _$OrderPlaceScheduledOrder200ResponseCWProxyImpl
    implements _$OrderPlaceScheduledOrder200ResponseCWProxy {
  const _$OrderPlaceScheduledOrder200ResponseCWProxyImpl(this._value);

  final OrderPlaceScheduledOrder200Response _value;

  @override
  OrderPlaceScheduledOrder200Response message(String message) =>
      call(message: message);

  @override
  OrderPlaceScheduledOrder200Response data(PlaceScheduledOrderResponse data) =>
      call(data: data);

  @override
  OrderPlaceScheduledOrder200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  OrderPlaceScheduledOrder200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderPlaceScheduledOrder200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderPlaceScheduledOrder200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderPlaceScheduledOrder200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderPlaceScheduledOrder200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as PlaceScheduledOrderResponse,
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

extension $OrderPlaceScheduledOrder200ResponseCopyWith
    on OrderPlaceScheduledOrder200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderPlaceScheduledOrder200Response.copyWith(...)` or `instanceOfOrderPlaceScheduledOrder200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderPlaceScheduledOrder200ResponseCWProxy get copyWith =>
      _$OrderPlaceScheduledOrder200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPlaceScheduledOrder200Response
_$OrderPlaceScheduledOrder200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderPlaceScheduledOrder200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = OrderPlaceScheduledOrder200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) =>
              PlaceScheduledOrderResponse.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$OrderPlaceScheduledOrder200ResponseToJson(
  OrderPlaceScheduledOrder200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
