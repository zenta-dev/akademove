// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_evaluation_job.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeEvaluationJobCWProxy {
  BadgeEvaluationJob type(Object? type);

  BadgeEvaluationJob meta(QueueMessageMeta meta);

  BadgeEvaluationJob payload(BadgeEvaluationJobPayload payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeEvaluationJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeEvaluationJob(...).copyWith(id: 12, name: "My name")
  /// ```
  BadgeEvaluationJob call({
    Object? type,
    QueueMessageMeta meta,
    BadgeEvaluationJobPayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBadgeEvaluationJob.copyWith(...)` or call `instanceOfBadgeEvaluationJob.copyWith.fieldName(value)` for a single field.
class _$BadgeEvaluationJobCWProxyImpl implements _$BadgeEvaluationJobCWProxy {
  const _$BadgeEvaluationJobCWProxyImpl(this._value);

  final BadgeEvaluationJob _value;

  @override
  BadgeEvaluationJob type(Object? type) => call(type: type);

  @override
  BadgeEvaluationJob meta(QueueMessageMeta meta) => call(meta: meta);

  @override
  BadgeEvaluationJob payload(BadgeEvaluationJobPayload payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeEvaluationJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeEvaluationJob(...).copyWith(id: 12, name: "My name")
  /// ```
  BadgeEvaluationJob call({
    Object? type = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return BadgeEvaluationJob(
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
          : payload as BadgeEvaluationJobPayload,
    );
  }
}

extension $BadgeEvaluationJobCopyWith on BadgeEvaluationJob {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBadgeEvaluationJob.copyWith(...)` or `instanceOfBadgeEvaluationJob.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeEvaluationJobCWProxy get copyWith =>
      _$BadgeEvaluationJobCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeEvaluationJob _$BadgeEvaluationJobFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BadgeEvaluationJob', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'meta', 'payload']);
      final val = BadgeEvaluationJob(
        type: $checkedConvert('type', (v) => v),
        meta: $checkedConvert(
          'meta',
          (v) => QueueMessageMeta.fromJson(v as Map<String, dynamic>),
        ),
        payload: $checkedConvert(
          'payload',
          (v) => BadgeEvaluationJobPayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BadgeEvaluationJobToJson(BadgeEvaluationJob instance) =>
    <String, dynamic>{
      'type': instance.type,
      'meta': instance.meta.toJson(),
      'payload': instance.payload.toJson(),
    };
