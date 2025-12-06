// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_broadcast.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateBroadcastCWProxy {
  UpdateBroadcast title(String? title);

  UpdateBroadcast message(String? message);

  UpdateBroadcast type(BroadcastType? type);

  UpdateBroadcast targetAudience(
    UpdateBroadcastTargetAudienceEnum? targetAudience,
  );

  UpdateBroadcast targetIds(List<String>? targetIds);

  UpdateBroadcast scheduledAt(DateTime? scheduledAt);

  UpdateBroadcast createdBy(String? createdBy);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateBroadcast(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateBroadcast(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateBroadcast call({
    String? title,
    String? message,
    BroadcastType? type,
    UpdateBroadcastTargetAudienceEnum? targetAudience,
    List<String>? targetIds,
    DateTime? scheduledAt,
    String? createdBy,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateBroadcast.copyWith(...)` or call `instanceOfUpdateBroadcast.copyWith.fieldName(value)` for a single field.
class _$UpdateBroadcastCWProxyImpl implements _$UpdateBroadcastCWProxy {
  const _$UpdateBroadcastCWProxyImpl(this._value);

  final UpdateBroadcast _value;

  @override
  UpdateBroadcast title(String? title) => call(title: title);

  @override
  UpdateBroadcast message(String? message) => call(message: message);

  @override
  UpdateBroadcast type(BroadcastType? type) => call(type: type);

  @override
  UpdateBroadcast targetAudience(
    UpdateBroadcastTargetAudienceEnum? targetAudience,
  ) => call(targetAudience: targetAudience);

  @override
  UpdateBroadcast targetIds(List<String>? targetIds) =>
      call(targetIds: targetIds);

  @override
  UpdateBroadcast scheduledAt(DateTime? scheduledAt) =>
      call(scheduledAt: scheduledAt);

  @override
  UpdateBroadcast createdBy(String? createdBy) => call(createdBy: createdBy);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateBroadcast(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateBroadcast(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateBroadcast call({
    Object? title = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? targetAudience = const $CopyWithPlaceholder(),
    Object? targetIds = const $CopyWithPlaceholder(),
    Object? scheduledAt = const $CopyWithPlaceholder(),
    Object? createdBy = const $CopyWithPlaceholder(),
  }) {
    return UpdateBroadcast(
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as BroadcastType?,
      targetAudience: targetAudience == const $CopyWithPlaceholder()
          ? _value.targetAudience
          // ignore: cast_nullable_to_non_nullable
          : targetAudience as UpdateBroadcastTargetAudienceEnum?,
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

extension $UpdateBroadcastCopyWith on UpdateBroadcast {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateBroadcast.copyWith(...)` or `instanceOfUpdateBroadcast.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateBroadcastCWProxy get copyWith => _$UpdateBroadcastCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBroadcast _$UpdateBroadcastFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateBroadcast', json, ($checkedConvert) {
      final val = UpdateBroadcast(
        title: $checkedConvert('title', (v) => v as String?),
        message: $checkedConvert('message', (v) => v as String?),
        type: $checkedConvert(
          'type',
          (v) => $enumDecodeNullable(_$BroadcastTypeEnumMap, v),
        ),
        targetAudience: $checkedConvert(
          'targetAudience',
          (v) => $enumDecodeNullable(
            _$UpdateBroadcastTargetAudienceEnumEnumMap,
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
        createdBy: $checkedConvert('createdBy', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$UpdateBroadcastToJson(UpdateBroadcast instance) =>
    <String, dynamic>{
      'title': ?instance.title,
      'message': ?instance.message,
      'type': ?_$BroadcastTypeEnumMap[instance.type],
      'targetAudience':
          ?_$UpdateBroadcastTargetAudienceEnumEnumMap[instance.targetAudience],
      'targetIds': ?instance.targetIds,
      'scheduledAt': ?instance.scheduledAt?.toIso8601String(),
      'createdBy': ?instance.createdBy,
    };

const _$BroadcastTypeEnumMap = {
  BroadcastType.EMAIL: 'EMAIL',
  BroadcastType.IN_APP: 'IN_APP',
  BroadcastType.ALL: 'ALL',
};

const _$UpdateBroadcastTargetAudienceEnumEnumMap = {
  UpdateBroadcastTargetAudienceEnum.ALL: 'ALL',
  UpdateBroadcastTargetAudienceEnum.USERS: 'USERS',
  UpdateBroadcastTargetAudienceEnum.DRIVERS: 'DRIVERS',
  UpdateBroadcastTargetAudienceEnum.MERCHANTS: 'MERCHANTS',
  UpdateBroadcastTargetAudienceEnum.ADMINS: 'ADMINS',
  UpdateBroadcastTargetAudienceEnum.OPERATORS: 'OPERATORS',
};
