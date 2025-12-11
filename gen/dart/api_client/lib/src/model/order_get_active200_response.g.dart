// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_get_active200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderGetActive200ResponseCWProxy {
  OrderGetActive200Response message(String message);

  OrderGetActive200Response data(OrderGetActive200ResponseData? data);

  OrderGetActive200Response pagination(PaginationResult? pagination);

  OrderGetActive200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderGetActive200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderGetActive200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderGetActive200Response call({
    String message,
    OrderGetActive200ResponseData? data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderGetActive200Response.copyWith(...)` or call `instanceOfOrderGetActive200Response.copyWith.fieldName(value)` for a single field.
class _$OrderGetActive200ResponseCWProxyImpl
    implements _$OrderGetActive200ResponseCWProxy {
  const _$OrderGetActive200ResponseCWProxyImpl(this._value);

  final OrderGetActive200Response _value;

  @override
  OrderGetActive200Response message(String message) => call(message: message);

  @override
  OrderGetActive200Response data(OrderGetActive200ResponseData? data) =>
      call(data: data);

  @override
  OrderGetActive200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  OrderGetActive200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderGetActive200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderGetActive200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderGetActive200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderGetActive200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as OrderGetActive200ResponseData?,
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

extension $OrderGetActive200ResponseCopyWith on OrderGetActive200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderGetActive200Response.copyWith(...)` or `instanceOfOrderGetActive200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderGetActive200ResponseCWProxy get copyWith =>
      _$OrderGetActive200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderGetActive200Response _$OrderGetActive200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderGetActive200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message']);
  final val = OrderGetActive200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => v == null
          ? null
          : OrderGetActive200ResponseData.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$OrderGetActive200ResponseToJson(
  OrderGetActive200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': ?instance.data?.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
