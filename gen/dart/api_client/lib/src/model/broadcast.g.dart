// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BroadcastCWProxy {
  Broadcast id(String id);

  Broadcast title(String title);

  Broadcast message(String message);

  Broadcast type(BroadcastType type);

  Broadcast status(BroadcastStatus status);

  Broadcast targetAudience(BroadcastTargetAudienceEnum targetAudience);

  Broadcast targetIds(List<String>? targetIds);

  Broadcast scheduledAt(DateTime? scheduledAt);

  Broadcast sentAt(DateTime? sentAt);

  Broadcast completedAt(DateTime? completedAt);

  Broadcast failedCount(num? failedCount);

  Broadcast successCount(num? successCount);

  Broadcast totalCount(num? totalCount);

  Broadcast createdBy(String? createdBy);

  Broadcast createdAt(DateTime? createdAt);

  Broadcast updatedAt(DateTime? updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Broadcast(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Broadcast(...).copyWith(id: 12, name: "My name")
  /// ```
  Broadcast call({
    String id,
    String title,
    String message,
    BroadcastType type,
    BroadcastStatus status,
    BroadcastTargetAudienceEnum targetAudience,
    List<String>? targetIds,
    DateTime? scheduledAt,
    DateTime? sentAt,
    DateTime? completedAt,
    num? failedCount,
    num? successCount,
    num? totalCount,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBroadcast.copyWith(...)` or call `instanceOfBroadcast.copyWith.fieldName(value)` for a single field.
class _$BroadcastCWProxyImpl implements _$BroadcastCWProxy {
  const _$BroadcastCWProxyImpl(this._value);

  final Broadcast _value;

  @override
  Broadcast id(String id) => call(id: id);

  @override
  Broadcast title(String title) => call(title: title);

  @override
  Broadcast message(String message) => call(message: message);

  @override
  Broadcast type(BroadcastType type) => call(type: type);

  @override
  Broadcast status(BroadcastStatus status) => call(status: status);

  @override
  Broadcast targetAudience(BroadcastTargetAudienceEnum targetAudience) =>
      call(targetAudience: targetAudience);

  @override
  Broadcast targetIds(List<String>? targetIds) => call(targetIds: targetIds);

  @override
  Broadcast scheduledAt(DateTime? scheduledAt) =>
      call(scheduledAt: scheduledAt);

  @override
  Broadcast sentAt(DateTime? sentAt) => call(sentAt: sentAt);

  @override
  Broadcast completedAt(DateTime? completedAt) =>
      call(completedAt: completedAt);

  @override
  Broadcast failedCount(num? failedCount) => call(failedCount: failedCount);

  @override
  Broadcast successCount(num? successCount) => call(successCount: successCount);

  @override
  Broadcast totalCount(num? totalCount) => call(totalCount: totalCount);

  @override
  Broadcast createdBy(String? createdBy) => call(createdBy: createdBy);

  @override
  Broadcast createdAt(DateTime? createdAt) => call(createdAt: createdAt);

  @override
  Broadcast updatedAt(DateTime? updatedAt) => call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Broadcast(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Broadcast(...).copyWith(id: 12, name: "My name")
  /// ```
  Broadcast call({
    Object? id = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? targetAudience = const $CopyWithPlaceholder(),
    Object? targetIds = const $CopyWithPlaceholder(),
    Object? scheduledAt = const $CopyWithPlaceholder(),
    Object? sentAt = const $CopyWithPlaceholder(),
    Object? completedAt = const $CopyWithPlaceholder(),
    Object? failedCount = const $CopyWithPlaceholder(),
    Object? successCount = const $CopyWithPlaceholder(),
    Object? totalCount = const $CopyWithPlaceholder(),
    Object? createdBy = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Broadcast(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as BroadcastType,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as BroadcastStatus,
      targetAudience:
          targetAudience == const $CopyWithPlaceholder() ||
              targetAudience == null
          ? _value.targetAudience
          // ignore: cast_nullable_to_non_nullable
          : targetAudience as BroadcastTargetAudienceEnum,
      targetIds: targetIds == const $CopyWithPlaceholder()
          ? _value.targetIds
          // ignore: cast_nullable_to_non_nullable
          : targetIds as List<String>?,
      scheduledAt: scheduledAt == const $CopyWithPlaceholder()
          ? _value.scheduledAt
          // ignore: cast_nullable_to_non_nullable
          : scheduledAt as DateTime?,
      sentAt: sentAt == const $CopyWithPlaceholder()
          ? _value.sentAt
          // ignore: cast_nullable_to_non_nullable
          : sentAt as DateTime?,
      completedAt: completedAt == const $CopyWithPlaceholder()
          ? _value.completedAt
          // ignore: cast_nullable_to_non_nullable
          : completedAt as DateTime?,
      failedCount: failedCount == const $CopyWithPlaceholder()
          ? _value.failedCount
          // ignore: cast_nullable_to_non_nullable
          : failedCount as num?,
      successCount: successCount == const $CopyWithPlaceholder()
          ? _value.successCount
          // ignore: cast_nullable_to_non_nullable
          : successCount as num?,
      totalCount: totalCount == const $CopyWithPlaceholder()
          ? _value.totalCount
          // ignore: cast_nullable_to_non_nullable
          : totalCount as num?,
      createdBy: createdBy == const $CopyWithPlaceholder()
          ? _value.createdBy
          // ignore: cast_nullable_to_non_nullable
          : createdBy as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
    );
  }
}

extension $BroadcastCopyWith on Broadcast {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBroadcast.copyWith(...)` or `instanceOfBroadcast.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BroadcastCWProxy get copyWith => _$BroadcastCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Broadcast _$BroadcastFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Broadcast', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'title',
          'message',
          'type',
          'status',
          'targetAudience',
          'createdAt',
          'updatedAt',
        ],
      );
      final val = Broadcast(
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$BroadcastTypeEnumMap, v),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$BroadcastStatusEnumMap, v),
        ),
        targetAudience: $checkedConvert(
          'targetAudience',
          (v) => $enumDecode(_$BroadcastTargetAudienceEnumEnumMap, v),
        ),
        targetIds: $checkedConvert(
          'targetIds',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        scheduledAt: $checkedConvert(
          'scheduledAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        sentAt: $checkedConvert(
          'sentAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        completedAt: $checkedConvert(
          'completedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        failedCount: $checkedConvert('failedCount', (v) => v as num? ?? 0),
        successCount: $checkedConvert('successCount', (v) => v as num? ?? 0),
        totalCount: $checkedConvert('totalCount', (v) => v as num? ?? 0),
        createdBy: $checkedConvert('createdBy', (v) => v as String?),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BroadcastToJson(Broadcast instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'message': instance.message,
  'type': _$BroadcastTypeEnumMap[instance.type]!,
  'status': _$BroadcastStatusEnumMap[instance.status]!,
  'targetAudience':
      _$BroadcastTargetAudienceEnumEnumMap[instance.targetAudience]!,
  'targetIds': ?instance.targetIds,
  'scheduledAt': ?instance.scheduledAt?.toIso8601String(),
  'sentAt': ?instance.sentAt?.toIso8601String(),
  'completedAt': ?instance.completedAt?.toIso8601String(),
  'failedCount': ?instance.failedCount,
  'successCount': ?instance.successCount,
  'totalCount': ?instance.totalCount,
  'createdBy': ?instance.createdBy,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$BroadcastTypeEnumMap = {
  BroadcastType.EMAIL: 'EMAIL',
  BroadcastType.IN_APP: 'IN_APP',
  BroadcastType.ALL: 'ALL',
};

const _$BroadcastStatusEnumMap = {
  BroadcastStatus.PENDING: 'PENDING',
  BroadcastStatus.SENDING: 'SENDING',
  BroadcastStatus.SENT: 'SENT',
  BroadcastStatus.FAILED: 'FAILED',
};

const _$BroadcastTargetAudienceEnumEnumMap = {
  BroadcastTargetAudienceEnum.ALL: 'ALL',
  BroadcastTargetAudienceEnum.USERS: 'USERS',
  BroadcastTargetAudienceEnum.DRIVERS: 'DRIVERS',
  BroadcastTargetAudienceEnum.MERCHANTS: 'MERCHANTS',
  BroadcastTargetAudienceEnum.ADMINS: 'ADMINS',
  BroadcastTargetAudienceEnum.OPERATORS: 'OPERATORS',
};
