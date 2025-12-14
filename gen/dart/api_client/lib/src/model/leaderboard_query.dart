//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/leaderboard_period.dart';
import 'package:api_client/src/model/leaderboard_category.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'leaderboard_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeaderboardQuery {
  /// Returns a new [LeaderboardQuery] instance.
  const LeaderboardQuery({
    this.category,
    this.period,
    this.limit,
    this.cursor,
    this.page,
    this.sortBy,
    this.order,
    this.includeDriver,
  });
  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final LeaderboardCategory? category;

  @JsonKey(name: r'period', required: false, includeIfNull: false)
  final LeaderboardPeriod? period;

  // minimum: 1
  // maximum: 100
  @JsonKey(name: r'limit', required: false, includeIfNull: false)
  final int? limit;

  @JsonKey(name: r'cursor', required: false, includeIfNull: false)
  final String? cursor;

  // minimum: 1
  // maximum: 9007199254740991
  @JsonKey(name: r'page', required: false, includeIfNull: false)
  final int? page;

  @JsonKey(name: r'sortBy', required: false, includeIfNull: false)
  final String? sortBy;

  @JsonKey(name: r'order', required: false, includeIfNull: false)
  final LeaderboardQueryOrderEnum? order;

  @JsonKey(name: r'includeDriver', required: false, includeIfNull: false)
  final bool? includeDriver;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaderboardQuery &&
          other.category == category &&
          other.period == period &&
          other.limit == limit &&
          other.cursor == cursor &&
          other.page == page &&
          other.sortBy == sortBy &&
          other.order == order &&
          other.includeDriver == includeDriver;

  @override
  int get hashCode =>
      category.hashCode +
      period.hashCode +
      limit.hashCode +
      cursor.hashCode +
      page.hashCode +
      sortBy.hashCode +
      order.hashCode +
      includeDriver.hashCode;

  factory LeaderboardQuery.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardQueryFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum LeaderboardQueryOrderEnum {
  @JsonValue(r'asc')
  asc(r'asc'),
  @JsonValue(r'desc')
  desc(r'desc');

  const LeaderboardQueryOrderEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
