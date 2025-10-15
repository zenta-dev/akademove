// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderList200ResponseCWProxy {
  OrderList200Response message(String message);

  OrderList200Response data(List<Order> data);

  OrderList200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderList200Response call({
    String message,
    List<Order> data,
    num? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderList200Response.copyWith.fieldName(...)`
class _$OrderList200ResponseCWProxyImpl
    implements _$OrderList200ResponseCWProxy {
  const _$OrderList200ResponseCWProxyImpl(this._value);

  final OrderList200Response _value;

  @override
  OrderList200Response message(String message) => this(message: message);

  @override
  OrderList200Response data(List<Order> data) => this(data: data);

  @override
  OrderList200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Order>,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $OrderList200ResponseCopyWith on OrderList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfOrderList200Response.copyWith(...)` or like so:`instanceOfOrderList200Response.copyWith.fieldName(...)`.
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
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$OrderList200ResponseToJson(
  OrderList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalPages': ?instance.totalPages,
};
