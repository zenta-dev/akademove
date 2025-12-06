// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_broadcast.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertBroadcastCWProxy {
  InsertBroadcast title(String title);

  InsertBroadcast message(String message);

  InsertBroadcast type(BroadcastType type);

  InsertBroadcast targetAudience(
    InsertBroadcastTargetAudienceEnum targetAudience,
  );

  InsertBroadcast targetIds(List<String>? targetIds);

  InsertBroadcast scheduledAt(DateTime? scheduledAt);

  InsertBroadcast createdBy(String? createdBy);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertBroadcast(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertBroadcast(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertBroadcast call({
    String title,
    String message,
    BroadcastType type,
    InsertBroadcastTargetAudienceEnum targetAudience,
    List<String>? targetIds,
    DateTime? scheduledAt,
    String? createdBy,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertBroadcast.copyWith(...)` or call `instanceOfInsertBroadcast.copyWith.fieldName(value)` for a single field.
class _$InsertBroadcastCWProxyImpl implements _$InsertBroadcastCWProxy {
  const _$InsertBroadcastCWProxyImpl(this._value);

  final InsertBroadcast _value;

  @override
  InsertBroadcast title(String title) => call(title: title);

  @override
  InsertBroadcast message(String message) => call(message: message);

  @override
  InsertBroadcast type(BroadcastType type) => call(type: type);

  @override
  InsertBroadcast targetAudience(
    InsertBroadcastTargetAudienceEnum targetAudience,
  ) => call(targetAudience: targetAudience);

  @override
  InsertBroadcast targetIds(List<String>? targetIds) =>
      call(targetIds: targetIds);

  @override
  InsertBroadcast scheduledAt(DateTime? scheduledAt) =>
      call(scheduledAt: scheduledAt);

  @override
  InsertBroadcast createdBy(String? createdBy) => call(createdBy: createdBy);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertBroadcast(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertBroadcast(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertBroadcast call({
    Object? title = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? targetAudience = const $CopyWithPlaceholder(),
    Object? targetIds = const $CopyWithPlaceholder(),
    Object? scheduledAt = const $CopyWithPlaceholder(),
    Object? createdBy = const $CopyWithPlaceholder(),
  }) {
    return InsertBroadcast(
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
      targetAudience:
          targetAudience == const $CopyWithPlaceholder() ||
              targetAudience == null
          ? _value.targetAudience
          // ignore: cast_nullable_to_non_nullable
          : targetAudience as InsertBroadcastTargetAudienceEnum,
      targetIds: targetIds == const $CopyWithPlaceholder()
          ? _value.targetIds
          // ignore: cast_nullable_to_non_nullable
          : targetIds as List<String>?,
      scheduledAt: scheduledAt == const $CopyWithPlaceholder()
          ? _value.scheduledAt
          // ignore: cast_nullable_to_non_nullable
          : scheduledAt as DateTime?,
      createdBy: createdBy == const $CopyWithPlaceholder()
          ? _value.createdBy
          // ignore: cast_nullable_to_non_nullable
          : createdBy as String?,
    );
  }
}

extension $InsertBroadcastCopyWith on InsertBroadcast {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertBroadcast.copyWith(...)` or `instanceOfInsertBroadcast.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertBroadcastCWProxy get copyWith => _$InsertBroadcastCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertBroadcast _$InsertBroadcastFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertBroadcast', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['title', 'message', 'type', 'targetAudience'],
      );
      final val = InsertBroadcast(
        title: $checkedConvert('title', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$BroadcastTypeEnumMap, v),
        ),
        targetAudience: $checkedConvert(
          'targetAudience',
          (v) => $enumDecode(_$InsertBroadcastTargetAudienceEnumEnumMap, v),
        ),
        targetIds: $checkedConvert(
          'targetIds',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        scheduledAt: $checkedConvert(
          'scheduledAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        createdBy: $checkedConvert('createdBy', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$InsertBroadcastToJson(InsertBroadcast instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'type': _$BroadcastTypeEnumMap[instance.type]!,
      'targetAudience':
          _$InsertBroadcastTargetAudienceEnumEnumMap[instance.targetAudience]!,
      'targetIds': ?instance.targetIds,
      'scheduledAt': ?instance.scheduledAt?.toIso8601String(),
      'createdBy': ?instance.createdBy,
    };

const _$BroadcastTypeEnumMap = {
  BroadcastType.EMAIL: 'EMAIL',
  BroadcastType.IN_APP: 'IN_APP',
  BroadcastType.ALL: 'ALL',
};

const _$InsertBroadcastTargetAudienceEnumEnumMap = {
  InsertBroadcastTargetAudienceEnum.ALL: 'ALL',
  InsertBroadcastTargetAudienceEnum.USERS: 'USERS',
  InsertBroadcastTargetAudienceEnum.DRIVERS: 'DRIVERS',
  InsertBroadcastTargetAudienceEnum.MERCHANTS: 'MERCHANTS',
  InsertBroadcastTargetAudienceEnum.ADMINS: 'ADMINS',
  InsertBroadcastTargetAudienceEnum.OPERATORS: 'OPERATORS',
};
