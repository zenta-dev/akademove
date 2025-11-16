// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_badge.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserBadgeCWProxy {
  UserBadge id(String id);

  UserBadge userId(String userId);

  UserBadge badgeId(String badgeId);

  UserBadge earnedAt(DateTime earnedAt);

  UserBadge metadata(UserBadgeMetadata? metadata);

  UserBadge createdAt(DateTime createdAt);

  UserBadge updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserBadge(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserBadge(...).copyWith(id: 12, name: "My name")
  /// ````
  UserBadge call({
    String id,
    String userId,
    String badgeId,
    DateTime earnedAt,
    UserBadgeMetadata? metadata,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserBadge.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserBadge.copyWith.fieldName(...)`
class _$UserBadgeCWProxyImpl implements _$UserBadgeCWProxy {
  const _$UserBadgeCWProxyImpl(this._value);

  final UserBadge _value;

  @override
  UserBadge id(String id) => this(id: id);

  @override
  UserBadge userId(String userId) => this(userId: userId);

  @override
  UserBadge badgeId(String badgeId) => this(badgeId: badgeId);

  @override
  UserBadge earnedAt(DateTime earnedAt) => this(earnedAt: earnedAt);

  @override
  UserBadge metadata(UserBadgeMetadata? metadata) => this(metadata: metadata);

  @override
  UserBadge createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  UserBadge updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserBadge(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserBadge(...).copyWith(id: 12, name: "My name")
  /// ````
  UserBadge call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? badgeId = const $CopyWithPlaceholder(),
    Object? earnedAt = const $CopyWithPlaceholder(),
    Object? metadata = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return UserBadge(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      badgeId: badgeId == const $CopyWithPlaceholder()
          ? _value.badgeId
          // ignore: cast_nullable_to_non_nullable
          : badgeId as String,
      earnedAt: earnedAt == const $CopyWithPlaceholder()
          ? _value.earnedAt
          // ignore: cast_nullable_to_non_nullable
          : earnedAt as DateTime,
      metadata: metadata == const $CopyWithPlaceholder()
          ? _value.metadata
          // ignore: cast_nullable_to_non_nullable
          : metadata as UserBadgeMetadata?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $UserBadgeCopyWith on UserBadge {
  /// Returns a callable class that can be used as follows: `instanceOfUserBadge.copyWith(...)` or like so:`instanceOfUserBadge.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserBadgeCWProxy get copyWith => _$UserBadgeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBadge _$UserBadgeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UserBadge', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'userId',
      'badgeId',
      'earnedAt',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = UserBadge(
    id: $checkedConvert('id', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    badgeId: $checkedConvert('badgeId', (v) => v as String),
    earnedAt: $checkedConvert('earnedAt', (v) => DateTime.parse(v as String)),
    metadata: $checkedConvert(
      'metadata',
      (v) => v == null
          ? null
          : UserBadgeMetadata.fromJson(v as Map<String, dynamic>),
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$UserBadgeToJson(UserBadge instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'badgeId': instance.badgeId,
  'earnedAt': instance.earnedAt.toIso8601String(),
  'metadata': ?instance.metadata?.toJson(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
