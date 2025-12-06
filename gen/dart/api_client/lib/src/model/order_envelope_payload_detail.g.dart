// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_envelope_payload_detail.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEnvelopePayloadDetailCWProxy {
  OrderEnvelopePayloadDetail order(Order order);

  OrderEnvelopePayloadDetail payment(Payment? payment);

  OrderEnvelopePayloadDetail transaction(Transaction? transaction);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadDetail(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadDetail(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadDetail call({
    Order order,
    Payment? payment,
    Transaction? transaction,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEnvelopePayloadDetail.copyWith(...)` or call `instanceOfOrderEnvelopePayloadDetail.copyWith.fieldName(value)` for a single field.
class _$OrderEnvelopePayloadDetailCWProxyImpl
    implements _$OrderEnvelopePayloadDetailCWProxy {
  const _$OrderEnvelopePayloadDetailCWProxyImpl(this._value);

  final OrderEnvelopePayloadDetail _value;

  @override
  OrderEnvelopePayloadDetail order(Order order) => call(order: order);

  @override
  OrderEnvelopePayloadDetail payment(Payment? payment) =>
      call(payment: payment);

  @override
  OrderEnvelopePayloadDetail transaction(Transaction? transaction) =>
      call(transaction: transaction);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadDetail(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadDetail(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadDetail call({
    Object? order = const $CopyWithPlaceholder(),
    Object? payment = const $CopyWithPlaceholder(),
    Object? transaction = const $CopyWithPlaceholder(),
  }) {
    return OrderEnvelopePayloadDetail(
      order: order == const $CopyWithPlaceholder() || order == null
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as Order,
      payment: payment == const $CopyWithPlaceholder()
          ? _value.payment
          // ignore: cast_nullable_to_non_nullable
          : payment as Payment?,
      transaction: transaction == const $CopyWithPlaceholder()
          ? _value.transaction
          // ignore: cast_nullable_to_non_nullable
          : transaction as Transaction?,
    );
  }
}

extension $OrderEnvelopePayloadDetailCopyWith on OrderEnvelopePayloadDetail {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEnvelopePayloadDetail.copyWith(...)` or `instanceOfOrderEnvelopePayloadDetail.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEnvelopePayloadDetailCWProxy get copyWith =>
      _$OrderEnvelopePayloadDetailCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEnvelopePayloadDetail _$OrderEnvelopePayloadDetailFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderEnvelopePayloadDetail', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['order', 'payment', 'transaction']);
  final val = OrderEnvelopePayloadDetail(
    order: $checkedConvert(
      'order',
      (v) => Order.fromJson(v as Map<String, dynamic>),
    ),
    payment: $checkedConvert(
      'payment',
      (v) => v == null ? null : Payment.fromJson(v as Map<String, dynamic>),
    ),
    transaction: $checkedConvert(
      'transaction',
      (v) => v == null ? null : Transaction.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$OrderEnvelopePayloadDetailToJson(
  OrderEnvelopePayloadDetail instance,
) => <String, dynamic>{
  'order': instance.order.toJson(),
  'payment': instance.payment?.toJson(),
  'transaction': instance.transaction?.toJson(),
};
