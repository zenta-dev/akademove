// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_place_order200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderPlaceOrder200ResponseCWProxy {
  OrderPlaceOrder200Response message(String message);

  OrderPlaceOrder200Response data(PlaceOrderResponse data);

  OrderPlaceOrder200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderPlaceOrder200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderPlaceOrder200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderPlaceOrder200Response call({
    String message,
    PlaceOrderResponse data,
    num? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderPlaceOrder200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderPlaceOrder200Response.copyWith.fieldName(...)`
class _$OrderPlaceOrder200ResponseCWProxyImpl
    implements _$OrderPlaceOrder200ResponseCWProxy {
  const _$OrderPlaceOrder200ResponseCWProxyImpl(this._value);

  final OrderPlaceOrder200Response _value;

  @override
  OrderPlaceOrder200Response message(String message) => this(message: message);

  @override
  OrderPlaceOrder200Response data(PlaceOrderResponse data) => this(data: data);

  @override
  OrderPlaceOrder200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderPlaceOrder200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderPlaceOrder200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderPlaceOrder200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderPlaceOrder200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as PlaceOrderResponse,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $OrderPlaceOrder200ResponseCopyWith on OrderPlaceOrder200Response {
  /// Returns a callable class that can be used as follows: `instanceOfOrderPlaceOrder200Response.copyWith(...)` or like so:`instanceOfOrderPlaceOrder200Response.copyWith.fieldName(...)`.
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
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => PlaceOrderResponse.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$OrderPlaceOrder200ResponseToJson(
  OrderPlaceOrder200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
