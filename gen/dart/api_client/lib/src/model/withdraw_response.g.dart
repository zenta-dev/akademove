// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WithdrawResponseCWProxy {
  WithdrawResponse id(String id);

  WithdrawResponse transactionId(String transactionId);

  WithdrawResponse provider(PaymentProvider provider);

  WithdrawResponse method(PaymentMethod method);

  WithdrawResponse amount(num amount);

  WithdrawResponse status(TransactionStatus status);

  WithdrawResponse bankProvider(BankProvider bankProvider);

  WithdrawResponse payoutReferenceNo(String? payoutReferenceNo);

  WithdrawResponse payoutStatus(PayoutStatus? payoutStatus);

  WithdrawResponse metadata(Map<String, Object>? metadata);

  WithdrawResponse createdAt(DateTime? createdAt);

  WithdrawResponse updatedAt(DateTime? updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WithdrawResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WithdrawResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  WithdrawResponse call({
    String id,
    String transactionId,
    PaymentProvider provider,
    PaymentMethod method,
    num amount,
    TransactionStatus status,
    BankProvider bankProvider,
    String? payoutReferenceNo,
    PayoutStatus? payoutStatus,
    Map<String, Object>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWithdrawResponse.copyWith(...)` or call `instanceOfWithdrawResponse.copyWith.fieldName(value)` for a single field.
class _$WithdrawResponseCWProxyImpl implements _$WithdrawResponseCWProxy {
  const _$WithdrawResponseCWProxyImpl(this._value);

  final WithdrawResponse _value;

  @override
  WithdrawResponse id(String id) => call(id: id);

  @override
  WithdrawResponse transactionId(String transactionId) =>
      call(transactionId: transactionId);

  @override
  WithdrawResponse provider(PaymentProvider provider) =>
      call(provider: provider);

  @override
  WithdrawResponse method(PaymentMethod method) => call(method: method);

  @override
  WithdrawResponse amount(num amount) => call(amount: amount);

  @override
  WithdrawResponse status(TransactionStatus status) => call(status: status);

  @override
  WithdrawResponse bankProvider(BankProvider bankProvider) =>
      call(bankProvider: bankProvider);

  @override
  WithdrawResponse payoutReferenceNo(String? payoutReferenceNo) =>
      call(payoutReferenceNo: payoutReferenceNo);

  @override
  WithdrawResponse payoutStatus(PayoutStatus? payoutStatus) =>
      call(payoutStatus: payoutStatus);

  @override
  WithdrawResponse metadata(Map<String, Object>? metadata) =>
      call(metadata: metadata);

  @override
  WithdrawResponse createdAt(DateTime? createdAt) => call(createdAt: createdAt);

  @override
  WithdrawResponse updatedAt(DateTime? updatedAt) => call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WithdrawResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WithdrawResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  WithdrawResponse call({
    Object? id = const $CopyWithPlaceholder(),
    Object? transactionId = const $CopyWithPlaceholder(),
    Object? provider = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? bankProvider = const $CopyWithPlaceholder(),
    Object? payoutReferenceNo = const $CopyWithPlaceholder(),
    Object? payoutStatus = const $CopyWithPlaceholder(),
    Object? metadata = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return WithdrawResponse(
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
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as TransactionStatus,
      bankProvider:
          bankProvider == const $CopyWithPlaceholder() || bankProvider == null
          ? _value.bankProvider
          // ignore: cast_nullable_to_non_nullable
          : bankProvider as BankProvider,
      payoutReferenceNo: payoutReferenceNo == const $CopyWithPlaceholder()
          ? _value.payoutReferenceNo
          // ignore: cast_nullable_to_non_nullable
          : payoutReferenceNo as String?,
      payoutStatus: payoutStatus == const $CopyWithPlaceholder()
          ? _value.payoutStatus
          // ignore: cast_nullable_to_non_nullable
          : payoutStatus as PayoutStatus?,
      metadata: metadata == const $CopyWithPlaceholder()
          ? _value.metadata
          // ignore: cast_nullable_to_non_nullable
          : metadata as Map<String, Object>?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
    );
  }
}

extension $WithdrawResponseCopyWith on WithdrawResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWithdrawResponse.copyWith(...)` or `instanceOfWithdrawResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WithdrawResponseCWProxy get copyWith => _$WithdrawResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawResponse _$WithdrawResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WithdrawResponse', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'transactionId',
          'provider',
          'method',
          'amount',
          'status',
          'bankProvider',
          'createdAt',
          'updatedAt',
        ],
      );
      final val = WithdrawResponse(
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
        bankProvider: $checkedConvert(
          'bankProvider',
          (v) => $enumDecode(_$BankProviderEnumMap, v),
        ),
        payoutReferenceNo: $checkedConvert(
          'payoutReferenceNo',
          (v) => v as String?,
        ),
        payoutStatus: $checkedConvert(
          'payoutStatus',
          (v) => $enumDecodeNullable(_$PayoutStatusEnumMap, v),
        ),
        metadata: $checkedConvert(
          'metadata',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as Object),
          ),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$WithdrawResponseToJson(WithdrawResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionId': instance.transactionId,
      'provider': _$PaymentProviderEnumMap[instance.provider]!,
      'method': _$PaymentMethodEnumMap[instance.method]!,
      'amount': instance.amount,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'bankProvider': _$BankProviderEnumMap[instance.bankProvider]!,
      'payoutReferenceNo': ?instance.payoutReferenceNo,
      'payoutStatus': ?_$PayoutStatusEnumMap[instance.payoutStatus],
      'metadata': ?instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$PaymentProviderEnumMap = {
  PaymentProvider.MIDTRANS: 'MIDTRANS',
  PaymentProvider.MANUAL: 'MANUAL',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.QRIS: 'QRIS',
  PaymentMethod.BANK_TRANSFER: 'BANK_TRANSFER',
  PaymentMethod.wallet: 'wallet',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.PENDING: 'PENDING',
  TransactionStatus.SUCCESS: 'SUCCESS',
  TransactionStatus.FAILED: 'FAILED',
  TransactionStatus.CANCELLED: 'CANCELLED',
  TransactionStatus.EXPIRED: 'EXPIRED',
  TransactionStatus.REFUNDED: 'REFUNDED',
};

const _$BankProviderEnumMap = {
  BankProvider.BCA: 'BCA',
  BankProvider.BNI: 'BNI',
  BankProvider.BRI: 'BRI',
  BankProvider.MANDIRI: 'MANDIRI',
  BankProvider.PERMATA: 'PERMATA',
};

const _$PayoutStatusEnumMap = {
  PayoutStatus.queued: 'queued',
  PayoutStatus.processed: 'processed',
  PayoutStatus.completed: 'completed',
  PayoutStatus.failed: 'failed',
};
