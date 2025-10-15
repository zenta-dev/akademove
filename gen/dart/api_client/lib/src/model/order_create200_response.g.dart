// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCreate200ResponseCWProxy {
  OrderCreate200Response message(String message);

  OrderCreate200Response data(Order data);

  OrderCreate200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreate200Response call({String message, Order data, num? totalPages});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderCreate200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderCreate200Response.copyWith.fieldName(...)`
class _$OrderCreate200ResponseCWProxyImpl
    implements _$OrderCreate200ResponseCWProxy {
  const _$OrderCreate200ResponseCWProxyImpl(this._value);

  final OrderCreate200Response _value;

  @override
  OrderCreate200Response message(String message) => this(message: message);

  @override
  OrderCreate200Response data(Order data) => this(data: data);

  @override
  OrderCreate200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderCreate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Order,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $OrderCreate200ResponseCopyWith on OrderCreate200Response {
  /// Returns a callable class that can be used as follows: `instanceOfOrderCreate200Response.copyWith(...)` or like so:`instanceOfOrderCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCreate200ResponseCWProxy get copyWith =>
      _$OrderCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreate200Response _$OrderCreate200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderCreate200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = OrderCreate200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Order.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$OrderCreate200ResponseToJson(
  OrderCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
