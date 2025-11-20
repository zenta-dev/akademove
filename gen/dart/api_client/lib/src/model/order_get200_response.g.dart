// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_get200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderGet200ResponseCWProxy {
  OrderGet200Response message(String message);

  OrderGet200Response data(Order data);

  OrderGet200Response pagination(PaginationResult? pagination);

  OrderGet200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderGet200Response call({
    String message,
    Order data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderGet200Response.copyWith(...)` or call `instanceOfOrderGet200Response.copyWith.fieldName(value)` for a single field.
class _$OrderGet200ResponseCWProxyImpl implements _$OrderGet200ResponseCWProxy {
  const _$OrderGet200ResponseCWProxyImpl(this._value);

  final OrderGet200Response _value;

  @override
  OrderGet200Response message(String message) => call(message: message);

  @override
  OrderGet200Response data(Order data) => call(data: data);

  @override
  OrderGet200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  OrderGet200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderGet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderGet200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Order,
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

extension $OrderGet200ResponseCopyWith on OrderGet200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderGet200Response.copyWith(...)` or `instanceOfOrderGet200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderGet200ResponseCWProxy get copyWith =>
      _$OrderGet200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderGet200Response _$OrderGet200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderGet200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = OrderGet200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => Order.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$OrderGet200ResponseToJson(
  OrderGet200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
