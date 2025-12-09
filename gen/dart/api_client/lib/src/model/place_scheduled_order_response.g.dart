// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_scheduled_order_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlaceScheduledOrderResponseCWProxy {
  PlaceScheduledOrderResponse order(Order order);

  PlaceScheduledOrderResponse payment(Payment payment);

  PlaceScheduledOrderResponse transaction(Transaction transaction);

  PlaceScheduledOrderResponse autoAppliedCoupon(
    PlaceOrderResponseAutoAppliedCoupon? autoAppliedCoupon,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlaceScheduledOrderResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlaceScheduledOrderResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  PlaceScheduledOrderResponse call({
    Order order,
    Payment payment,
    Transaction transaction,
    PlaceOrderResponseAutoAppliedCoupon? autoAppliedCoupon,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPlaceScheduledOrderResponse.copyWith(...)` or call `instanceOfPlaceScheduledOrderResponse.copyWith.fieldName(value)` for a single field.
class _$PlaceScheduledOrderResponseCWProxyImpl
    implements _$PlaceScheduledOrderResponseCWProxy {
  const _$PlaceScheduledOrderResponseCWProxyImpl(this._value);

  final PlaceScheduledOrderResponse _value;

  @override
  PlaceScheduledOrderResponse order(Order order) => call(order: order);

  @override
  PlaceScheduledOrderResponse payment(Payment payment) =>
      call(payment: payment);

  @override
  PlaceScheduledOrderResponse transaction(Transaction transaction) =>
      call(transaction: transaction);

  @override
  PlaceScheduledOrderResponse autoAppliedCoupon(
    PlaceOrderResponseAutoAppliedCoupon? autoAppliedCoupon,
  ) => call(autoAppliedCoupon: autoAppliedCoupon);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlaceScheduledOrderResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlaceScheduledOrderResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  PlaceScheduledOrderResponse call({
    Object? order = const $CopyWithPlaceholder(),
    Object? payment = const $CopyWithPlaceholder(),
    Object? transaction = const $CopyWithPlaceholder(),
    Object? autoAppliedCoupon = const $CopyWithPlaceholder(),
  }) {
    return PlaceScheduledOrderResponse(
      order: order == const $CopyWithPlaceholder() || order == null
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as Order,
      payment: payment == const $CopyWithPlaceholder() || payment == null
          ? _value.payment
          // ignore: cast_nullable_to_non_nullable
          : payment as Payment,
      transaction:
          transaction == const $CopyWithPlaceholder() || transaction == null
          ? _value.transaction
          // ignore: cast_nullable_to_non_nullable
          : transaction as Transaction,
      autoAppliedCoupon: autoAppliedCoupon == const $CopyWithPlaceholder()
          ? _value.autoAppliedCoupon
          // ignore: cast_nullable_to_non_nullable
          : autoAppliedCoupon as PlaceOrderResponseAutoAppliedCoupon?,
    );
  }
}

extension $PlaceScheduledOrderResponseCopyWith on PlaceScheduledOrderResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPlaceScheduledOrderResponse.copyWith(...)` or `instanceOfPlaceScheduledOrderResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PlaceScheduledOrderResponseCWProxy get copyWith =>
      _$PlaceScheduledOrderResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceScheduledOrderResponse _$PlaceScheduledOrderResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PlaceScheduledOrderResponse', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['order', 'payment', 'transaction']);
  final val = PlaceScheduledOrderResponse(
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
    autoAppliedCoupon: $checkedConvert(
      'autoAppliedCoupon',
      (v) => v == null
          ? null
          : PlaceOrderResponseAutoAppliedCoupon.fromJson(
              v as Map<String, dynamic>,
            ),
    ),
  );
  return val;
});

Map<String, dynamic> _$PlaceScheduledOrderResponseToJson(
  PlaceScheduledOrderResponse instance,
) => <String, dynamic>{
  'order': instance.order.toJson(),
  'payment': instance.payment.toJson(),
  'transaction': instance.transaction.toJson(),
  'autoAppliedCoupon': ?instance.autoAppliedCoupon?.toJson(),
};
