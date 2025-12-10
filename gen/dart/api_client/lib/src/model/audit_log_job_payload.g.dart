// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_job_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuditLogJobPayloadCWProxy {
  AuditLogJobPayload action(String action);

  AuditLogJobPayload entityType(String entityType);

  AuditLogJobPayload entityId(String entityId);

  AuditLogJobPayload actorId(String actorId);

  AuditLogJobPayload actorRole(String actorRole);

  AuditLogJobPayload changes(Map<String, Object>? changes);

  AuditLogJobPayload ipAddress(String? ipAddress);

  AuditLogJobPayload userAgent(String? userAgent);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuditLogJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuditLogJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  AuditLogJobPayload call({
    String action,
    String entityType,
    String entityId,
    String actorId,
    String actorRole,
    Map<String, Object>? changes,
    String? ipAddress,
    String? userAgent,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuditLogJobPayload.copyWith(...)` or call `instanceOfAuditLogJobPayload.copyWith.fieldName(value)` for a single field.
class _$AuditLogJobPayloadCWProxyImpl implements _$AuditLogJobPayloadCWProxy {
  const _$AuditLogJobPayloadCWProxyImpl(this._value);

  final AuditLogJobPayload _value;

  @override
  AuditLogJobPayload action(String action) => call(action: action);

  @override
  AuditLogJobPayload entityType(String entityType) =>
      call(entityType: entityType);

  @override
  AuditLogJobPayload entityId(String entityId) => call(entityId: entityId);

  @override
  AuditLogJobPayload actorId(String actorId) => call(actorId: actorId);

  @override
  AuditLogJobPayload actorRole(String actorRole) => call(actorRole: actorRole);

  @override
  AuditLogJobPayload changes(Map<String, Object>? changes) =>
      call(changes: changes);

  @override
  AuditLogJobPayload ipAddress(String? ipAddress) => call(ipAddress: ipAddress);

  @override
  AuditLogJobPayload userAgent(String? userAgent) => call(userAgent: userAgent);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuditLogJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuditLogJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  AuditLogJobPayload call({
    Object? action = const $CopyWithPlaceholder(),
    Object? entityType = const $CopyWithPlaceholder(),
    Object? entityId = const $CopyWithPlaceholder(),
    Object? actorId = const $CopyWithPlaceholder(),
    Object? actorRole = const $CopyWithPlaceholder(),
    Object? changes = const $CopyWithPlaceholder(),
    Object? ipAddress = const $CopyWithPlaceholder(),
    Object? userAgent = const $CopyWithPlaceholder(),
  }) {
    return AuditLogJobPayload(
      action: action == const $CopyWithPlaceholder() || action == null
          ? _value.action
          // ignore: cast_nullable_to_non_nullable
          : action as String,
      entityType:
          entityType == const $CopyWithPlaceholder() || entityType == null
          ? _value.entityType
          // ignore: cast_nullable_to_non_nullable
          : entityType as String,
      entityId: entityId == const $CopyWithPlaceholder() || entityId == null
          ? _value.entityId
          // ignore: cast_nullable_to_non_nullable
          : entityId as String,
      actorId: actorId == const $CopyWithPlaceholder() || actorId == null
          ? _value.actorId
          // ignore: cast_nullable_to_non_nullable
          : actorId as String,
      actorRole: actorRole == const $CopyWithPlaceholder() || actorRole == null
          ? _value.actorRole
          // ignore: cast_nullable_to_non_nullable
          : actorRole as String,
      changes: changes == const $CopyWithPlaceholder()
          ? _value.changes
          // ignore: cast_nullable_to_non_nullable
          : changes as Map<String, Object>?,
      ipAddress: ipAddress == const $CopyWithPlaceholder()
          ? _value.ipAddress
          // ignore: cast_nullable_to_non_nullable
          : ipAddress as String?,
      userAgent: userAgent == const $CopyWithPlaceholder()
          ? _value.userAgent
          // ignore: cast_nullable_to_non_nullable
          : userAgent as String?,
    );
  }
}

extension $AuditLogJobPayloadCopyWith on AuditLogJobPayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuditLogJobPayload.copyWith(...)` or `instanceOfAuditLogJobPayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuditLogJobPayloadCWProxy get copyWith =>
      _$AuditLogJobPayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditLogJobPayload _$AuditLogJobPayloadFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuditLogJobPayload', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'action',
          'entityType',
          'entityId',
          'actorId',
          'actorRole',
        ],
      );
      final val = AuditLogJobPayload(
        action: $checkedConvert('action', (v) => v as String),
        entityType: $checkedConvert('entityType', (v) => v as String),
        entityId: $checkedConvert('entityId', (v) => v as String),
        actorId: $checkedConvert('actorId', (v) => v as String),
        actorRole: $checkedConvert('actorRole', (v) => v as String),
        changes: $checkedConvert(
          'changes',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as Object),
          ),
        ),
        ipAddress: $checkedConvert('ipAddress', (v) => v as String?),
        userAgent: $checkedConvert('userAgent', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$AuditLogJobPayloadToJson(AuditLogJobPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'entityType': instance.entityType,
      'entityId': instance.entityId,
      'actorId': instance.actorId,
      'actorRole': instance.actorRole,
      'changes': ?instance.changes,
      'ipAddress': ?instance.ipAddress,
      'userAgent': ?instance.userAgent,
    };
