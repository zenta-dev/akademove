// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_payment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertPaymentCWProxy {
  InsertPayment transactionId(String transactionId);

  InsertPayment provider(PaymentProvider provider);

  InsertPayment method(PaymentMethod method);

  InsertPayment amount(num amount);

  InsertPayment status(TransactionStatus status);

  InsertPayment externalId(String? externalId);

  InsertPayment paymentUrl(String? paymentUrl);

  InsertPayment metadata(Object? metadata);

  InsertPayment expiresAt(DateTime? expiresAt);

  InsertPayment payload(Object? payload);

  InsertPayment response(Object? response);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertPayment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertPayment(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertPayment call({
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
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertPayment.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertPayment.copyWith.fieldName(...)`
class _$InsertPaymentCWProxyImpl implements _$InsertPaymentCWProxy {
  const _$InsertPaymentCWProxyImpl(this._value);

  final InsertPayment _value;

  @override
  InsertPayment transactionId(String transactionId) =>
      this(transactionId: transactionId);

  @override
  InsertPayment provider(PaymentProvider provider) => this(provider: provider);

  @override
  InsertPayment method(PaymentMethod method) => this(method: method);

  @override
  InsertPayment amount(num amount) => this(amount: amount);

  @override
  InsertPayment status(TransactionStatus status) => this(status: status);

  @override
  InsertPayment externalId(String? externalId) => this(externalId: externalId);

  @override
  InsertPayment paymentUrl(String? paymentUrl) => this(paymentUrl: paymentUrl);

  @override
  InsertPayment metadata(Object? metadata) => this(metadata: metadata);

  @override
  InsertPayment expiresAt(DateTime? expiresAt) => this(expiresAt: expiresAt);

  @override
  InsertPayment payload(Object? payload) => this(payload: payload);

  @override
  InsertPayment response(Object? response) => this(response: response);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertPayment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertPayment(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertPayment call({
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
  }) {
    return InsertPayment(
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
    );
  }
}

extension $InsertPaymentCopyWith on InsertPayment {
  /// Returns a callable class that can be used as follows: `instanceOfInsertPayment.copyWith(...)` or like so:`instanceOfInsertPayment.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertPaymentCWProxy get copyWith => _$InsertPaymentCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertPayment _$InsertPaymentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertPayment', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'transactionId',
          'provider',
          'method',
          'amount',
          'status',
        ],
      );
      final val = InsertPayment(
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
      );
      return val;
    });

Map<String, dynamic> _$InsertPaymentToJson(InsertPayment instance) =>
    <String, dynamic>{
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
