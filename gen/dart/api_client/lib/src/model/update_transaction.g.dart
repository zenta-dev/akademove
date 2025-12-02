// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_transaction.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateTransactionCWProxy {
  UpdateTransaction walletId(String? walletId);

  UpdateTransaction type(TransactionType? type);

  UpdateTransaction amount(num? amount);

  UpdateTransaction balanceBefore(num? balanceBefore);

  UpdateTransaction balanceAfter(num? balanceAfter);

  UpdateTransaction status(TransactionStatus? status);

  UpdateTransaction description(String? description);

  UpdateTransaction referenceId(String? referenceId);

  UpdateTransaction metadata(Object? metadata);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateTransaction(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateTransaction(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateTransaction call({
    String? walletId,
    TransactionType? type,
    num? amount,
    num? balanceBefore,
    num? balanceAfter,
    TransactionStatus? status,
    String? description,
    String? referenceId,
    Object? metadata,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateTransaction.copyWith(...)` or call `instanceOfUpdateTransaction.copyWith.fieldName(value)` for a single field.
class _$UpdateTransactionCWProxyImpl implements _$UpdateTransactionCWProxy {
  const _$UpdateTransactionCWProxyImpl(this._value);

  final UpdateTransaction _value;

  @override
  UpdateTransaction walletId(String? walletId) => call(walletId: walletId);

  @override
  UpdateTransaction type(TransactionType? type) => call(type: type);

  @override
  UpdateTransaction amount(num? amount) => call(amount: amount);

  @override
  UpdateTransaction balanceBefore(num? balanceBefore) => call(balanceBefore: balanceBefore);

  @override
  UpdateTransaction balanceAfter(num? balanceAfter) => call(balanceAfter: balanceAfter);

  @override
  UpdateTransaction status(TransactionStatus? status) => call(status: status);

  @override
  UpdateTransaction description(String? description) => call(description: description);

  @override
  UpdateTransaction referenceId(String? referenceId) => call(referenceId: referenceId);

  @override
  UpdateTransaction metadata(Object? metadata) => call(metadata: metadata);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateTransaction(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateTransaction(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateTransaction call({
    Object? walletId = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? balanceBefore = const $CopyWithPlaceholder(),
    Object? balanceAfter = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? referenceId = const $CopyWithPlaceholder(),
    Object? metadata = const $CopyWithPlaceholder(),
  }) {
    return UpdateTransaction(
      walletId: walletId == const $CopyWithPlaceholder()
          ? _value.walletId
          // ignore: cast_nullable_to_non_nullable
          : walletId as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as TransactionType?,
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num?,
      balanceBefore: balanceBefore == const $CopyWithPlaceholder()
          ? _value.balanceBefore
          // ignore: cast_nullable_to_non_nullable
          : balanceBefore as num?,
      balanceAfter: balanceAfter == const $CopyWithPlaceholder()
          ? _value.balanceAfter
          // ignore: cast_nullable_to_non_nullable
          : balanceAfter as num?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as TransactionStatus?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      referenceId: referenceId == const $CopyWithPlaceholder()
          ? _value.referenceId
          // ignore: cast_nullable_to_non_nullable
          : referenceId as String?,
      metadata: metadata == const $CopyWithPlaceholder()
          ? _value.metadata
          // ignore: cast_nullable_to_non_nullable
          : metadata as Object?,
    );
  }
}

extension $UpdateTransactionCopyWith on UpdateTransaction {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateTransaction.copyWith(...)` or `instanceOfUpdateTransaction.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateTransactionCWProxy get copyWith => _$UpdateTransactionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTransaction _$UpdateTransactionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateTransaction', json, ($checkedConvert) {
      final val = UpdateTransaction(
        walletId: $checkedConvert('walletId', (v) => v as String?),
        type: $checkedConvert('type', (v) => $enumDecodeNullable(_$TransactionTypeEnumMap, v)),
        amount: $checkedConvert('amount', (v) => v as num?),
        balanceBefore: $checkedConvert('balanceBefore', (v) => v as num?),
        balanceAfter: $checkedConvert('balanceAfter', (v) => v as num?),
        status: $checkedConvert('status', (v) => $enumDecodeNullable(_$TransactionStatusEnumMap, v)),
        description: $checkedConvert('description', (v) => v as String?),
        referenceId: $checkedConvert('referenceId', (v) => v as String?),
        metadata: $checkedConvert('metadata', (v) => v),
      );
      return val;
    });

Map<String, dynamic> _$UpdateTransactionToJson(UpdateTransaction instance) => <String, dynamic>{
  'walletId': ?instance.walletId,
  'type': ?_$TransactionTypeEnumMap[instance.type],
  'amount': ?instance.amount,
  'balanceBefore': ?instance.balanceBefore,
  'balanceAfter': ?instance.balanceAfter,
  'status': ?_$TransactionStatusEnumMap[instance.status],
  'description': ?instance.description,
  'referenceId': ?instance.referenceId,
  'metadata': ?instance.metadata,
};

const _$TransactionTypeEnumMap = {
  TransactionType.TOPUP: 'TOPUP',
  TransactionType.WITHDRAW: 'WITHDRAW',
  TransactionType.PAYMENT: 'PAYMENT',
  TransactionType.REFUND: 'REFUND',
  TransactionType.ADJUSTMENT: 'ADJUSTMENT',
  TransactionType.COMMISSION: 'COMMISSION',
  TransactionType.EARNING: 'EARNING',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.PENDING: 'PENDING',
  TransactionStatus.SUCCESS: 'SUCCESS',
  TransactionStatus.FAILED: 'FAILED',
  TransactionStatus.CANCELLED: 'CANCELLED',
  TransactionStatus.EXPIRED: 'EXPIRED',
  TransactionStatus.REFUNDED: 'REFUNDED',
};
