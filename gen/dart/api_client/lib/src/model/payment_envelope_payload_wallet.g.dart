// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_envelope_payload_wallet.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentEnvelopePayloadWalletCWProxy {
  PaymentEnvelopePayloadWallet id(String id);

  PaymentEnvelopePayloadWallet balance(num balance);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentEnvelopePayloadWallet(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentEnvelopePayloadWallet(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentEnvelopePayloadWallet call({String id, num balance});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPaymentEnvelopePayloadWallet.copyWith(...)` or call `instanceOfPaymentEnvelopePayloadWallet.copyWith.fieldName(value)` for a single field.
class _$PaymentEnvelopePayloadWalletCWProxyImpl
    implements _$PaymentEnvelopePayloadWalletCWProxy {
  const _$PaymentEnvelopePayloadWalletCWProxyImpl(this._value);

  final PaymentEnvelopePayloadWallet _value;

  @override
  PaymentEnvelopePayloadWallet id(String id) => call(id: id);

  @override
  PaymentEnvelopePayloadWallet balance(num balance) => call(balance: balance);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentEnvelopePayloadWallet(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentEnvelopePayloadWallet(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentEnvelopePayloadWallet call({
    Object? id = const $CopyWithPlaceholder(),
    Object? balance = const $CopyWithPlaceholder(),
  }) {
    return PaymentEnvelopePayloadWallet(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      balance: balance == const $CopyWithPlaceholder() || balance == null
          ? _value.balance
          // ignore: cast_nullable_to_non_nullable
          : balance as num,
    );
  }
}

extension $PaymentEnvelopePayloadWalletCopyWith
    on PaymentEnvelopePayloadWallet {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPaymentEnvelopePayloadWallet.copyWith(...)` or `instanceOfPaymentEnvelopePayloadWallet.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentEnvelopePayloadWalletCWProxy get copyWith =>
      _$PaymentEnvelopePayloadWalletCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentEnvelopePayloadWallet _$PaymentEnvelopePayloadWalletFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PaymentEnvelopePayloadWallet', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'balance']);
  final val = PaymentEnvelopePayloadWallet(
    id: $checkedConvert('id', (v) => v as String),
    balance: $checkedConvert('balance', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$PaymentEnvelopePayloadWalletToJson(
  PaymentEnvelopePayloadWallet instance,
) => <String, dynamic>{'id': instance.id, 'balance': instance.balance};
