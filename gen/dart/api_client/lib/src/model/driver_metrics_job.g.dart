// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_metrics_job.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverMetricsJobCWProxy {
  DriverMetricsJob type(Object? type);

  DriverMetricsJob meta(QueueMessageMeta meta);

  DriverMetricsJob payload(DriverMetricsJobPayload payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMetricsJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMetricsJob(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMetricsJob call({
    Object? type,
    QueueMessageMeta meta,
    DriverMetricsJobPayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverMetricsJob.copyWith(...)` or call `instanceOfDriverMetricsJob.copyWith.fieldName(value)` for a single field.
class _$DriverMetricsJobCWProxyImpl implements _$DriverMetricsJobCWProxy {
  const _$DriverMetricsJobCWProxyImpl(this._value);

  final DriverMetricsJob _value;

  @override
  DriverMetricsJob type(Object? type) => call(type: type);

  @override
  DriverMetricsJob meta(QueueMessageMeta meta) => call(meta: meta);

  @override
  DriverMetricsJob payload(DriverMetricsJobPayload payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMetricsJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMetricsJob(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMetricsJob call({
    Object? type = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return DriverMetricsJob(
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
          : payload as DriverMetricsJobPayload,
    );
  }
}

extension $DriverMetricsJobCopyWith on DriverMetricsJob {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverMetricsJob.copyWith(...)` or `instanceOfDriverMetricsJob.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverMetricsJobCWProxy get copyWith => _$DriverMetricsJobCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverMetricsJob _$DriverMetricsJobFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverMetricsJob', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'meta', 'payload']);
      final val = DriverMetricsJob(
        type: $checkedConvert('type', (v) => v),
        meta: $checkedConvert(
          'meta',
          (v) => QueueMessageMeta.fromJson(v as Map<String, dynamic>),
        ),
        payload: $checkedConvert(
          'payload',
          (v) => DriverMetricsJobPayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DriverMetricsJobToJson(DriverMetricsJob instance) =>
    <String, dynamic>{
      'type': instance.type,
      'meta': instance.meta.toJson(),
      'payload': instance.payload.toJson(),
    };
