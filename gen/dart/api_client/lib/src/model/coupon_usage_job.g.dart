// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_usage_job.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponUsageJobCWProxy {
  CouponUsageJob type(Object? type);

  CouponUsageJob meta(QueueMessageMeta meta);

  CouponUsageJob payload(CouponUsageJobPayload payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponUsageJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponUsageJob(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponUsageJob call({
    Object? type,
    QueueMessageMeta meta,
    CouponUsageJobPayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCouponUsageJob.copyWith(...)` or call `instanceOfCouponUsageJob.copyWith.fieldName(value)` for a single field.
class _$CouponUsageJobCWProxyImpl implements _$CouponUsageJobCWProxy {
  const _$CouponUsageJobCWProxyImpl(this._value);

  final CouponUsageJob _value;

  @override
  CouponUsageJob type(Object? type) => call(type: type);

  @override
  CouponUsageJob meta(QueueMessageMeta meta) => call(meta: meta);

  @override
  CouponUsageJob payload(CouponUsageJobPayload payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponUsageJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponUsageJob(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponUsageJob call({
    Object? type = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return CouponUsageJob(
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as Object?,
      meta: meta == const $CopyWithPlaceholder() || meta == null
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as QueueMessageMeta,
      payload: payload == const $CopyWithPlaceholder() || payload == null
          ? _value.payload
          // ignore: cast_nullable_to_non_nullable
          : payload as CouponUsageJobPayload,
    );
  }
}

extension $CouponUsageJobCopyWith on CouponUsageJob {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCouponUsageJob.copyWith(...)` or `instanceOfCouponUsageJob.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponUsageJobCWProxy get copyWith => _$CouponUsageJobCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponUsageJob _$CouponUsageJobFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CouponUsageJob', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'meta', 'payload']);
      final val = CouponUsageJob(
        type: $checkedConvert('type', (v) => v),
        meta: $checkedConvert(
          'meta',
          (v) => QueueMessageMeta.fromJson(v as Map<String, dynamic>),
        ),
        payload: $checkedConvert(
          'payload',
          (v) => CouponUsageJobPayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CouponUsageJobToJson(CouponUsageJob instance) =>
    <String, dynamic>{
      'type': instance.type,
      'meta': instance.meta.toJson(),
      'payload': instance.payload.toJson(),
    };
