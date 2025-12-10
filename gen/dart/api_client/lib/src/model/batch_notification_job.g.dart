// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_notification_job.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BatchNotificationJobCWProxy {
  BatchNotificationJob type(Object? type);

  BatchNotificationJob meta(QueueMessageMeta meta);

  BatchNotificationJob payload(BatchNotificationJobPayload payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BatchNotificationJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BatchNotificationJob(...).copyWith(id: 12, name: "My name")
  /// ```
  BatchNotificationJob call({
    Object? type,
    QueueMessageMeta meta,
    BatchNotificationJobPayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBatchNotificationJob.copyWith(...)` or call `instanceOfBatchNotificationJob.copyWith.fieldName(value)` for a single field.
class _$BatchNotificationJobCWProxyImpl
    implements _$BatchNotificationJobCWProxy {
  const _$BatchNotificationJobCWProxyImpl(this._value);

  final BatchNotificationJob _value;

  @override
  BatchNotificationJob type(Object? type) => call(type: type);

  @override
  BatchNotificationJob meta(QueueMessageMeta meta) => call(meta: meta);

  @override
  BatchNotificationJob payload(BatchNotificationJobPayload payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BatchNotificationJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BatchNotificationJob(...).copyWith(id: 12, name: "My name")
  /// ```
  BatchNotificationJob call({
    Object? type = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return BatchNotificationJob(
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
          : payload as BatchNotificationJobPayload,
    );
  }
}

extension $BatchNotificationJobCopyWith on BatchNotificationJob {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBatchNotificationJob.copyWith(...)` or `instanceOfBatchNotificationJob.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BatchNotificationJobCWProxy get copyWith =>
      _$BatchNotificationJobCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchNotificationJob _$BatchNotificationJobFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BatchNotificationJob', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['type', 'meta', 'payload']);
  final val = BatchNotificationJob(
    type: $checkedConvert('type', (v) => v),
    meta: $checkedConvert(
      'meta',
      (v) => QueueMessageMeta.fromJson(v as Map<String, dynamic>),
    ),
    payload: $checkedConvert(
      'payload',
      (v) => BatchNotificationJobPayload.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$BatchNotificationJobToJson(
  BatchNotificationJob instance,
) => <String, dynamic>{
  'type': instance.type,
  'meta': instance.meta.toJson(),
  'payload': instance.payload.toJson(),
};
