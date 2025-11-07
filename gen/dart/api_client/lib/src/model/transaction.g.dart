// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionCWProxy {
  Transaction id(String id);

  Transaction walletId(String walletId);

  Transaction type(TransactionType type);

  Transaction amount(num amount);

  Transaction balanceBefore(num? balanceBefore);

  Transaction balanceAfter(num? balanceAfter);

  Transaction status(TransactionStatus status);

  Transaction description(String? description);

  Transaction referenceId(String? referenceId);

  Transaction metadata(Object? metadata);

  Transaction createdAt(DateTime createdAt);

  Transaction updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Transaction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Transaction(...).copyWith(id: 12, name: "My name")
  /// ````
  Transaction call({
    String id,
    String walletId,
    TransactionType type,
    num amount,
    num? balanceBefore,
    num? balanceAfter,
    TransactionStatus status,
    String? description,
    String? referenceId,
    Object? metadata,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransaction.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransaction.copyWith.fieldName(...)`
class _$TransactionCWProxyImpl implements _$TransactionCWProxy {
  const _$TransactionCWProxyImpl(this._value);

  final Transaction _value;

  @override
  Transaction id(String id) => this(id: id);

  @override
  Transaction walletId(String walletId) => this(walletId: walletId);

  @override
  Transaction type(TransactionType type) => this(type: type);

  @override
  Transaction amount(num amount) => this(amount: amount);

  @override
  Transaction balanceBefore(num? balanceBefore) =>
      this(balanceBefore: balanceBefore);

  @override
  Transaction balanceAfter(num? balanceAfter) =>
      this(balanceAfter: balanceAfter);

  @override
  Transaction status(TransactionStatus status) => this(status: status);

  @override
  Transaction description(String? description) =>
      this(description: description);

  @override
  Transaction referenceId(String? referenceId) =>
      this(referenceId: referenceId);

  @override
  Transaction metadata(Object? metadata) => this(metadata: metadata);

  @override
  Transaction createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Transaction updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Transaction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Transaction(...).copyWith(id: 12, name: "My name")
  /// ````
  Transaction call({
    Object? id = const $CopyWithPlaceholder(),
    Object? walletId = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? balanceBefore = const $CopyWithPlaceholder(),
    Object? balanceAfter = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? referenceId = const $CopyWithPlaceholder(),
    Object? metadata = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Transaction(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      walletId: walletId == const $CopyWithPlaceholder()
          ? _value.walletId
          // ignore: cast_nullable_to_non_nullable
          : walletId as String,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as TransactionType,
      amount: amount == const $CopyWithPlaceholder()
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
      status: status == const $CopyWithPlaceholder()
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
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $TransactionCopyWith on Transaction {
  /// Returns a callable class that can be used as follows: `instanceOfTransaction.copyWith(...)` or like so:`instanceOfTransaction.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionCWProxy get copyWith => _$TransactionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Transaction', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'walletId',
      'type',
      'amount',
      'status',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = Transaction(
    id: $checkedConvert('id', (v) => v as String),
    walletId: $checkedConvert('walletId', (v) => v as String),
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$TransactionTypeEnumMap, v),
    ),
    amount: $checkedConvert('amount', (v) => v as num),
    balanceBefore: $checkedConvert('balanceBefore', (v) => v as num?),
    balanceAfter: $checkedConvert('balanceAfter', (v) => v as num?),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$TransactionStatusEnumMap, v),
    ),
    description: $checkedConvert('description', (v) => v as String?),
    referenceId: $checkedConvert('referenceId', (v) => v as String?),
    metadata: $checkedConvert('metadata', (v) => v),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'walletId': instance.walletId,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'balanceBefore': ?instance.balanceBefore,
      'balanceAfter': ?instance.balanceAfter,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'description': ?instance.description,
      'referenceId': ?instance.referenceId,
      'metadata': ?instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.topup: 'topup',
  TransactionType.withdraw: 'withdraw',
  TransactionType.payment: 'payment',
  TransactionType.refund: 'refund',
  TransactionType.adjustment: 'adjustment',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.pending: 'pending',
  TransactionStatus.success: 'success',
  TransactionStatus.failed: 'failed',
  TransactionStatus.cancelled: 'cancelled',
  TransactionStatus.expired: 'expired',
  TransactionStatus.refunded: 'refunded',
};
