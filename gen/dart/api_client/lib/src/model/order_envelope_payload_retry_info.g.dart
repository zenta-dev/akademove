// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_envelope_payload_retry_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEnvelopePayloadRetryInfoCWProxy {
  OrderEnvelopePayloadRetryInfo orderId(String orderId);

  OrderEnvelopePayloadRetryInfo cancelledDriverId(String cancelledDriverId);

  OrderEnvelopePayloadRetryInfo excludedDriverCount(num excludedDriverCount);

  OrderEnvelopePayloadRetryInfo reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadRetryInfo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadRetryInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadRetryInfo call({
    String orderId,
    String cancelledDriverId,
    num excludedDriverCount,
    String? reason,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEnvelopePayloadRetryInfo.copyWith(...)` or call `instanceOfOrderEnvelopePayloadRetryInfo.copyWith.fieldName(value)` for a single field.
class _$OrderEnvelopePayloadRetryInfoCWProxyImpl
    implements _$OrderEnvelopePayloadRetryInfoCWProxy {
  const _$OrderEnvelopePayloadRetryInfoCWProxyImpl(this._value);

  final OrderEnvelopePayloadRetryInfo _value;

  @override
  OrderEnvelopePayloadRetryInfo orderId(String orderId) =>
      call(orderId: orderId);

  @override
  OrderEnvelopePayloadRetryInfo cancelledDriverId(String cancelledDriverId) =>
      call(cancelledDriverId: cancelledDriverId);

  @override
  OrderEnvelopePayloadRetryInfo excludedDriverCount(num excludedDriverCount) =>
      call(excludedDriverCount: excludedDriverCount);

  @override
  OrderEnvelopePayloadRetryInfo reason(String? reason) => call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadRetryInfo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadRetryInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadRetryInfo call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? cancelledDriverId = const $CopyWithPlaceholder(),
    Object? excludedDriverCount = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return OrderEnvelopePayloadRetryInfo(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      cancelledDriverId:
          cancelledDriverId == const $CopyWithPlaceholder() ||
              cancelledDriverId == null
          ? _value.cancelledDriverId
          // ignore: cast_nullable_to_non_nullable
          : cancelledDriverId as String,
      excludedDriverCount:
          excludedDriverCount == const $CopyWithPlaceholder() ||
              excludedDriverCount == null
          ? _value.excludedDriverCount
          // ignore: cast_nullable_to_non_nullable
          : excludedDriverCount as num,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $OrderEnvelopePayloadRetryInfoCopyWith
    on OrderEnvelopePayloadRetryInfo {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEnvelopePayloadRetryInfo.copyWith(...)` or `instanceOfOrderEnvelopePayloadRetryInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEnvelopePayloadRetryInfoCWProxy get copyWith =>
      _$OrderEnvelopePayloadRetryInfoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEnvelopePayloadRetryInfo _$OrderEnvelopePayloadRetryInfoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderEnvelopePayloadRetryInfo', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['orderId', 'cancelledDriverId', 'excludedDriverCount'],
  );
  final val = OrderEnvelopePayloadRetryInfo(
    orderId: $checkedConvert('orderId', (v) => v as String),
    cancelledDriverId: $checkedConvert('cancelledDriverId', (v) => v as String),
    excludedDriverCount: $checkedConvert(
      'excludedDriverCount',
      (v) => v as num,
    ),
    reason: $checkedConvert('reason', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$OrderEnvelopePayloadRetryInfoToJson(
  OrderEnvelopePayloadRetryInfo instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'cancelledDriverId': instance.cancelledDriverId,
  'excludedDriverCount': instance.excludedDriverCount,
  'reason': ?instance.reason,
};
