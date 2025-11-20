// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_payment_envelope_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WSPaymentEnvelopePayloadCWProxy {
  WSPaymentEnvelopePayload wallet(Wallet wallet);

  WSPaymentEnvelopePayload transaction(Transaction transaction);

  WSPaymentEnvelopePayload payment(Payment payment);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WSPaymentEnvelopePayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WSPaymentEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ```
  WSPaymentEnvelopePayload call({
    Wallet wallet,
    Transaction transaction,
    Payment payment,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWSPaymentEnvelopePayload.copyWith(...)` or call `instanceOfWSPaymentEnvelopePayload.copyWith.fieldName(value)` for a single field.
class _$WSPaymentEnvelopePayloadCWProxyImpl
    implements _$WSPaymentEnvelopePayloadCWProxy {
  const _$WSPaymentEnvelopePayloadCWProxyImpl(this._value);

  final WSPaymentEnvelopePayload _value;

  @override
  WSPaymentEnvelopePayload wallet(Wallet wallet) => call(wallet: wallet);

  @override
  WSPaymentEnvelopePayload transaction(Transaction transaction) =>
      call(transaction: transaction);

  @override
  WSPaymentEnvelopePayload payment(Payment payment) => call(payment: payment);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WSPaymentEnvelopePayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WSPaymentEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ```
  WSPaymentEnvelopePayload call({
    Object? wallet = const $CopyWithPlaceholder(),
    Object? transaction = const $CopyWithPlaceholder(),
    Object? payment = const $CopyWithPlaceholder(),
  }) {
    return WSPaymentEnvelopePayload(
      wallet: wallet == const $CopyWithPlaceholder() || wallet == null
          ? _value.wallet
          // ignore: cast_nullable_to_non_nullable
          : wallet as Wallet,
      transaction:
          transaction == const $CopyWithPlaceholder() || transaction == null
          ? _value.transaction
          // ignore: cast_nullable_to_non_nullable
          : transaction as Transaction,
      payment: payment == const $CopyWithPlaceholder() || payment == null
          ? _value.payment
          // ignore: cast_nullable_to_non_nullable
          : payment as Payment,
    );
  }
}

extension $WSPaymentEnvelopePayloadCopyWith on WSPaymentEnvelopePayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWSPaymentEnvelopePayload.copyWith(...)` or `instanceOfWSPaymentEnvelopePayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WSPaymentEnvelopePayloadCWProxy get copyWith =>
      _$WSPaymentEnvelopePayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WSPaymentEnvelopePayload _$WSPaymentEnvelopePayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WSPaymentEnvelopePayload', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['wallet', 'transaction', 'payment']);
  final val = WSPaymentEnvelopePayload(
    wallet: $checkedConvert(
      'wallet',
      (v) => Wallet.fromJson(v as Map<String, dynamic>),
    ),
    transaction: $checkedConvert(
      'transaction',
      (v) => Transaction.fromJson(v as Map<String, dynamic>),
    ),
    payment: $checkedConvert(
      'payment',
      (v) => Payment.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$WSPaymentEnvelopePayloadToJson(
  WSPaymentEnvelopePayload instance,
) => <String, dynamic>{
  'wallet': instance.wallet.toJson(),
  'transaction': instance.transaction.toJson(),
  'payment': instance.payment.toJson(),
};
