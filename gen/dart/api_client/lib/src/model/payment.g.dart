// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentCWProxy {
  Payment id(String id);

  Payment transactionId(String transactionId);

  Payment provider(PaymentProvider provider);

  Payment method(PaymentMethod method);

  Payment amount(num amount);

  Payment status(TransactionStatus status);

  Payment externalId(String? externalId);

  Payment paymentUrl(String? paymentUrl);

  Payment metadata(Object? metadata);

  Payment expiresAt(DateTime? expiresAt);

  Payment payload(Object? payload);

  Payment response(Object? response);

  Payment createdAt(DateTime createdAt);

  Payment updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Payment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Payment(...).copyWith(id: 12, name: "My name")
  /// ````
  Payment call({
    String id,
    String transactionId,
    PaymentProvider provider,
    PaymentMethod method,
    num amount,
    TransactionStatus status,
    String? externalId,
    String? paymentUrl,
    Object? metadata,
    DateTime? expiresAt,
    Object? payload,
    Object? response,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPayment.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPayment.copyWith.fieldName(...)`
class _$PaymentCWProxyImpl implements _$PaymentCWProxy {
  const _$PaymentCWProxyImpl(this._value);

  final Payment _value;

  @override
  Payment id(String id) => this(id: id);

  @override
  Payment transactionId(String transactionId) =>
      this(transactionId: transactionId);

  @override
  Payment provider(PaymentProvider provider) => this(provider: provider);

  @override
  Payment method(PaymentMethod method) => this(method: method);

  @override
  Payment amount(num amount) => this(amount: amount);

  @override
  Payment status(TransactionStatus status) => this(status: status);

  @override
  Payment externalId(String? externalId) => this(externalId: externalId);

  @override
  Payment paymentUrl(String? paymentUrl) => this(paymentUrl: paymentUrl);

  @override
  Payment metadata(Object? metadata) => this(metadata: metadata);

  @override
  Payment expiresAt(DateTime? expiresAt) => this(expiresAt: expiresAt);

  @override
  Payment payload(Object? payload) => this(payload: payload);

  @override
  Payment response(Object? response) => this(response: response);

  @override
  Payment createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Payment updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Payment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Payment(...).copyWith(id: 12, name: "My name")
  /// ````
  Payment call({
    Object? id = const $CopyWithPlaceholder(),
    Object? transactionId = const $CopyWithPlaceholder(),
    Object? provider = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? externalId = const $CopyWithPlaceholder(),
    Object? paymentUrl = const $CopyWithPlaceholder(),
    Object? metadata = const $CopyWithPlaceholder(),
    Object? expiresAt = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
    Object? response = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Payment(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      transactionId: transactionId == const $CopyWithPlaceholder()
          ? _value.transactionId
          // ignore: cast_nullable_to_non_nullable
          : transactionId as String,
      provider: provider == const $CopyWithPlaceholder()
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as PaymentProvider,
      method: method == const $CopyWithPlaceholder()
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as PaymentMethod,
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as TransactionStatus,
      externalId: externalId == const $CopyWithPlaceholder()
          ? _value.externalId
          // ignore: cast_nullable_to_non_nullable
          : externalId as String?,
      paymentUrl: paymentUrl == const $CopyWithPlaceholder()
          ? _value.paymentUrl
          // ignore: cast_nullable_to_non_nullable
          : paymentUrl as String?,
      metadata: metadata == const $CopyWithPlaceholder()
          ? _value.metadata
          // ignore: cast_nullable_to_non_nullable
          : metadata as Object?,
      expiresAt: expiresAt == const $CopyWithPlaceholder()
          ? _value.expiresAt
          // ignore: cast_nullable_to_non_nullable
          : expiresAt as DateTime?,
      payload: payload == const $CopyWithPlaceholder()
          ? _value.payload
          // ignore: cast_nullable_to_non_nullable
          : payload as Object?,
      response: response == const $CopyWithPlaceholder()
          ? _value.response
          // ignore: cast_nullable_to_non_nullable
          : response as Object?,
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

extension $PaymentCopyWith on Payment {
  /// Returns a callable class that can be used as follows: `instanceOfPayment.copyWith(...)` or like so:`instanceOfPayment.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentCWProxy get copyWith => _$PaymentCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Payment', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'transactionId',
      'provider',
      'method',
      'amount',
      'status',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = Payment(
    id: $checkedConvert('id', (v) => v as String),
    transactionId: $checkedConvert('transactionId', (v) => v as String),
    provider: $checkedConvert(
      'provider',
      (v) => $enumDecode(_$PaymentProviderEnumMap, v),
    ),
    method: $checkedConvert(
      'method',
      (v) => $enumDecode(_$PaymentMethodEnumMap, v),
    ),
    amount: $checkedConvert('amount', (v) => v as num),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$TransactionStatusEnumMap, v),
    ),
    externalId: $checkedConvert('externalId', (v) => v as String?),
    paymentUrl: $checkedConvert('paymentUrl', (v) => v as String?),
    metadata: $checkedConvert('metadata', (v) => v),
    expiresAt: $checkedConvert(
      'expiresAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    payload: $checkedConvert('payload', (v) => v),
    response: $checkedConvert('response', (v) => v),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
  'id': instance.id,
  'transactionId': instance.transactionId,
  'provider': _$PaymentProviderEnumMap[instance.provider]!,
  'method': _$PaymentMethodEnumMap[instance.method]!,
  'amount': instance.amount,
  'status': _$TransactionStatusEnumMap[instance.status]!,
  'externalId': ?instance.externalId,
  'paymentUrl': ?instance.paymentUrl,
  'metadata': ?instance.metadata,
  'expiresAt': ?instance.expiresAt?.toIso8601String(),
  'payload': ?instance.payload,
  'response': ?instance.response,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$PaymentProviderEnumMap = {
  PaymentProvider.MIDTRANS: 'MIDTRANS',
  PaymentProvider.MANUAL: 'MANUAL',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.QRIS: 'QRIS',
  PaymentMethod.VA: 'VA',
  PaymentMethod.BANK_TRANSFER: 'BANK_TRANSFER',
  PaymentMethod.WALLET: 'WALLET',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.pending: 'pending',
  TransactionStatus.success: 'success',
  TransactionStatus.failed: 'failed',
  TransactionStatus.cancelled: 'cancelled',
  TransactionStatus.expired: 'expired',
  TransactionStatus.refunded: 'refunded',
};
