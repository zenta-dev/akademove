// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_create201_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BroadcastCreate201ResponseDataCWProxy {
  BroadcastCreate201ResponseData id(String id);

  BroadcastCreate201ResponseData title(String title);

  BroadcastCreate201ResponseData message(String message);

  BroadcastCreate201ResponseData type(
    BroadcastCreate201ResponseDataTypeEnum type,
  );

  BroadcastCreate201ResponseData status(
    BroadcastCreate201ResponseDataStatusEnum status,
  );

  BroadcastCreate201ResponseData targetAudience(
    BroadcastCreate201ResponseDataTargetAudienceEnum targetAudience,
  );

  BroadcastCreate201ResponseData targetIds(List<String>? targetIds);

  BroadcastCreate201ResponseData scheduledAt(DateTime? scheduledAt);

  BroadcastCreate201ResponseData sentAt(DateTime? sentAt);

  BroadcastCreate201ResponseData totalRecipients(int? totalRecipients);

  BroadcastCreate201ResponseData sentCount(int? sentCount);

  BroadcastCreate201ResponseData failedCount(int? failedCount);

  BroadcastCreate201ResponseData createdBy(String createdBy);

  BroadcastCreate201ResponseData createdAt(DateTime createdAt);

  BroadcastCreate201ResponseData updatedAt(DateTime updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastCreate201ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastCreate201ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastCreate201ResponseData call({
    String id,
    String title,
    String message,
    BroadcastCreate201ResponseDataTypeEnum type,
    BroadcastCreate201ResponseDataStatusEnum status,
    BroadcastCreate201ResponseDataTargetAudienceEnum targetAudience,
    List<String>? targetIds,
    DateTime? scheduledAt,
    DateTime? sentAt,
    int? totalRecipients,
    int? sentCount,
    int? failedCount,
    String createdBy,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBroadcastCreate201ResponseData.copyWith(...)` or call `instanceOfBroadcastCreate201ResponseData.copyWith.fieldName(value)` for a single field.
class _$BroadcastCreate201ResponseDataCWProxyImpl
    implements _$BroadcastCreate201ResponseDataCWProxy {
  const _$BroadcastCreate201ResponseDataCWProxyImpl(this._value);

  final BroadcastCreate201ResponseData _value;

  @override
  BroadcastCreate201ResponseData id(String id) => call(id: id);

  @override
  BroadcastCreate201ResponseData title(String title) => call(title: title);

  @override
  BroadcastCreate201ResponseData message(String message) =>
      call(message: message);

  @override
  BroadcastCreate201ResponseData type(
    BroadcastCreate201ResponseDataTypeEnum type,
  ) => call(type: type);

  @override
  BroadcastCreate201ResponseData status(
    BroadcastCreate201ResponseDataStatusEnum status,
  ) => call(status: status);

  @override
  BroadcastCreate201ResponseData targetAudience(
    BroadcastCreate201ResponseDataTargetAudienceEnum targetAudience,
  ) => call(targetAudience: targetAudience);

  @override
  BroadcastCreate201ResponseData targetIds(List<String>? targetIds) =>
      call(targetIds: targetIds);

  @override
  BroadcastCreate201ResponseData scheduledAt(DateTime? scheduledAt) =>
      call(scheduledAt: scheduledAt);

  @override
  BroadcastCreate201ResponseData sentAt(DateTime? sentAt) =>
      call(sentAt: sentAt);

  @override
  BroadcastCreate201ResponseData totalRecipients(int? totalRecipients) =>
      call(totalRecipients: totalRecipients);

  @override
  BroadcastCreate201ResponseData sentCount(int? sentCount) =>
      call(sentCount: sentCount);

  @override
  BroadcastCreate201ResponseData failedCount(int? failedCount) =>
      call(failedCount: failedCount);

  @override
  BroadcastCreate201ResponseData createdBy(String createdBy) =>
      call(createdBy: createdBy);

  @override
  BroadcastCreate201ResponseData createdAt(DateTime createdAt) =>
      call(createdAt: createdAt);

  @override
  BroadcastCreate201ResponseData updatedAt(DateTime updatedAt) =>
      call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastCreate201ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastCreate201ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastCreate201ResponseData call({
    Object? id = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? targetAudience = const $CopyWithPlaceholder(),
    Object? targetIds = const $CopyWithPlaceholder(),
    Object? scheduledAt = const $CopyWithPlaceholder(),
    Object? sentAt = const $CopyWithPlaceholder(),
    Object? totalRecipients = const $CopyWithPlaceholder(),
    Object? sentCount = const $CopyWithPlaceholder(),
    Object? failedCount = const $CopyWithPlaceholder(),
    Object? createdBy = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return BroadcastCreate201ResponseData(
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
          : type as BroadcastCreate201ResponseDataTypeEnum,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as BroadcastCreate201ResponseDataStatusEnum,
      targetAudience:
          targetAudience == const $CopyWithPlaceholder() ||
              targetAudience == null
          ? _value.targetAudience
          // ignore: cast_nullable_to_non_nullable
          : targetAudience as BroadcastCreate201ResponseDataTargetAudienceEnum,
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
      totalRecipients: totalRecipients == const $CopyWithPlaceholder()
          ? _value.totalRecipients
          // ignore: cast_nullable_to_non_nullable
          : totalRecipients as int?,
      sentCount: sentCount == const $CopyWithPlaceholder()
          ? _value.sentCount
          // ignore: cast_nullable_to_non_nullable
          : sentCount as int?,
      failedCount: failedCount == const $CopyWithPlaceholder()
          ? _value.failedCount
          // ignore: cast_nullable_to_non_nullable
          : failedCount as int?,
      createdBy: createdBy == const $CopyWithPlaceholder() || createdBy == null
          ? _value.createdBy
          // ignore: cast_nullable_to_non_nullable
          : createdBy as String,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $BroadcastCreate201ResponseDataCopyWith
    on BroadcastCreate201ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBroadcastCreate201ResponseData.copyWith(...)` or `instanceOfBroadcastCreate201ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BroadcastCreate201ResponseDataCWProxy get copyWith =>
      _$BroadcastCreate201ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BroadcastCreate201ResponseData _$BroadcastCreate201ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BroadcastCreate201ResponseData', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'title',
      'message',
      'type',
      'status',
      'targetAudience',
      'createdBy',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = BroadcastCreate201ResponseData(
    id: $checkedConvert('id', (v) => v as String),
    title: $checkedConvert('title', (v) => v as String),
    message: $checkedConvert('message', (v) => v as String),
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$BroadcastCreate201ResponseDataTypeEnumEnumMap, v),
    ),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$BroadcastCreate201ResponseDataStatusEnumEnumMap, v),
    ),
    targetAudience: $checkedConvert(
      'targetAudience',
      (v) => $enumDecode(
        _$BroadcastCreate201ResponseDataTargetAudienceEnumEnumMap,
        v,
      ),
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
    totalRecipients: $checkedConvert(
      'totalRecipients',
      (v) => (v as num?)?.toInt() ?? 0,
    ),
    sentCount: $checkedConvert('sentCount', (v) => (v as num?)?.toInt() ?? 0),
    failedCount: $checkedConvert(
      'failedCount',
      (v) => (v as num?)?.toInt() ?? 0,
    ),
    createdBy: $checkedConvert('createdBy', (v) => v as String),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$BroadcastCreate201ResponseDataToJson(
  BroadcastCreate201ResponseData instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'message': instance.message,
  'type': _$BroadcastCreate201ResponseDataTypeEnumEnumMap[instance.type]!,
  'status': _$BroadcastCreate201ResponseDataStatusEnumEnumMap[instance.status]!,
  'targetAudience':
      _$BroadcastCreate201ResponseDataTargetAudienceEnumEnumMap[instance
          .targetAudience]!,
  'targetIds': ?instance.targetIds,
  'scheduledAt': ?instance.scheduledAt?.toIso8601String(),
  'sentAt': ?instance.sentAt?.toIso8601String(),
  'totalRecipients': ?instance.totalRecipients,
  'sentCount': ?instance.sentCount,
  'failedCount': ?instance.failedCount,
  'createdBy': instance.createdBy,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$BroadcastCreate201ResponseDataTypeEnumEnumMap = {
  BroadcastCreate201ResponseDataTypeEnum.EMAIL: 'EMAIL',
  BroadcastCreate201ResponseDataTypeEnum.IN_APP: 'IN_APP',
  BroadcastCreate201ResponseDataTypeEnum.ALL: 'ALL',
};

const _$BroadcastCreate201ResponseDataStatusEnumEnumMap = {
  BroadcastCreate201ResponseDataStatusEnum.PENDING: 'PENDING',
  BroadcastCreate201ResponseDataStatusEnum.SENDING: 'SENDING',
  BroadcastCreate201ResponseDataStatusEnum.SENT: 'SENT',
  BroadcastCreate201ResponseDataStatusEnum.FAILED: 'FAILED',
};

const _$BroadcastCreate201ResponseDataTargetAudienceEnumEnumMap = {
  BroadcastCreate201ResponseDataTargetAudienceEnum.ALL: 'ALL',
  BroadcastCreate201ResponseDataTargetAudienceEnum.USERS: 'USERS',
  BroadcastCreate201ResponseDataTargetAudienceEnum.DRIVERS: 'DRIVERS',
  BroadcastCreate201ResponseDataTargetAudienceEnum.MERCHANTS: 'MERCHANTS',
  BroadcastCreate201ResponseDataTargetAudienceEnum.ADMINS: 'ADMINS',
  BroadcastCreate201ResponseDataTargetAudienceEnum.OPERATORS: 'OPERATORS',
};
