// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_user_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeUserUpdateRequestCWProxy {
  BadgeUserUpdateRequest userId(String? userId);

  BadgeUserUpdateRequest badgeId(String? badgeId);

  BadgeUserUpdateRequest metadata(UserBadgeMetadata? metadata);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeUserUpdateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeUserUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  BadgeUserUpdateRequest call({
    String? userId,
    String? badgeId,
    UserBadgeMetadata? metadata,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBadgeUserUpdateRequest.copyWith(...)` or call `instanceOfBadgeUserUpdateRequest.copyWith.fieldName(value)` for a single field.
class _$BadgeUserUpdateRequestCWProxyImpl
    implements _$BadgeUserUpdateRequestCWProxy {
  const _$BadgeUserUpdateRequestCWProxyImpl(this._value);

  final BadgeUserUpdateRequest _value;

  @override
  BadgeUserUpdateRequest userId(String? userId) => call(userId: userId);

  @override
  BadgeUserUpdateRequest badgeId(String? badgeId) => call(badgeId: badgeId);

  @override
  BadgeUserUpdateRequest metadata(UserBadgeMetadata? metadata) =>
      call(metadata: metadata);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeUserUpdateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeUserUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBadgeUserUpdateRequest.copyWith(...)` or `instanceOfBadgeUserUpdateRequest.copyWith.fieldName(...)`.
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
