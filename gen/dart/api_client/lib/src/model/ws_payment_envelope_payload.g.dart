// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_payment_envelope_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WSPaymentEnvelopePayloadCWProxy {
  WSPaymentEnvelopePayload wallet(Wallet wallet);

  WSPaymentEnvelopePayload transaction(Transaction transaction);

  WSPaymentEnvelopePayload payment(Payment payment);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSPaymentEnvelopePayload(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSPaymentEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ````
  WSPaymentEnvelopePayload call({
    Wallet wallet,
    Transaction transaction,
    Payment payment,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWSPaymentEnvelopePayload.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWSPaymentEnvelopePayload.copyWith.fieldName(...)`
class _$WSPaymentEnvelopePayloadCWProxyImpl
    implements _$WSPaymentEnvelopePayloadCWProxy {
  const _$WSPaymentEnvelopePayloadCWProxyImpl(this._value);

  final WSPaymentEnvelopePayload _value;

  @override
  WSPaymentEnvelopePayload wallet(Wallet wallet) => this(wallet: wallet);

  @override
  WSPaymentEnvelopePayload transaction(Transaction transaction) =>
      this(transaction: transaction);

  @override
  WSPaymentEnvelopePayload payment(Payment payment) => this(payment: payment);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSPaymentEnvelopePayload(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSPaymentEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ````
  WSPaymentEnvelopePayload call({
    Object? wallet = const $CopyWithPlaceholder(),
    Object? transaction = const $CopyWithPlaceholder(),
    Object? payment = const $CopyWithPlaceholder(),
  }) {
    return WSPaymentEnvelopePayload(
      wallet: wallet == const $CopyWithPlaceholder()
          ? _value.wallet
          // ignore: cast_nullable_to_non_nullable
          : wallet as Wallet,
      transaction: transaction == const $CopyWithPlaceholder()
          ? _value.transaction
          // ignore: cast_nullable_to_non_nullable
          : transaction as Transaction,
      payment: payment == const $CopyWithPlaceholder()
          ? _value.payment
          // ignore: cast_nullable_to_non_nullable
          : payment as Payment,
    );
  }
}

extension $WSPaymentEnvelopePayloadCopyWith on WSPaymentEnvelopePayload {
  /// Returns a callable class that can be used as follows: `instanceOfWSPaymentEnvelopePayload.copyWith(...)` or like so:`instanceOfWSPaymentEnvelopePayload.copyWith.fieldName(...)`.
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
