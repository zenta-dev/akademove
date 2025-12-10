// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_get200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaderboardGet200ResponseCWProxy {
  LeaderboardGet200Response message(String message);

  LeaderboardGet200Response data(Leaderboard data);

  LeaderboardGet200Response pagination(PaginationResult? pagination);

  LeaderboardGet200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LeaderboardGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LeaderboardGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  LeaderboardGet200Response call({
    String message,
    Leaderboard data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLeaderboardGet200Response.copyWith(...)` or call `instanceOfLeaderboardGet200Response.copyWith.fieldName(value)` for a single field.
class _$LeaderboardGet200ResponseCWProxyImpl
    implements _$LeaderboardGet200ResponseCWProxy {
  const _$LeaderboardGet200ResponseCWProxyImpl(this._value);

  final LeaderboardGet200Response _value;

  @override
  LeaderboardGet200Response message(String message) => call(message: message);

  @override
  LeaderboardGet200Response data(Leaderboard data) => call(data: data);

  @override
  LeaderboardGet200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  LeaderboardGet200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LeaderboardGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LeaderboardGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  LeaderboardGet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return LeaderboardGet200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Leaderboard,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as PaginationResult?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $LeaderboardGet200ResponseCopyWith on LeaderboardGet200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLeaderboardGet200Response.copyWith(...)` or `instanceOfLeaderboardGet200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaderboardGet200ResponseCWProxy get copyWith =>
      _$LeaderboardGet200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardGet200Response _$LeaderboardGet200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('LeaderboardGet200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = LeaderboardGet200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Leaderboard.fromJson(v as Map<String, dynamic>),
    ),
    pagination: $checkedConvert(
      'pagination',
      (v) => v == null
          ? null
          : PaginationResult.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$LeaderboardGet200ResponseToJson(
  LeaderboardGet200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
