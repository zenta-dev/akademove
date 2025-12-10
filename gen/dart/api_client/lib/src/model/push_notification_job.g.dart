// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_job.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PushNotificationJobCWProxy {
  PushNotificationJob type(Object? type);

  PushNotificationJob meta(QueueMessageMeta meta);

  PushNotificationJob payload(PushNotificationJobPayload payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJob(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJob call({
    Object? type,
    QueueMessageMeta meta,
    PushNotificationJobPayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPushNotificationJob.copyWith(...)` or call `instanceOfPushNotificationJob.copyWith.fieldName(value)` for a single field.
class _$PushNotificationJobCWProxyImpl implements _$PushNotificationJobCWProxy {
  const _$PushNotificationJobCWProxyImpl(this._value);

  final PushNotificationJob _value;

  @override
  PushNotificationJob type(Object? type) => call(type: type);

  @override
  PushNotificationJob meta(QueueMessageMeta meta) => call(meta: meta);

  @override
  PushNotificationJob payload(PushNotificationJobPayload payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJob(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJob call({
    Object? type = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return PushNotificationJob(
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
          : payload as PushNotificationJobPayload,
    );
  }
}

extension $PushNotificationJobCopyWith on PushNotificationJob {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPushNotificationJob.copyWith(...)` or `instanceOfPushNotificationJob.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PushNotificationJobCWProxy get copyWith =>
      _$PushNotificationJobCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationJob _$PushNotificationJobFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PushNotificationJob', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'meta', 'payload']);
      final val = PushNotificationJob(
        type: $checkedConvert('type', (v) => v),
        meta: $checkedConvert(
          'meta',
          (v) => QueueMessageMeta.fromJson(v as Map<String, dynamic>),
        ),
        payload: $checkedConvert(
          'payload',
          (v) => PushNotificationJobPayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PushNotificationJobToJson(
  PushNotificationJob instance,
) => <String, dynamic>{
  'type': instance.type,
  'meta': instance.meta.toJson(),
  'payload': instance.payload.toJson(),
};
