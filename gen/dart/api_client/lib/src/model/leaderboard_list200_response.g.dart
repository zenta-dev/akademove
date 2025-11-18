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

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaderboardList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaderboardList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaderboardList200Response call({
    String message,
    List<Leaderboard> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeaderboardList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeaderboardList200Response.copyWith.fieldName(...)`
class _$LeaderboardList200ResponseCWProxyImpl
    implements _$LeaderboardList200ResponseCWProxy {
  const _$LeaderboardList200ResponseCWProxyImpl(this._value);

  final LeaderboardList200Response _value;

  @override
  LeaderboardList200Response message(String message) => this(message: message);

  @override
  LeaderboardList200Response data(List<Leaderboard> data) => this(data: data);

  @override
  LeaderboardList200Response pagination(PaginationResult? pagination) =>
      this(pagination: pagination);

  @override
  LeaderboardList200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaderboardList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaderboardList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaderboardList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return LeaderboardList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
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
  /// Returns a callable class that can be used as follows: `instanceOfLeaderboardList200Response.copyWith(...)` or like so:`instanceOfLeaderboardList200Response.copyWith.fieldName(...)`.
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
