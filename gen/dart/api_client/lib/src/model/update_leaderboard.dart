//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_leaderboard.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateLeaderboard {
  /// Returns a new [UpdateLeaderboard] instance.
  const UpdateLeaderboard({
    this.userId,
    this.driverId,
    this.merchantId,
    this.category,
    this.period,
    this.rank,
    this.score,
    this.periodStart,
    this.periodEnd,
  });

  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;

  @JsonKey(name: r'driverId', required: false, includeIfNull: false)
  final String? driverId;

  @JsonKey(name: r'merchantId', required: false, includeIfNull: false)
  final String? merchantId;

  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final UpdateLeaderboardCategoryEnum? category;

  @JsonKey(name: r'period', required: false, includeIfNull: false)
  final UpdateLeaderboardPeriodEnum? period;

  // minimum: 1
  // maximum: 9007199254740991
  @JsonKey(name: r'rank', required: false, includeIfNull: false)
  final int? rank;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'score', required: false, includeIfNull: false)
  final int? score;

  @JsonKey(name: r'periodStart', required: false, includeIfNull: false)
  final DateTime? periodStart;

  @JsonKey(name: r'periodEnd', required: false, includeIfNull: false)
  final DateTime? periodEnd;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateLeaderboard &&
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

  factory UpdateLeaderboard.fromJson(Map<String, dynamic> json) =>
      _$UpdateLeaderboardFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateLeaderboardToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum UpdateLeaderboardCategoryEnum {
  @JsonValue(r'rating')
  rating(r'rating'),
  @JsonValue(r'volume')
  volume(r'volume'),
  @JsonValue(r'earnings')
  earnings(r'earnings'),
  @JsonValue(r'streak')
  streak(r'streak'),
  @JsonValue(r'on-time')
  onTime(r'on-time'),
  @JsonValue(r'completion-rate')
  completionRate(r'completion-rate');

  const UpdateLeaderboardCategoryEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum UpdateLeaderboardPeriodEnum {
  @JsonValue(r'daily')
  daily(r'daily'),
  @JsonValue(r'weekly')
  weekly(r'weekly'),
  @JsonValue(r'monthly')
  monthly(r'monthly'),
  @JsonValue(r'quarterly')
  quarterly(r'quarterly'),
  @JsonValue(r'yearly')
  yearly(r'yearly'),
  @JsonValue(r'all-time')
  allTime(r'all-time');

  const UpdateLeaderboardPeriodEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
