// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_matching_job.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverMatchingJobCWProxy {
  DriverMatchingJob type(Object? type);

  DriverMatchingJob meta(QueueMessageMeta meta);

  DriverMatchingJob payload(DriverMatchingJobPayload payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMatchingJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMatchingJob(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMatchingJob call({
    Object? type,
    QueueMessageMeta meta,
    DriverMatchingJobPayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverMatchingJob.copyWith(...)` or call `instanceOfDriverMatchingJob.copyWith.fieldName(value)` for a single field.
class _$DriverMatchingJobCWProxyImpl implements _$DriverMatchingJobCWProxy {
  const _$DriverMatchingJobCWProxyImpl(this._value);

  final DriverMatchingJob _value;

  @override
  DriverMatchingJob type(Object? type) => call(type: type);

  @override
  DriverMatchingJob meta(QueueMessageMeta meta) => call(meta: meta);

  @override
  DriverMatchingJob payload(DriverMatchingJobPayload payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMatchingJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMatchingJob(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMatchingJob call({
    Object? type = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return DriverMatchingJob(
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
          : payload as DriverMatchingJobPayload,
    );
  }
}

extension $DriverMatchingJobCopyWith on DriverMatchingJob {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverMatchingJob.copyWith(...)` or `instanceOfDriverMatchingJob.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverMatchingJobCWProxy get copyWith =>
      _$DriverMatchingJobCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverMatchingJob _$DriverMatchingJobFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverMatchingJob', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'meta', 'payload']);
      final val = DriverMatchingJob(
        type: $checkedConvert('type', (v) => v),
        meta: $checkedConvert(
          'meta',
          (v) => QueueMessageMeta.fromJson(v as Map<String, dynamic>),
        ),
        payload: $checkedConvert(
          'payload',
          (v) => DriverMatchingJobPayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DriverMatchingJobToJson(DriverMatchingJob instance) =>
    <String, dynamic>{
      'type': instance.type,
      'meta': instance.meta.toJson(),
      'payload': instance.payload.toJson(),
    };
