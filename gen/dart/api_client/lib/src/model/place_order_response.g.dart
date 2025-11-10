// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlaceOrderResponseCWProxy {
  PlaceOrderResponse order(Order order);

  PlaceOrderResponse payment(Payment payment);

  PlaceOrderResponse transaction(Transaction transaction);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PlaceOrderResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PlaceOrderResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  PlaceOrderResponse call({
    Order order,
    Payment payment,
    Transaction transaction,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPlaceOrderResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPlaceOrderResponse.copyWith.fieldName(...)`
class _$PlaceOrderResponseCWProxyImpl implements _$PlaceOrderResponseCWProxy {
  const _$PlaceOrderResponseCWProxyImpl(this._value);

  final PlaceOrderResponse _value;

  @override
  PlaceOrderResponse order(Order order) => this(order: order);

  @override
  PlaceOrderResponse payment(Payment payment) => this(payment: payment);

  @override
  PlaceOrderResponse transaction(Transaction transaction) =>
      this(transaction: transaction);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PlaceOrderResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PlaceOrderResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  PlaceOrderResponse call({
    Object? order = const $CopyWithPlaceholder(),
    Object? payment = const $CopyWithPlaceholder(),
    Object? transaction = const $CopyWithPlaceholder(),
  }) {
    return PlaceOrderResponse(
      order: order == const $CopyWithPlaceholder()
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as Order,
      payment: payment == const $CopyWithPlaceholder()
          ? _value.payment
          // ignore: cast_nullable_to_non_nullable
          : payment as Payment,
      transaction: transaction == const $CopyWithPlaceholder()
          ? _value.transaction
          // ignore: cast_nullable_to_non_nullable
          : transaction as Transaction,
    );
  }
}

extension $PlaceOrderResponseCopyWith on PlaceOrderResponse {
  /// Returns a callable class that can be used as follows: `instanceOfPlaceOrderResponse.copyWith(...)` or like so:`instanceOfPlaceOrderResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PlaceOrderResponseCWProxy get copyWith =>
      _$PlaceOrderResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderResponse _$PlaceOrderResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PlaceOrderResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['order', 'payment', 'transaction']);
      final val = PlaceOrderResponse(
        order: $checkedConvert(
          'order',
          (v) => Order.fromJson(v as Map<String, dynamic>),
        ),
        payment: $checkedConvert(
          'payment',
          (v) => Payment.fromJson(v as Map<String, dynamic>),
        ),
        transaction: $checkedConvert(
          'transaction',
          (v) => Transaction.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PlaceOrderResponseToJson(PlaceOrderResponse instance) =>
    <String, dynamic>{
      'order': instance.order.toJson(),
      'payment': instance.payment.toJson(),
      'transaction': instance.transaction.toJson(),
    };
