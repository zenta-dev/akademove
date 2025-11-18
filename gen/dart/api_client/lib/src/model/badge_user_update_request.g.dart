// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_user_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeUserUpdateRequestCWProxy {
  BadgeUserUpdateRequest userId(String? userId);

  BadgeUserUpdateRequest badgeId(String? badgeId);

  BadgeUserUpdateRequest metadata(UserBadgeMetadata? metadata);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeUserUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeUserUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeUserUpdateRequest call({
    String? userId,
    String? badgeId,
    UserBadgeMetadata? metadata,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBadgeUserUpdateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBadgeUserUpdateRequest.copyWith.fieldName(...)`
class _$BadgeUserUpdateRequestCWProxyImpl
    implements _$BadgeUserUpdateRequestCWProxy {
  const _$BadgeUserUpdateRequestCWProxyImpl(this._value);

  final BadgeUserUpdateRequest _value;

  @override
  BadgeUserUpdateRequest userId(String? userId) => this(userId: userId);

  @override
  BadgeUserUpdateRequest badgeId(String? badgeId) => this(badgeId: badgeId);

  @override
  BadgeUserUpdateRequest metadata(UserBadgeMetadata? metadata) =>
      this(metadata: metadata);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeUserUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeUserUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeUserUpdateRequest call({
    Object? userId = const $CopyWithPlaceholder(),
    Object? badgeId = const $CopyWithPlaceholder(),
    Object? metadata = const $CopyWithPlaceholder(),
  }) {
    return BadgeUserUpdateRequest(
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      badgeId: badgeId == const $CopyWithPlaceholder()
          ? _value.badgeId
          // ignore: cast_nullable_to_non_nullable
          : badgeId as String?,
      metadata: metadata == const $CopyWithPlaceholder()
          ? _value.metadata
          // ignore: cast_nullable_to_non_nullable
          : metadata as UserBadgeMetadata?,
    );
  }
}

extension $BadgeUserUpdateRequestCopyWith on BadgeUserUpdateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfBadgeUserUpdateRequest.copyWith(...)` or like so:`instanceOfBadgeUserUpdateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeUserUpdateRequestCWProxy get copyWith =>
      _$BadgeUserUpdateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeUserUpdateRequest _$BadgeUserUpdateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BadgeUserUpdateRequest', json, ($checkedConvert) {
  final val = BadgeUserUpdateRequest(
    userId: $checkedConvert('userId', (v) => v as String?),
    badgeId: $checkedConvert('badgeId', (v) => v as String?),
    metadata: $checkedConvert(
      'metadata',
      (v) => v == null
          ? null
          : UserBadgeMetadata.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$BadgeUserUpdateRequestToJson(
  BadgeUserUpdateRequest instance,
) => <String, dynamic>{
  'userId': ?instance.userId,
  'badgeId': ?instance.badgeId,
  'metadata': ?instance.metadata?.toJson(),
};
