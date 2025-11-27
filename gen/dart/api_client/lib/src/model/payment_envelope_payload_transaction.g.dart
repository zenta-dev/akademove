// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_envelope_payload_transaction.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentEnvelopePayloadTransactionCWProxy {
  PaymentEnvelopePayloadTransaction id(String id);

  PaymentEnvelopePayloadTransaction status(TransactionStatus status);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentEnvelopePayloadTransaction(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentEnvelopePayloadTransaction(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentEnvelopePayloadTransaction call({String id, TransactionStatus status});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPaymentEnvelopePayloadTransaction.copyWith(...)` or call `instanceOfPaymentEnvelopePayloadTransaction.copyWith.fieldName(value)` for a single field.
class _$PaymentEnvelopePayloadTransactionCWProxyImpl
    implements _$PaymentEnvelopePayloadTransactionCWProxy {
  const _$PaymentEnvelopePayloadTransactionCWProxyImpl(this._value);

  final PaymentEnvelopePayloadTransaction _value;

  @override
  PaymentEnvelopePayloadTransaction id(String id) => call(id: id);

  @override
  PaymentEnvelopePayloadTransaction status(TransactionStatus status) =>
      call(status: status);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentEnvelopePayloadTransaction(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentEnvelopePayloadTransaction(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentEnvelopePayloadTransaction call({
    Object? id = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return PaymentEnvelopePayloadTransaction(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as TransactionStatus,
    );
  }
}

extension $PaymentEnvelopePayloadTransactionCopyWith
    on PaymentEnvelopePayloadTransaction {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPaymentEnvelopePayloadTransaction.copyWith(...)` or `instanceOfPaymentEnvelopePayloadTransaction.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentEnvelopePayloadTransactionCWProxy get copyWith =>
      _$PaymentEnvelopePayloadTransactionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentEnvelopePayloadTransaction _$PaymentEnvelopePayloadTransactionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PaymentEnvelopePayloadTransaction', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['id', 'status']);
  final val = PaymentEnvelopePayloadTransaction(
    id: $checkedConvert('id', (v) => v as String),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$TransactionStatusEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$PaymentEnvelopePayloadTransactionToJson(
  PaymentEnvelopePayloadTransaction instance,
) => <String, dynamic>{
  'id': instance.id,
  'status': _$TransactionStatusEnumMap[instance.status]!,
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.PENDING: 'PENDING',
  TransactionStatus.SUCCESS: 'SUCCESS',
  TransactionStatus.FAILED: 'FAILED',
  TransactionStatus.CANCELLED: 'CANCELLED',
  TransactionStatus.EXPIRED: 'EXPIRED',
  TransactionStatus.REFUNDED: 'REFUNDED',
};
