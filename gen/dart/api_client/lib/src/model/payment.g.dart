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

  Payment bankProvider(BankProvider? bankProvider);

  Payment amount(num amount);

  Payment status(TransactionStatus status);

  Payment externalId(String? externalId);

  Payment paymentUrl(String? paymentUrl);

  Payment vaNumber(VANumber? vaNumber);

  Payment metadata(Object? metadata);

  Payment expiresAt(DateTime? expiresAt);

  Payment payload(Object? payload);

  Payment response(Object? response);

  Payment createdAt(DateTime createdAt);

  Payment updatedAt(DateTime updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Payment(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Payment(...).copyWith(id: 12, name: "My name")
  /// ```
  Payment call({
    String id,
    String transactionId,
    PaymentProvider provider,
    PaymentMethod method,
    BankProvider? bankProvider,
    num amount,
    TransactionStatus status,
    String? externalId,
    String? paymentUrl,
    VANumber? vaNumber,
    Object? metadata,
    DateTime? expiresAt,
    Object? payload,
    Object? response,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPayment.copyWith(...)` or call `instanceOfPayment.copyWith.fieldName(value)` for a single field.
class _$PaymentCWProxyImpl implements _$PaymentCWProxy {
  const _$PaymentCWProxyImpl(this._value);

  final Payment _value;

  @override
  Payment id(String id) => call(id: id);

  @override
  Payment transactionId(String transactionId) =>
      call(transactionId: transactionId);

  @override
  Payment provider(PaymentProvider provider) => call(provider: provider);

  @override
  Payment method(PaymentMethod method) => call(method: method);

  @override
  Payment bankProvider(BankProvider? bankProvider) =>
      call(bankProvider: bankProvider);

  @override
  Payment amount(num amount) => call(amount: amount);

  @override
  Payment status(TransactionStatus status) => call(status: status);

  @override
  Payment externalId(String? externalId) => call(externalId: externalId);

  @override
  Payment paymentUrl(String? paymentUrl) => call(paymentUrl: paymentUrl);

  @override
  Payment vaNumber(VANumber? vaNumber) => call(vaNumber: vaNumber);

  @override
  Payment metadata(Object? metadata) => call(metadata: metadata);

  @override
  Payment expiresAt(DateTime? expiresAt) => call(expiresAt: expiresAt);

  @override
  Payment payload(Object? payload) => call(payload: payload);

  @override
  Payment response(Object? response) => call(response: response);

  @override
  Payment createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  Payment updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Payment(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Payment(...).copyWith(id: 12, name: "My name")
  /// ```
  Payment call({
    Object? id = const $CopyWithPlaceholder(),
    Object? transactionId = const $CopyWithPlaceholder(),
    Object? provider = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
    Object? bankProvider = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? externalId = const $CopyWithPlaceholder(),
    Object? paymentUrl = const $CopyWithPlaceholder(),
    Object? vaNumber = const $CopyWithPlaceholder(),
    Object? metadata = const $CopyWithPlaceholder(),
    Object? expiresAt = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
    Object? response = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Payment(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      transactionId:
          transactionId == const $CopyWithPlaceholder() || transactionId == null
          ? _value.transactionId
          // ignore: cast_nullable_to_non_nullable
          : transactionId as String,
      provider: provider == const $CopyWithPlaceholder() || provider == null
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as PaymentProvider,
      method: method == const $CopyWithPlaceholder() || method == null
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as PaymentMethod,
      bankProvider: bankProvider == const $CopyWithPlaceholder()
          ? _value.bankProvider
          // ignore: cast_nullable_to_non_nullable
          : bankProvider as BankProvider?,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      status: status == const $CopyWithPlaceholder() || status == null
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
      vaNumber: vaNumber == const $CopyWithPlaceholder()
          ? _value.vaNumber
          // ignore: cast_nullable_to_non_nullable
          : vaNumber as VANumber?,
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
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $PaymentCopyWith on Payment {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPayment.copyWith(...)` or `instanceOfPayment.copyWith.fieldName(...)`.
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
    bankProvider: $checkedConvert(
      'bankProvider',
      (v) => $enumDecodeNullable(_$BankProviderEnumMap, v),
    ),
    amount: $checkedConvert('amount', (v) => v as num),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$TransactionStatusEnumMap, v),
    ),
    externalId: $checkedConvert('externalId', (v) => v as String?),
    paymentUrl: $checkedConvert('paymentUrl', (v) => v as String?),
    vaNumber: $checkedConvert(
      'va_number',
      (v) => v == null ? null : VANumber.fromJson(v as Map<String, dynamic>),
    ),
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
}, fieldKeyMap: const {'vaNumber': 'va_number'});

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
  'id': instance.id,
  'transactionId': instance.transactionId,
  'provider': _$PaymentProviderEnumMap[instance.provider]!,
  'method': _$PaymentMethodEnumMap[instance.method]!,
  'bankProvider': ?_$BankProviderEnumMap[instance.bankProvider],
  'amount': instance.amount,
  'status': _$TransactionStatusEnumMap[instance.status]!,
  'externalId': ?instance.externalId,
  'paymentUrl': ?instance.paymentUrl,
  'va_number': ?instance.vaNumber?.toJson(),
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
  PaymentMethod.BANK_TRANSFER: 'BANK_TRANSFER',
  PaymentMethod.WALLET: 'WALLET',
};

const _$BankProviderEnumMap = {
  BankProvider.BCA: 'BCA',
  BankProvider.BNI: 'BNI',
  BankProvider.BRI: 'BRI',
  BankProvider.MANDIRI: 'MANDIRI',
  BankProvider.PERMATA: 'PERMATA',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.PENDING: 'PENDING',
  TransactionStatus.SUCCESS: 'SUCCESS',
  TransactionStatus.FAILED: 'FAILED',
  TransactionStatus.CANCELLED: 'CANCELLED',
  TransactionStatus.EXPIRED: 'EXPIRED',
  TransactionStatus.REFUNDED: 'REFUNDED',
};
