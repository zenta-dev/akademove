//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/leaderboard_driver_info.dart';
import 'package:api_client/src/model/leaderboard_period.dart';
import 'package:api_client/src/model/leaderboard_category.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'leaderboard_with_driver.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeaderboardWithDriver {
  /// Returns a new [LeaderboardWithDriver] instance.
  const LeaderboardWithDriver({
    required this.id,
    required this.userId,
    this.driverId,
    this.merchantId,
    required this.category,
    required this.period,
    required this.rank,
    required this.score,
    required this.periodStart,
    required this.periodEnd,
    required this.createdAt,
    required this.updatedAt,
    this.driver,
    this.previousRank,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'driverId', required: false, includeIfNull: false)
  final String? driverId;

  @JsonKey(name: r'merchantId', required: false, includeIfNull: false)
  final String? merchantId;

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final LeaderboardCategory category;

  @JsonKey(name: r'period', required: true, includeIfNull: false)
  final LeaderboardPeriod period;

  // minimum: 1
  // maximum: 9007199254740991
  @JsonKey(name: r'rank', required: true, includeIfNull: false)
  final int rank;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'score', required: true, includeIfNull: false)
  final int score;

  @JsonKey(name: r'periodStart', required: true, includeIfNull: false)
  final DateTime periodStart;

  @JsonKey(name: r'periodEnd', required: true, includeIfNull: false)
  final DateTime periodEnd;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @JsonKey(name: r'driver', required: false, includeIfNull: false)
  final LeaderboardDriverInfo? driver;

  // minimum: 1
  // maximum: 9007199254740991
  @JsonKey(name: r'previousRank', required: false, includeIfNull: false)
  final int? previousRank;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaderboardWithDriver &&
          other.id == id &&
          other.userId == userId &&
          other.driverId == driverId &&
          other.merchantId == merchantId &&
          other.category == category &&
          other.period == period &&
          other.rank == rank &&
          other.score == score &&
          other.periodStart == periodStart &&
          other.periodEnd == periodEnd &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.driver == driver &&
          other.previousRank == previousRank;

  @override
  int get hashCode =>
      id.hashCode +
      userId.hashCode +
      driverId.hashCode +
      merchantId.hashCode +
      category.hashCode +
      period.hashCode +
      rank.hashCode +
      score.hashCode +
      periodStart.hashCode +
      periodEnd.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode +
      driver.hashCode +
      previousRank.hashCode;

  factory LeaderboardWithDriver.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardWithDriverFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardWithDriverToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
