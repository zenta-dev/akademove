// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_badge_metadata.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserBadgeMetadataCWProxy {
  UserBadgeMetadata ordersCompleted(int? ordersCompleted);

  UserBadgeMetadata finalRating(num? finalRating);

  UserBadgeMetadata streakDays(int? streakDays);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserBadgeMetadata(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserBadgeMetadata(...).copyWith(id: 12, name: "My name")
  /// ```
  UserBadgeMetadata call({
    int? ordersCompleted,
    num? finalRating,
    int? streakDays,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserBadgeMetadata.copyWith(...)` or call `instanceOfUserBadgeMetadata.copyWith.fieldName(value)` for a single field.
class _$UserBadgeMetadataCWProxyImpl implements _$UserBadgeMetadataCWProxy {
  const _$UserBadgeMetadataCWProxyImpl(this._value);

  final UserBadgeMetadata _value;

  @override
  UserBadgeMetadata ordersCompleted(int? ordersCompleted) =>
      call(ordersCompleted: ordersCompleted);

  @override
  UserBadgeMetadata finalRating(num? finalRating) =>
      call(finalRating: finalRating);

  @override
  UserBadgeMetadata streakDays(int? streakDays) => call(streakDays: streakDays);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserBadgeMetadata(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserBadgeMetadata(...).copyWith(id: 12, name: "My name")
  /// ```
  UserBadgeMetadata call({
    Object? ordersCompleted = const $CopyWithPlaceholder(),
    Object? finalRating = const $CopyWithPlaceholder(),
    Object? streakDays = const $CopyWithPlaceholder(),
  }) {
    return UserBadgeMetadata(
      ordersCompleted: ordersCompleted == const $CopyWithPlaceholder()
          ? _value.ordersCompleted
          // ignore: cast_nullable_to_non_nullable
          : ordersCompleted as int?,
      finalRating: finalRating == const $CopyWithPlaceholder()
          ? _value.finalRating
          // ignore: cast_nullable_to_non_nullable
          : finalRating as num?,
      streakDays: streakDays == const $CopyWithPlaceholder()
          ? _value.streakDays
          // ignore: cast_nullable_to_non_nullable
          : streakDays as int?,
    );
  }
}

extension $UserBadgeMetadataCopyWith on UserBadgeMetadata {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserBadgeMetadata.copyWith(...)` or `instanceOfUserBadgeMetadata.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserBadgeMetadataCWProxy get copyWith =>
      _$UserBadgeMetadataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBadgeMetadata _$UserBadgeMetadataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserBadgeMetadata', json, ($checkedConvert) {
      final val = UserBadgeMetadata(
        ordersCompleted: $checkedConvert(
          'ordersCompleted',
          (v) => (v as num?)?.toInt(),
        ),
        finalRating: $checkedConvert('finalRating', (v) => v as num?),
        streakDays: $checkedConvert('streakDays', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$UserBadgeMetadataToJson(UserBadgeMetadata instance) =>
    <String, dynamic>{
      'ordersCompleted': ?instance.ordersCompleted,
      'finalRating': ?instance.finalRating,
      'streakDays': ?instance.streakDays,
    };
