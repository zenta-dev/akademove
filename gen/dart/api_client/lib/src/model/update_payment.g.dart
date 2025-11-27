// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_payment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdatePaymentCWProxy {
  UpdatePayment transactionId(String? transactionId);

  UpdatePayment provider(PaymentProvider? provider);

  UpdatePayment method(PaymentMethod? method);

  UpdatePayment bankProvider(BankProvider? bankProvider);

  UpdatePayment amount(num? amount);

  UpdatePayment status(TransactionStatus? status);

  UpdatePayment externalId(String? externalId);

  UpdatePayment paymentUrl(String? paymentUrl);

  UpdatePayment vaNumber(VANumber? vaNumber);

  UpdatePayment metadata(Object? metadata);

  UpdatePayment expiresAt(DateTime? expiresAt);

  UpdatePayment payload(Object? payload);

  UpdatePayment response(Object? response);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdatePayment(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdatePayment(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdatePayment call({
    String? transactionId,
    PaymentProvider? provider,
    PaymentMethod? method,
    BankProvider? bankProvider,
    num? amount,
    TransactionStatus? status,
    String? externalId,
    String? paymentUrl,
    VANumber? vaNumber,
    Object? metadata,
    DateTime? expiresAt,
    Object? payload,
    Object? response,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdatePayment.copyWith(...)` or call `instanceOfUpdatePayment.copyWith.fieldName(value)` for a single field.
class _$UpdatePaymentCWProxyImpl implements _$UpdatePaymentCWProxy {
  const _$UpdatePaymentCWProxyImpl(this._value);

  final UpdatePayment _value;

  @override
  UpdatePayment transactionId(String? transactionId) =>
      call(transactionId: transactionId);

  @override
  UpdatePayment provider(PaymentProvider? provider) => call(provider: provider);

  @override
  UpdatePayment method(PaymentMethod? method) => call(method: method);

  @override
  UpdatePayment bankProvider(BankProvider? bankProvider) =>
      call(bankProvider: bankProvider);

  @override
  UpdatePayment amount(num? amount) => call(amount: amount);

  @override
  UpdatePayment status(TransactionStatus? status) => call(status: status);

  @override
  UpdatePayment externalId(String? externalId) => call(externalId: externalId);

  @override
  UpdatePayment paymentUrl(String? paymentUrl) => call(paymentUrl: paymentUrl);

  @override
  UpdatePayment vaNumber(VANumber? vaNumber) => call(vaNumber: vaNumber);

  @override
  UpdatePayment metadata(Object? metadata) => call(metadata: metadata);

  @override
  UpdatePayment expiresAt(DateTime? expiresAt) => call(expiresAt: expiresAt);

  @override
  UpdatePayment payload(Object? payload) => call(payload: payload);

  @override
  UpdatePayment response(Object? response) => call(response: response);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdatePayment(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdatePayment(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdatePayment call({
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
      bankProvider: bankProvider == const $CopyWithPlaceholder()
          ? _value.bankProvider
          // ignore: cast_nullable_to_non_nullable
          : bankProvider as BankProvider?,
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
    );
  }
}

extension $UpdatePaymentCopyWith on UpdatePayment {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdatePayment.copyWith(...)` or `instanceOfUpdatePayment.copyWith.fieldName(...)`.
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
        bankProvider: $checkedConvert(
          'bankProvider',
          (v) => $enumDecodeNullable(_$BankProviderEnumMap, v),
        ),
        amount: $checkedConvert('amount', (v) => v as num?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecodeNullable(_$TransactionStatusEnumMap, v),
        ),
        externalId: $checkedConvert('externalId', (v) => v as String?),
        paymentUrl: $checkedConvert('paymentUrl', (v) => v as String?),
        vaNumber: $checkedConvert(
          'va_number',
          (v) =>
              v == null ? null : VANumber.fromJson(v as Map<String, dynamic>),
        ),
        metadata: $checkedConvert('metadata', (v) => v),
        expiresAt: $checkedConvert(
          'expiresAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        payload: $checkedConvert('payload', (v) => v),
        response: $checkedConvert('response', (v) => v),
      );
      return val;
    }, fieldKeyMap: const {'vaNumber': 'va_number'});

Map<String, dynamic> _$UpdatePaymentToJson(UpdatePayment instance) =>
    <String, dynamic>{
      'transactionId': ?instance.transactionId,
      'provider': ?_$PaymentProviderEnumMap[instance.provider],
      'method': ?_$PaymentMethodEnumMap[instance.method],
      'bankProvider': ?_$BankProviderEnumMap[instance.bankProvider],
      'amount': ?instance.amount,
      'status': ?_$TransactionStatusEnumMap[instance.status],
      'externalId': ?instance.externalId,
      'paymentUrl': ?instance.paymentUrl,
      'va_number': ?instance.vaNumber?.toJson(),
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
