// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlaceOrderResponseCWProxy {
  PlaceOrderResponse order(Order order);

  PlaceOrderResponse payment(Payment payment);

  PlaceOrderResponse transaction(Transaction transaction);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlaceOrderResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlaceOrderResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  PlaceOrderResponse call({Order order, Payment payment, Transaction transaction});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPlaceOrderResponse.copyWith(...)` or call `instanceOfPlaceOrderResponse.copyWith.fieldName(value)` for a single field.
class _$PlaceOrderResponseCWProxyImpl implements _$PlaceOrderResponseCWProxy {
  const _$PlaceOrderResponseCWProxyImpl(this._value);

  final PlaceOrderResponse _value;

  @override
  PlaceOrderResponse order(Order order) => call(order: order);

  @override
  PlaceOrderResponse payment(Payment payment) => call(payment: payment);

  @override
  PlaceOrderResponse transaction(Transaction transaction) => call(transaction: transaction);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlaceOrderResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlaceOrderResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  PlaceOrderResponse call({
    Object? order = const $CopyWithPlaceholder(),
    Object? payment = const $CopyWithPlaceholder(),
    Object? transaction = const $CopyWithPlaceholder(),
  }) {
    return PlaceOrderResponse(
      order: order == const $CopyWithPlaceholder() || order == null
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as Order,
      payment: payment == const $CopyWithPlaceholder() || payment == null
          ? _value.payment
          // ignore: cast_nullable_to_non_nullable
          : payment as Payment,
      transaction: transaction == const $CopyWithPlaceholder() || transaction == null
          ? _value.transaction
          // ignore: cast_nullable_to_non_nullable
          : transaction as Transaction,
    );
  }
}

extension $PlaceOrderResponseCopyWith on PlaceOrderResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPlaceOrderResponse.copyWith(...)` or `instanceOfPlaceOrderResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PlaceOrderResponseCWProxy get copyWith => _$PlaceOrderResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderResponse _$PlaceOrderResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PlaceOrderResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['order', 'payment', 'transaction']);
      final val = PlaceOrderResponse(
        order: $checkedConvert('order', (v) => Order.fromJson(v as Map<String, dynamic>)),
        payment: $checkedConvert('payment', (v) => Payment.fromJson(v as Map<String, dynamic>)),
        transaction: $checkedConvert('transaction', (v) => Transaction.fromJson(v as Map<String, dynamic>)),
      );
      return val;
    });

Map<String, dynamic> _$PlaceOrderResponseToJson(PlaceOrderResponse instance) => <String, dynamic>{
  'order': instance.order.toJson(),
  'payment': instance.payment.toJson(),
  'transaction': instance.transaction.toJson(),
};
