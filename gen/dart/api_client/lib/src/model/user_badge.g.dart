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

  UserBadge badge(Badge badge);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserBadge(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserBadge(...).copyWith(id: 12, name: "My name")
  /// ```
  UserBadge call({
    String id,
    String userId,
    String badgeId,
    DateTime earnedAt,
    UserBadgeMetadata? metadata,
    DateTime createdAt,
    DateTime updatedAt,
    Badge badge,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserBadge.copyWith(...)` or call `instanceOfUserBadge.copyWith.fieldName(value)` for a single field.
class _$UserBadgeCWProxyImpl implements _$UserBadgeCWProxy {
  const _$UserBadgeCWProxyImpl(this._value);

  final UserBadge _value;

  @override
  UserBadge id(String id) => call(id: id);

  @override
  UserBadge userId(String userId) => call(userId: userId);

  @override
  UserBadge badgeId(String badgeId) => call(badgeId: badgeId);

  @override
  UserBadge earnedAt(DateTime earnedAt) => call(earnedAt: earnedAt);

  @override
  UserBadge metadata(UserBadgeMetadata? metadata) => call(metadata: metadata);

  @override
  UserBadge createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  UserBadge updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  UserBadge badge(Badge badge) => call(badge: badge);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserBadge(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserBadge(...).copyWith(id: 12, name: "My name")
  /// ```
  UserBadge call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? badgeId = const $CopyWithPlaceholder(),
    Object? earnedAt = const $CopyWithPlaceholder(),
    Object? metadata = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? badge = const $CopyWithPlaceholder(),
  }) {
    return UserBadge(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      badgeId: badgeId == const $CopyWithPlaceholder() || badgeId == null
          ? _value.badgeId
          // ignore: cast_nullable_to_non_nullable
          : badgeId as String,
      earnedAt: earnedAt == const $CopyWithPlaceholder() || earnedAt == null
          ? _value.earnedAt
          // ignore: cast_nullable_to_non_nullable
          : earnedAt as DateTime,
      metadata: metadata == const $CopyWithPlaceholder()
          ? _value.metadata
          // ignore: cast_nullable_to_non_nullable
          : metadata as UserBadgeMetadata?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
      badge: badge == const $CopyWithPlaceholder() || badge == null
          ? _value.badge
          // ignore: cast_nullable_to_non_nullable
          : badge as Badge,
    );
  }
}

extension $UserBadgeCopyWith on UserBadge {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserBadge.copyWith(...)` or `instanceOfUserBadge.copyWith.fieldName(...)`.
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
      'badge',
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
    badge: $checkedConvert(
      'badge',
      (v) => Badge.fromJson(v as Map<String, dynamic>),
    ),
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
  'badge': instance.badge.toJson(),
};
