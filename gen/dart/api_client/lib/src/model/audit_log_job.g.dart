// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_job.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuditLogJobCWProxy {
  AuditLogJob type(Object? type);

  AuditLogJob meta(QueueMessageMeta meta);

  AuditLogJob payload(AuditLogJobPayload payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuditLogJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuditLogJob(...).copyWith(id: 12, name: "My name")
  /// ```
  AuditLogJob call({
    Object? type,
    QueueMessageMeta meta,
    AuditLogJobPayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuditLogJob.copyWith(...)` or call `instanceOfAuditLogJob.copyWith.fieldName(value)` for a single field.
class _$AuditLogJobCWProxyImpl implements _$AuditLogJobCWProxy {
  const _$AuditLogJobCWProxyImpl(this._value);

  final AuditLogJob _value;

  @override
  AuditLogJob type(Object? type) => call(type: type);

  @override
  AuditLogJob meta(QueueMessageMeta meta) => call(meta: meta);

  @override
  AuditLogJob payload(AuditLogJobPayload payload) => call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuditLogJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuditLogJob(...).copyWith(id: 12, name: "My name")
  /// ```
  AuditLogJob call({
    Object? type = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return AuditLogJob(
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
          : payload as AuditLogJobPayload,
    );
  }
}

extension $AuditLogJobCopyWith on AuditLogJob {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuditLogJob.copyWith(...)` or `instanceOfAuditLogJob.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuditLogJobCWProxy get copyWith => _$AuditLogJobCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditLogJob _$AuditLogJobFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuditLogJob', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'meta', 'payload']);
      final val = AuditLogJob(
        type: $checkedConvert('type', (v) => v),
        meta: $checkedConvert(
          'meta',
          (v) => QueueMessageMeta.fromJson(v as Map<String, dynamic>),
        ),
        payload: $checkedConvert(
          'payload',
          (v) => AuditLogJobPayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AuditLogJobToJson(AuditLogJob instance) =>
    <String, dynamic>{
      'type': instance.type,
      'meta': instance.meta.toJson(),
      'payload': instance.payload.toJson(),
    };
