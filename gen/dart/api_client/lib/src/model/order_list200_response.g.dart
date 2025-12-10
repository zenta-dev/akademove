// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderList200ResponseCWProxy {
  OrderList200Response message(String? message);

  OrderList200Response data(List<Order> data);

  OrderList200Response pagination(PaginationResult? pagination);

  OrderList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderList200Response call({
    String? message,
    List<Order> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderList200Response.copyWith(...)` or call `instanceOfOrderList200Response.copyWith.fieldName(value)` for a single field.
class _$OrderList200ResponseCWProxyImpl
    implements _$OrderList200ResponseCWProxy {
  const _$OrderList200ResponseCWProxyImpl(this._value);

  final OrderList200Response _value;

  @override
  OrderList200Response message(String? message) => call(message: message);

  @override
  OrderList200Response data(List<Order> data) => call(data: data);

  @override
  OrderList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  OrderList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Order>,
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

extension $OrderList200ResponseCopyWith on OrderList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderList200Response.copyWith(...)` or `instanceOfOrderList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderList200ResponseCWProxy get copyWith =>
      _$OrderList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderList200Response _$OrderList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = OrderList200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$OrderList200ResponseToJson(
  OrderList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
