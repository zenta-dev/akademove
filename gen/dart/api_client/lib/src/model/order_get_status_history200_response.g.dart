// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_get_status_history200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderGetStatusHistory200ResponseCWProxy {
  OrderGetStatusHistory200Response message(String message);

  OrderGetStatusHistory200Response data(List<OrderStatusHistory> data);

  OrderGetStatusHistory200Response pagination(PaginationResult? pagination);

  OrderGetStatusHistory200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderGetStatusHistory200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderGetStatusHistory200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderGetStatusHistory200Response call({
    String message,
    List<OrderStatusHistory> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderGetStatusHistory200Response.copyWith(...)` or call `instanceOfOrderGetStatusHistory200Response.copyWith.fieldName(value)` for a single field.
class _$OrderGetStatusHistory200ResponseCWProxyImpl
    implements _$OrderGetStatusHistory200ResponseCWProxy {
  const _$OrderGetStatusHistory200ResponseCWProxyImpl(this._value);

  final OrderGetStatusHistory200Response _value;

  @override
  OrderGetStatusHistory200Response message(String message) =>
      call(message: message);

  @override
  OrderGetStatusHistory200Response data(List<OrderStatusHistory> data) =>
      call(data: data);

  @override
  OrderGetStatusHistory200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  OrderGetStatusHistory200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderGetStatusHistory200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderGetStatusHistory200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderGetStatusHistory200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderGetStatusHistory200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<OrderStatusHistory>,
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

extension $OrderGetStatusHistory200ResponseCopyWith
    on OrderGetStatusHistory200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderGetStatusHistory200Response.copyWith(...)` or `instanceOfOrderGetStatusHistory200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderGetStatusHistory200ResponseCWProxy get copyWith =>
      _$OrderGetStatusHistory200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderGetStatusHistory200Response _$OrderGetStatusHistory200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderGetStatusHistory200Response', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = OrderGetStatusHistory200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => OrderStatusHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
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

Map<String, dynamic> _$OrderGetStatusHistory200ResponseToJson(
  OrderGetStatusHistory200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
