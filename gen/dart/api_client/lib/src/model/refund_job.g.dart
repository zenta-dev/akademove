// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_job.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RefundJobCWProxy {
  RefundJob type(Object? type);

  RefundJob meta(QueueMessageMeta meta);

  RefundJob payload(RefundJobPayload payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RefundJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RefundJob(...).copyWith(id: 12, name: "My name")
  /// ```
  RefundJob call({
    Object? type,
    QueueMessageMeta meta,
    RefundJobPayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRefundJob.copyWith(...)` or call `instanceOfRefundJob.copyWith.fieldName(value)` for a single field.
class _$RefundJobCWProxyImpl implements _$RefundJobCWProxy {
  const _$RefundJobCWProxyImpl(this._value);

  final RefundJob _value;

  @override
  RefundJob type(Object? type) => call(type: type);

  @override
  RefundJob meta(QueueMessageMeta meta) => call(meta: meta);

  @override
  RefundJob payload(RefundJobPayload payload) => call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RefundJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RefundJob(...).copyWith(id: 12, name: "My name")
  /// ```
  RefundJob call({
    Object? type = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return RefundJob(
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
          : payload as RefundJobPayload,
    );
  }
}

extension $RefundJobCopyWith on RefundJob {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRefundJob.copyWith(...)` or `instanceOfRefundJob.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RefundJobCWProxy get copyWith => _$RefundJobCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundJob _$RefundJobFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RefundJob', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'meta', 'payload']);
      final val = RefundJob(
        type: $checkedConvert('type', (v) => v),
        meta: $checkedConvert(
          'meta',
          (v) => QueueMessageMeta.fromJson(v as Map<String, dynamic>),
        ),
        payload: $checkedConvert(
          'payload',
          (v) => RefundJobPayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RefundJobToJson(RefundJob instance) => <String, dynamic>{
  'type': instance.type,
  'meta': instance.meta.toJson(),
  'payload': instance.payload.toJson(),
};
