// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_transaction.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommissionTransactionCWProxy {
  CommissionTransaction id(String id);

  CommissionTransaction type(CommissionTransactionTypeEnum type);

  CommissionTransaction amount(num amount);

  CommissionTransaction description(String? description);

  CommissionTransaction orderType(String? orderType);

  CommissionTransaction createdAt(DateTime createdAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CommissionTransaction(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CommissionTransaction(...).copyWith(id: 12, name: "My name")
  /// ```
  CommissionTransaction call({
    String id,
    CommissionTransactionTypeEnum type,
    num amount,
    String? description,
    String? orderType,
    DateTime createdAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCommissionTransaction.copyWith(...)` or call `instanceOfCommissionTransaction.copyWith.fieldName(value)` for a single field.
class _$CommissionTransactionCWProxyImpl
    implements _$CommissionTransactionCWProxy {
  const _$CommissionTransactionCWProxyImpl(this._value);

  final CommissionTransaction _value;

  @override
  CommissionTransaction id(String id) => call(id: id);

  @override
  CommissionTransaction type(CommissionTransactionTypeEnum type) =>
      call(type: type);

  @override
  CommissionTransaction amount(num amount) => call(amount: amount);

  @override
  CommissionTransaction description(String? description) =>
      call(description: description);

  @override
  CommissionTransaction orderType(String? orderType) =>
      call(orderType: orderType);

  @override
  CommissionTransaction createdAt(DateTime createdAt) =>
      call(createdAt: createdAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CommissionTransaction(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CommissionTransaction(...).copyWith(id: 12, name: "My name")
  /// ```
  CommissionTransaction call({
    Object? id = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return CommissionTransaction(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as CommissionTransactionTypeEnum,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      orderType: orderType == const $CopyWithPlaceholder()
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as String?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
    );
  }
}

extension $CommissionTransactionCopyWith on CommissionTransaction {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCommissionTransaction.copyWith(...)` or `instanceOfCommissionTransaction.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommissionTransactionCWProxy get copyWith =>
      _$CommissionTransactionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommissionTransaction _$CommissionTransactionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CommissionTransaction', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'type', 'amount', 'createdAt']);
  final val = CommissionTransaction(
    id: $checkedConvert('id', (v) => v as String),
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$CommissionTransactionTypeEnumEnumMap, v),
    ),
    amount: $checkedConvert('amount', (v) => v as num),
    description: $checkedConvert('description', (v) => v as String?),
    orderType: $checkedConvert('orderType', (v) => v as String?),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$CommissionTransactionToJson(
  CommissionTransaction instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$CommissionTransactionTypeEnumEnumMap[instance.type]!,
  'amount': instance.amount,
  'description': ?instance.description,
  'orderType': ?instance.orderType,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$CommissionTransactionTypeEnumEnumMap = {
  CommissionTransactionTypeEnum.EARNING: 'EARNING',
  CommissionTransactionTypeEnum.COMMISSION: 'COMMISSION',
};
