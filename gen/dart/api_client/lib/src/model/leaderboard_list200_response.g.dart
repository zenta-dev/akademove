// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaderboardList200ResponseCWProxy {
  LeaderboardList200Response message(String message);

  LeaderboardList200Response data(List<Leaderboard> data);

  LeaderboardList200Response pagination(PaginationResult? pagination);

  LeaderboardList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LeaderboardList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LeaderboardList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  LeaderboardList200Response call({
    String message,
    List<Leaderboard> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLeaderboardList200Response.copyWith(...)` or call `instanceOfLeaderboardList200Response.copyWith.fieldName(value)` for a single field.
class _$LeaderboardList200ResponseCWProxyImpl
    implements _$LeaderboardList200ResponseCWProxy {
  const _$LeaderboardList200ResponseCWProxyImpl(this._value);

  final LeaderboardList200Response _value;

  @override
  LeaderboardList200Response message(String message) => call(message: message);

  @override
  LeaderboardList200Response data(List<Leaderboard> data) => call(data: data);

  @override
  LeaderboardList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  LeaderboardList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LeaderboardList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LeaderboardList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  LeaderboardList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return LeaderboardList200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Leaderboard>,
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

extension $LeaderboardList200ResponseCopyWith on LeaderboardList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLeaderboardList200Response.copyWith(...)` or `instanceOfLeaderboardList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaderboardList200ResponseCWProxy get copyWith =>
      _$LeaderboardList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardList200Response _$LeaderboardList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('LeaderboardList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = LeaderboardList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Leaderboard.fromJson(e as Map<String, dynamic>))
          .toList(),
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

Map<String, dynamic> _$LeaderboardList200ResponseToJson(
  LeaderboardList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
