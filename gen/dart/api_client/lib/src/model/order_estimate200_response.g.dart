// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_estimate200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEstimate200ResponseCWProxy {
  OrderEstimate200Response message(String message);

  OrderEstimate200Response data(OrderSummary data);

  OrderEstimate200Response pagination(PaginationResult? pagination);

  OrderEstimate200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEstimate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEstimate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEstimate200Response call({String message, OrderSummary data, PaginationResult? pagination, int? totalPages});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEstimate200Response.copyWith(...)` or call `instanceOfOrderEstimate200Response.copyWith.fieldName(value)` for a single field.
class _$OrderEstimate200ResponseCWProxyImpl implements _$OrderEstimate200ResponseCWProxy {
  const _$OrderEstimate200ResponseCWProxyImpl(this._value);

  final OrderEstimate200Response _value;

  @override
  OrderEstimate200Response message(String message) => call(message: message);

  @override
  OrderEstimate200Response data(OrderSummary data) => call(data: data);

  @override
  OrderEstimate200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  OrderEstimate200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEstimate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEstimate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEstimate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderEstimate200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as OrderSummary,
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

extension $OrderEstimate200ResponseCopyWith on OrderEstimate200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEstimate200Response.copyWith(...)` or `instanceOfOrderEstimate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEstimate200ResponseCWProxy get copyWith => _$OrderEstimate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEstimate200Response _$OrderEstimate200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderEstimate200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = OrderEstimate200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert('data', (v) => OrderSummary.fromJson(v as Map<String, dynamic>)),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$OrderEstimate200ResponseToJson(OrderEstimate200Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
