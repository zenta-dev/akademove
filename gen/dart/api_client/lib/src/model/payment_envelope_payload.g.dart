// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_envelope_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentEnvelopePayloadCWProxy {
  PaymentEnvelopePayload failReason(String? failReason);

  PaymentEnvelopePayload payment(Payment payment);

  PaymentEnvelopePayload transaction(Transaction transaction);

  PaymentEnvelopePayload wallet(Wallet? wallet);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentEnvelopePayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentEnvelopePayload call({String? failReason, Payment payment, Transaction transaction, Wallet? wallet});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPaymentEnvelopePayload.copyWith(...)` or call `instanceOfPaymentEnvelopePayload.copyWith.fieldName(value)` for a single field.
class _$PaymentEnvelopePayloadCWProxyImpl implements _$PaymentEnvelopePayloadCWProxy {
  const _$PaymentEnvelopePayloadCWProxyImpl(this._value);

  final PaymentEnvelopePayload _value;

  @override
  PaymentEnvelopePayload failReason(String? failReason) => call(failReason: failReason);

  @override
  PaymentEnvelopePayload payment(Payment payment) => call(payment: payment);

  @override
  PaymentEnvelopePayload transaction(Transaction transaction) => call(transaction: transaction);

  @override
  PaymentEnvelopePayload wallet(Wallet? wallet) => call(wallet: wallet);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentEnvelopePayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentEnvelopePayload call({
    Object? failReason = const $CopyWithPlaceholder(),
    Object? payment = const $CopyWithPlaceholder(),
    Object? transaction = const $CopyWithPlaceholder(),
    Object? wallet = const $CopyWithPlaceholder(),
  }) {
    return PaymentEnvelopePayload(
      failReason: failReason == const $CopyWithPlaceholder()
          ? _value.failReason
          // ignore: cast_nullable_to_non_nullable
          : failReason as String?,
      payment: payment == const $CopyWithPlaceholder() || payment == null
          ? _value.payment
          // ignore: cast_nullable_to_non_nullable
          : payment as Payment,
      transaction: transaction == const $CopyWithPlaceholder() || transaction == null
          ? _value.transaction
          // ignore: cast_nullable_to_non_nullable
          : transaction as Transaction,
      wallet: wallet == const $CopyWithPlaceholder()
          ? _value.wallet
          // ignore: cast_nullable_to_non_nullable
          : wallet as Wallet?,
    );
  }
}

extension $PaymentEnvelopePayloadCopyWith on PaymentEnvelopePayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPaymentEnvelopePayload.copyWith(...)` or `instanceOfPaymentEnvelopePayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentEnvelopePayloadCWProxy get copyWith => _$PaymentEnvelopePayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentEnvelopePayload _$PaymentEnvelopePayloadFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PaymentEnvelopePayload', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['payment', 'transaction']);
      final val = PaymentEnvelopePayload(
        failReason: $checkedConvert('failReason', (v) => v as String?),
        payment: $checkedConvert('payment', (v) => Payment.fromJson(v as Map<String, dynamic>)),
        transaction: $checkedConvert('transaction', (v) => Transaction.fromJson(v as Map<String, dynamic>)),
        wallet: $checkedConvert('wallet', (v) => v == null ? null : Wallet.fromJson(v as Map<String, dynamic>)),
      );
      return val;
    });

Map<String, dynamic> _$PaymentEnvelopePayloadToJson(PaymentEnvelopePayload instance) => <String, dynamic>{
  'failReason': ?instance.failReason,
  'payment': instance.payment.toJson(),
  'transaction': instance.transaction.toJson(),
  'wallet': ?instance.wallet?.toJson(),
};
