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

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderEstimate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderEstimate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderEstimate200Response call({
    String message,
    OrderSummary data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderEstimate200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderEstimate200Response.copyWith.fieldName(...)`
class _$OrderEstimate200ResponseCWProxyImpl
    implements _$OrderEstimate200ResponseCWProxy {
  const _$OrderEstimate200ResponseCWProxyImpl(this._value);

  final OrderEstimate200Response _value;

  @override
  OrderEstimate200Response message(String message) => this(message: message);

  @override
  OrderEstimate200Response data(OrderSummary data) => this(data: data);

  @override
  OrderEstimate200Response pagination(PaginationResult? pagination) =>
      this(pagination: pagination);

  @override
  OrderEstimate200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderEstimate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderEstimate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderEstimate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderEstimate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
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
  /// Returns a callable class that can be used as follows: `instanceOfOrderEstimate200Response.copyWith(...)` or like so:`instanceOfOrderEstimate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEstimate200ResponseCWProxy get copyWith =>
      _$OrderEstimate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEstimate200Response _$OrderEstimate200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderEstimate200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = OrderEstimate200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => OrderSummary.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$OrderEstimate200ResponseToJson(
  OrderEstimate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
