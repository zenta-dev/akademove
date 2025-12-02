// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_transaction.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertTransactionCWProxy {
  InsertTransaction walletId(String walletId);

  InsertTransaction type(TransactionType type);

  InsertTransaction amount(num amount);

  InsertTransaction balanceBefore(num? balanceBefore);

  InsertTransaction balanceAfter(num? balanceAfter);

  InsertTransaction status(TransactionStatus status);

  InsertTransaction description(String? description);

  InsertTransaction referenceId(String? referenceId);

  InsertTransaction metadata(Object? metadata);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertTransaction(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertTransaction(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertTransaction call({
    String walletId,
    TransactionType type,
    num amount,
    num? balanceBefore,
    num? balanceAfter,
    TransactionStatus status,
    String? description,
    String? referenceId,
    Object? metadata,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertTransaction.copyWith(...)` or call `instanceOfInsertTransaction.copyWith.fieldName(value)` for a single field.
class _$InsertTransactionCWProxyImpl implements _$InsertTransactionCWProxy {
  const _$InsertTransactionCWProxyImpl(this._value);

  final InsertTransaction _value;

  @override
  InsertTransaction walletId(String walletId) => call(walletId: walletId);

  @override
  InsertTransaction type(TransactionType type) => call(type: type);

  @override
  InsertTransaction amount(num amount) => call(amount: amount);

  @override
  InsertTransaction balanceBefore(num? balanceBefore) => call(balanceBefore: balanceBefore);

  @override
  InsertTransaction balanceAfter(num? balanceAfter) => call(balanceAfter: balanceAfter);

  @override
  InsertTransaction status(TransactionStatus status) => call(status: status);

  @override
  InsertTransaction description(String? description) => call(description: description);

  @override
  InsertTransaction referenceId(String? referenceId) => call(referenceId: referenceId);

  @override
  InsertTransaction metadata(Object? metadata) => call(metadata: metadata);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertTransaction(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertTransaction(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertTransaction call({
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
    return InsertTransaction(
      walletId: walletId == const $CopyWithPlaceholder() || walletId == null
          ? _value.walletId
          // ignore: cast_nullable_to_non_nullable
          : walletId as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as TransactionType,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      balanceBefore: balanceBefore == const $CopyWithPlaceholder()
          ? _value.balanceBefore
          // ignore: cast_nullable_to_non_nullable
          : balanceBefore as num?,
      balanceAfter: balanceAfter == const $CopyWithPlaceholder()
          ? _value.balanceAfter
          // ignore: cast_nullable_to_non_nullable
          : balanceAfter as num?,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as TransactionStatus,
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

extension $InsertTransactionCopyWith on InsertTransaction {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertTransaction.copyWith(...)` or `instanceOfInsertTransaction.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertTransactionCWProxy get copyWith => _$InsertTransactionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertTransaction _$InsertTransactionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertTransaction', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['walletId', 'type', 'amount', 'status']);
      final val = InsertTransaction(
        walletId: $checkedConvert('walletId', (v) => v as String),
        type: $checkedConvert('type', (v) => $enumDecode(_$TransactionTypeEnumMap, v)),
        amount: $checkedConvert('amount', (v) => v as num),
        balanceBefore: $checkedConvert('balanceBefore', (v) => v as num?),
        balanceAfter: $checkedConvert('balanceAfter', (v) => v as num?),
        status: $checkedConvert('status', (v) => $enumDecode(_$TransactionStatusEnumMap, v)),
        description: $checkedConvert('description', (v) => v as String?),
        referenceId: $checkedConvert('referenceId', (v) => v as String?),
        metadata: $checkedConvert('metadata', (v) => v),
      );
      return val;
    });

Map<String, dynamic> _$InsertTransactionToJson(InsertTransaction instance) => <String, dynamic>{
  'walletId': instance.walletId,
  'type': _$TransactionTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'balanceBefore': ?instance.balanceBefore,
  'balanceAfter': ?instance.balanceAfter,
  'status': _$TransactionStatusEnumMap[instance.status]!,
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
