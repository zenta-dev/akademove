// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_user_create_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeUserCreateRequestCWProxy {
  BadgeUserCreateRequest userId(String? userId);

  BadgeUserCreateRequest badgeId(String? badgeId);

  BadgeUserCreateRequest metadata(UserBadgeMetadata? metadata);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeUserCreateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeUserCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  BadgeUserCreateRequest call({
    String? userId,
    String? badgeId,
    UserBadgeMetadata? metadata,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBadgeUserCreateRequest.copyWith(...)` or call `instanceOfBadgeUserCreateRequest.copyWith.fieldName(value)` for a single field.
class _$BadgeUserCreateRequestCWProxyImpl
    implements _$BadgeUserCreateRequestCWProxy {
  const _$BadgeUserCreateRequestCWProxyImpl(this._value);

  final BadgeUserCreateRequest _value;

  @override
  BadgeUserCreateRequest userId(String? userId) => call(userId: userId);

  @override
  BadgeUserCreateRequest badgeId(String? badgeId) => call(badgeId: badgeId);

  @override
  BadgeUserCreateRequest metadata(UserBadgeMetadata? metadata) =>
      call(metadata: metadata);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeUserCreateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeUserCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  BadgeUserCreateRequest call({
    Object? userId = const $CopyWithPlaceholder(),
    Object? badgeId = const $CopyWithPlaceholder(),
    Object? metadata = const $CopyWithPlaceholder(),
  }) {
    return BadgeUserCreateRequest(
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

extension $BadgeUserCreateRequestCopyWith on BadgeUserCreateRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBadgeUserCreateRequest.copyWith(...)` or `instanceOfBadgeUserCreateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeUserCreateRequestCWProxy get copyWith =>
      _$BadgeUserCreateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeUserCreateRequest _$BadgeUserCreateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BadgeUserCreateRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['userId', 'badgeId']);
  final val = BadgeUserCreateRequest(
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

Map<String, dynamic> _$BadgeUserCreateRequestToJson(
  BadgeUserCreateRequest instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'badgeId': instance.badgeId,
  'metadata': ?instance.metadata?.toJson(),
};
