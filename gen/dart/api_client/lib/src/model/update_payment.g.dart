// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_payment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdatePaymentCWProxy {
  UpdatePayment transactionId(String? transactionId);

  UpdatePayment provider(PaymentProvider? provider);

  UpdatePayment method(PaymentMethod? method);

  UpdatePayment amount(num? amount);

  UpdatePayment status(TransactionStatus? status);

  UpdatePayment externalId(String? externalId);

  UpdatePayment paymentUrl(String? paymentUrl);

  UpdatePayment metadata(Object? metadata);

  UpdatePayment expiresAt(DateTime? expiresAt);

  UpdatePayment payload(Object? payload);

  UpdatePayment response(Object? response);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdatePayment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdatePayment(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdatePayment call({
    String? transactionId,
    PaymentProvider? provider,
    PaymentMethod? method,
    num? amount,
    TransactionStatus? status,
    String? externalId,
    String? paymentUrl,
    Object? metadata,
    DateTime? expiresAt,
    Object? payload,
    Object? response,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdatePayment.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdatePayment.copyWith.fieldName(...)`
class _$UpdatePaymentCWProxyImpl implements _$UpdatePaymentCWProxy {
  const _$UpdatePaymentCWProxyImpl(this._value);

  final UpdatePayment _value;

  @override
  UpdatePayment transactionId(String? transactionId) =>
      this(transactionId: transactionId);

  @override
  UpdatePayment provider(PaymentProvider? provider) => this(provider: provider);

  @override
  UpdatePayment method(PaymentMethod? method) => this(method: method);

  @override
  UpdatePayment amount(num? amount) => this(amount: amount);

  @override
  UpdatePayment status(TransactionStatus? status) => this(status: status);

  @override
  UpdatePayment externalId(String? externalId) => this(externalId: externalId);

  @override
  UpdatePayment paymentUrl(String? paymentUrl) => this(paymentUrl: paymentUrl);

  @override
  UpdatePayment metadata(Object? metadata) => this(metadata: metadata);

  @override
  UpdatePayment expiresAt(DateTime? expiresAt) => this(expiresAt: expiresAt);

  @override
  UpdatePayment payload(Object? payload) => this(payload: payload);

  @override
  UpdatePayment response(Object? response) => this(response: response);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdatePayment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdatePayment(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdatePayment call({
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
    return UpdatePayment(
      transactionId: transactionId == const $CopyWithPlaceholder()
          ? _value.transactionId
          // ignore: cast_nullable_to_non_nullable
          : transactionId as String?,
      provider: provider == const $CopyWithPlaceholder()
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as PaymentProvider?,
      method: method == const $CopyWithPlaceholder()
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as PaymentMethod?,
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as TransactionStatus?,
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

extension $UpdatePaymentCopyWith on UpdatePayment {
  /// Returns a callable class that can be used as follows: `instanceOfUpdatePayment.copyWith(...)` or like so:`instanceOfUpdatePayment.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdatePaymentCWProxy get copyWith => _$UpdatePaymentCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePayment _$UpdatePaymentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdatePayment', json, ($checkedConvert) {
      final val = UpdatePayment(
        transactionId: $checkedConvert('transactionId', (v) => v as String?),
        provider: $checkedConvert(
          'provider',
          (v) => $enumDecodeNullable(_$PaymentProviderEnumMap, v),
        ),
        method: $checkedConvert(
          'method',
          (v) => $enumDecodeNullable(_$PaymentMethodEnumMap, v),
        ),
        amount: $checkedConvert('amount', (v) => v as num?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecodeNullable(_$TransactionStatusEnumMap, v),
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

Map<String, dynamic> _$UpdatePaymentToJson(UpdatePayment instance) =>
    <String, dynamic>{
      'transactionId': ?instance.transactionId,
      'provider': ?_$PaymentProviderEnumMap[instance.provider],
      'method': ?_$PaymentMethodEnumMap[instance.method],
      'amount': ?instance.amount,
      'status': ?_$TransactionStatusEnumMap[instance.status],
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
