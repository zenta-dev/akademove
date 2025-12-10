// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_job_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RefundJobPayloadCWProxy {
  RefundJobPayload orderId(String orderId);

  RefundJobPayload userId(String userId);

  RefundJobPayload walletId(String walletId);

  RefundJobPayload paymentId(String paymentId);

  RefundJobPayload transactionId(String transactionId);

  RefundJobPayload refundAmount(num refundAmount);

  RefundJobPayload penaltyAmount(num? penaltyAmount);

  RefundJobPayload reason(String reason);

  RefundJobPayload refundType(RefundJobPayloadRefundTypeEnum refundType);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RefundJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RefundJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  RefundJobPayload call({
    String orderId,
    String userId,
    String walletId,
    String paymentId,
    String transactionId,
    num refundAmount,
    num? penaltyAmount,
    String reason,
    RefundJobPayloadRefundTypeEnum refundType,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRefundJobPayload.copyWith(...)` or call `instanceOfRefundJobPayload.copyWith.fieldName(value)` for a single field.
class _$RefundJobPayloadCWProxyImpl implements _$RefundJobPayloadCWProxy {
  const _$RefundJobPayloadCWProxyImpl(this._value);

  final RefundJobPayload _value;

  @override
  RefundJobPayload orderId(String orderId) => call(orderId: orderId);

  @override
  RefundJobPayload userId(String userId) => call(userId: userId);

  @override
  RefundJobPayload walletId(String walletId) => call(walletId: walletId);

  @override
  RefundJobPayload paymentId(String paymentId) => call(paymentId: paymentId);

  @override
  RefundJobPayload transactionId(String transactionId) =>
      call(transactionId: transactionId);

  @override
  RefundJobPayload refundAmount(num refundAmount) =>
      call(refundAmount: refundAmount);

  @override
  RefundJobPayload penaltyAmount(num? penaltyAmount) =>
      call(penaltyAmount: penaltyAmount);

  @override
  RefundJobPayload reason(String reason) => call(reason: reason);

  @override
  RefundJobPayload refundType(RefundJobPayloadRefundTypeEnum refundType) =>
      call(refundType: refundType);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RefundJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RefundJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  RefundJobPayload call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? walletId = const $CopyWithPlaceholder(),
    Object? paymentId = const $CopyWithPlaceholder(),
    Object? transactionId = const $CopyWithPlaceholder(),
    Object? refundAmount = const $CopyWithPlaceholder(),
    Object? penaltyAmount = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? refundType = const $CopyWithPlaceholder(),
  }) {
    return RefundJobPayload(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      walletId: walletId == const $CopyWithPlaceholder() || walletId == null
          ? _value.walletId
          // ignore: cast_nullable_to_non_nullable
          : walletId as String,
      paymentId: paymentId == const $CopyWithPlaceholder() || paymentId == null
          ? _value.paymentId
          // ignore: cast_nullable_to_non_nullable
          : paymentId as String,
      transactionId:
          transactionId == const $CopyWithPlaceholder() || transactionId == null
          ? _value.transactionId
          // ignore: cast_nullable_to_non_nullable
          : transactionId as String,
      refundAmount:
          refundAmount == const $CopyWithPlaceholder() || refundAmount == null
          ? _value.refundAmount
          // ignore: cast_nullable_to_non_nullable
          : refundAmount as num,
      penaltyAmount: penaltyAmount == const $CopyWithPlaceholder()
          ? _value.penaltyAmount
          // ignore: cast_nullable_to_non_nullable
          : penaltyAmount as num?,
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      refundType:
          refundType == const $CopyWithPlaceholder() || refundType == null
          ? _value.refundType
          // ignore: cast_nullable_to_non_nullable
          : refundType as RefundJobPayloadRefundTypeEnum,
    );
  }
}

extension $RefundJobPayloadCopyWith on RefundJobPayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRefundJobPayload.copyWith(...)` or `instanceOfRefundJobPayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RefundJobPayloadCWProxy get copyWith => _$RefundJobPayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundJobPayload _$RefundJobPayloadFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RefundJobPayload', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'orderId',
          'userId',
          'walletId',
          'paymentId',
          'transactionId',
          'refundAmount',
          'reason',
          'refundType',
        ],
      );
      final val = RefundJobPayload(
        orderId: $checkedConvert('orderId', (v) => v as String),
        userId: $checkedConvert('userId', (v) => v as String),
        walletId: $checkedConvert('walletId', (v) => v as String),
        paymentId: $checkedConvert('paymentId', (v) => v as String),
        transactionId: $checkedConvert('transactionId', (v) => v as String),
        refundAmount: $checkedConvert('refundAmount', (v) => v as num),
        penaltyAmount: $checkedConvert('penaltyAmount', (v) => v as num? ?? 0),
        reason: $checkedConvert('reason', (v) => v as String),
        refundType: $checkedConvert(
          'refundType',
          (v) => $enumDecode(_$RefundJobPayloadRefundTypeEnumEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RefundJobPayloadToJson(
  RefundJobPayload instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'userId': instance.userId,
  'walletId': instance.walletId,
  'paymentId': instance.paymentId,
  'transactionId': instance.transactionId,
  'refundAmount': instance.refundAmount,
  'penaltyAmount': ?instance.penaltyAmount,
  'reason': instance.reason,
  'refundType': _$RefundJobPayloadRefundTypeEnumEnumMap[instance.refundType]!,
};

const _$RefundJobPayloadRefundTypeEnumEnumMap = {
  RefundJobPayloadRefundTypeEnum.FULL_REFUND: 'FULL_REFUND',
  RefundJobPayloadRefundTypeEnum.PARTIAL_REFUND: 'PARTIAL_REFUND',
  RefundJobPayloadRefundTypeEnum.NO_SHOW_REFUND: 'NO_SHOW_REFUND',
  RefundJobPayloadRefundTypeEnum.SYSTEM_CANCEL_REFUND: 'SYSTEM_CANCEL_REFUND',
  RefundJobPayloadRefundTypeEnum.USER_CANCEL_REFUND: 'USER_CANCEL_REFUND',
  RefundJobPayloadRefundTypeEnum.DRIVER_CANCEL_REFUND: 'DRIVER_CANCEL_REFUND',
};
