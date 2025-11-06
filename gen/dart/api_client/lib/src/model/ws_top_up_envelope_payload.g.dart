// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_top_up_envelope_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WSTopUpEnvelopePayloadCWProxy {
  WSTopUpEnvelopePayload status(TransactionStatus status);

  WSTopUpEnvelopePayload wallet(Wallet wallet);

  WSTopUpEnvelopePayload transaction(Transaction transaction);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSTopUpEnvelopePayload(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSTopUpEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ````
  WSTopUpEnvelopePayload call({
    TransactionStatus status,
    Wallet wallet,
    Transaction transaction,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWSTopUpEnvelopePayload.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWSTopUpEnvelopePayload.copyWith.fieldName(...)`
class _$WSTopUpEnvelopePayloadCWProxyImpl
    implements _$WSTopUpEnvelopePayloadCWProxy {
  const _$WSTopUpEnvelopePayloadCWProxyImpl(this._value);

  final WSTopUpEnvelopePayload _value;

  @override
  WSTopUpEnvelopePayload status(TransactionStatus status) =>
      this(status: status);

  @override
  WSTopUpEnvelopePayload wallet(Wallet wallet) => this(wallet: wallet);

  @override
  WSTopUpEnvelopePayload transaction(Transaction transaction) =>
      this(transaction: transaction);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSTopUpEnvelopePayload(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSTopUpEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ````
  WSTopUpEnvelopePayload call({
    Object? status = const $CopyWithPlaceholder(),
    Object? wallet = const $CopyWithPlaceholder(),
    Object? transaction = const $CopyWithPlaceholder(),
  }) {
    return WSTopUpEnvelopePayload(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as TransactionStatus,
      wallet: wallet == const $CopyWithPlaceholder()
          ? _value.wallet
          // ignore: cast_nullable_to_non_nullable
          : wallet as Wallet,
      transaction: transaction == const $CopyWithPlaceholder()
          ? _value.transaction
          // ignore: cast_nullable_to_non_nullable
          : transaction as Transaction,
    );
  }
}

extension $WSTopUpEnvelopePayloadCopyWith on WSTopUpEnvelopePayload {
  /// Returns a callable class that can be used as follows: `instanceOfWSTopUpEnvelopePayload.copyWith(...)` or like so:`instanceOfWSTopUpEnvelopePayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WSTopUpEnvelopePayloadCWProxy get copyWith =>
      _$WSTopUpEnvelopePayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WSTopUpEnvelopePayload _$WSTopUpEnvelopePayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WSTopUpEnvelopePayload', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['status', 'wallet', 'transaction']);
  final val = WSTopUpEnvelopePayload(
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$TransactionStatusEnumMap, v),
    ),
    wallet: $checkedConvert(
      'wallet',
      (v) => Wallet.fromJson(v as Map<String, dynamic>),
    ),
    transaction: $checkedConvert(
      'transaction',
      (v) => Transaction.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$WSTopUpEnvelopePayloadToJson(
  WSTopUpEnvelopePayload instance,
) => <String, dynamic>{
  'status': _$TransactionStatusEnumMap[instance.status]!,
  'wallet': instance.wallet.toJson(),
  'transaction': instance.transaction.toJson(),
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.pending: 'pending',
  TransactionStatus.success: 'success',
  TransactionStatus.failed: 'failed',
  TransactionStatus.cancelled: 'cancelled',
  TransactionStatus.expired: 'expired',
  TransactionStatus.refunded: 'refunded',
};
