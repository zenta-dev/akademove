//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/leaderboard_period.dart';
import 'package:api_client/src/model/leaderboard_category.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'leaderboard.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Leaderboard {
  /// Returns a new [Leaderboard] instance.
  const Leaderboard({
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

  @JsonKey(name: r'periodStart', required: true, includeIfNull: true)
  final DateTime? periodStart;

  @JsonKey(name: r'periodEnd', required: true, includeIfNull: true)
  final DateTime? periodEnd;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: true)
  final DateTime? createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: true)
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Leaderboard &&
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
          other.updatedAt == updatedAt;

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
      (periodStart == null ? 0 : periodStart.hashCode) +
      (periodEnd == null ? 0 : periodEnd.hashCode) +
      (createdAt == null ? 0 : createdAt.hashCode) +
      (updatedAt == null ? 0 : updatedAt.hashCode);

  factory Leaderboard.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
