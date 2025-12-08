//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_leaderboard.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertLeaderboard {
  /// Returns a new [InsertLeaderboard] instance.
  const InsertLeaderboard({
    required this.userId,
    this.driverId,
    this.merchantId,
    required this.category,
    required this.period,
    required this.rank,
    required this.score,
    required this.periodStart,
    required this.periodEnd,
  });
  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'driverId', required: false, includeIfNull: false)
  final String? driverId;

  @JsonKey(name: r'merchantId', required: false, includeIfNull: false)
  final String? merchantId;

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final InsertLeaderboardCategoryEnum category;

  @JsonKey(name: r'period', required: true, includeIfNull: false)
  final InsertLeaderboardPeriodEnum period;

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsertLeaderboard &&
          other.userId == userId &&
          other.driverId == driverId &&
          other.merchantId == merchantId &&
          other.category == category &&
          other.period == period &&
          other.rank == rank &&
          other.score == score &&
          other.periodStart == periodStart &&
          other.periodEnd == periodEnd;

  @override
  int get hashCode =>
      userId.hashCode +
      driverId.hashCode +
      merchantId.hashCode +
      category.hashCode +
      period.hashCode +
      rank.hashCode +
      score.hashCode +
      periodStart.hashCode +
      periodEnd.hashCode;

  factory InsertLeaderboard.fromJson(Map<String, dynamic> json) =>
      _$InsertLeaderboardFromJson(json);

  Map<String, dynamic> toJson() => _$InsertLeaderboardToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum InsertLeaderboardCategoryEnum {
  @JsonValue(r'RATING')
  RATING(r'RATING'),
  @JsonValue(r'VOLUME')
  VOLUME(r'VOLUME'),
  @JsonValue(r'EARNINGS')
  EARNINGS(r'EARNINGS'),
  @JsonValue(r'STREAK')
  STREAK(r'STREAK'),
  @JsonValue(r'ON-TIME')
  ON_TIME(r'ON-TIME'),
  @JsonValue(r'COMPLETION-RATE')
  COMPLETION_RATE(r'COMPLETION-RATE');

  const InsertLeaderboardCategoryEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum InsertLeaderboardPeriodEnum {
  @JsonValue(r'DAILY')
  DAILY(r'DAILY'),
  @JsonValue(r'WEEKLY')
  WEEKLY(r'WEEKLY'),
  @JsonValue(r'MONTHLY')
  MONTHLY(r'MONTHLY'),
  @JsonValue(r'QUARTERLY')
  QUARTERLY(r'QUARTERLY'),
  @JsonValue(r'YEARLY')
  YEARLY(r'YEARLY'),
  @JsonValue(r'ALL-TIME')
  ALL_TIME(r'ALL-TIME');

  const InsertLeaderboardPeriodEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
