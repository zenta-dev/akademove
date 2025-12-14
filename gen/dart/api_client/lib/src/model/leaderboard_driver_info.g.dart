// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_driver_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaderboardDriverInfoCWProxy {
  LeaderboardDriverInfo id(String id);

  LeaderboardDriverInfo name(String name);

  LeaderboardDriverInfo image(String? image);

  LeaderboardDriverInfo rating(num rating);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LeaderboardDriverInfo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LeaderboardDriverInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  LeaderboardDriverInfo call({
    String id,
    String name,
    String? image,
    num rating,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLeaderboardDriverInfo.copyWith(...)` or call `instanceOfLeaderboardDriverInfo.copyWith.fieldName(value)` for a single field.
class _$LeaderboardDriverInfoCWProxyImpl
    implements _$LeaderboardDriverInfoCWProxy {
  const _$LeaderboardDriverInfoCWProxyImpl(this._value);

  final LeaderboardDriverInfo _value;

  @override
  LeaderboardDriverInfo id(String id) => call(id: id);

  @override
  LeaderboardDriverInfo name(String name) => call(name: name);

  @override
  LeaderboardDriverInfo image(String? image) => call(image: image);

  @override
  LeaderboardDriverInfo rating(num rating) => call(rating: rating);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LeaderboardDriverInfo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LeaderboardDriverInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  LeaderboardDriverInfo call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? rating = const $CopyWithPlaceholder(),
  }) {
    return LeaderboardDriverInfo(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
      rating: rating == const $CopyWithPlaceholder() || rating == null
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as num,
    );
  }
}

extension $LeaderboardDriverInfoCopyWith on LeaderboardDriverInfo {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLeaderboardDriverInfo.copyWith(...)` or `instanceOfLeaderboardDriverInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaderboardDriverInfoCWProxy get copyWith =>
      _$LeaderboardDriverInfoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardDriverInfo _$LeaderboardDriverInfoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('LeaderboardDriverInfo', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'name', 'rating']);
  final val = LeaderboardDriverInfo(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    image: $checkedConvert('image', (v) => v as String?),
    rating: $checkedConvert('rating', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$LeaderboardDriverInfoToJson(
  LeaderboardDriverInfo instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image': ?instance.image,
  'rating': instance.rating,
};
