//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'fraud_stats_recent_trend_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FraudStatsRecentTrendInner {
  /// Returns a new [FraudStatsRecentTrendInner] instance.
  const FraudStatsRecentTrendInner({
    required this.date,
    required this.count,
  });
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'count', required: true, includeIfNull: false)
  final int count;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is FraudStatsRecentTrendInner &&
    other.date == date &&
    other.count == count;

  @override
  int get hashCode =>
      date.hashCode +
      count.hashCode;

  factory FraudStatsRecentTrendInner.fromJson(Map<String, dynamic> json) => _$FraudStatsRecentTrendInnerFromJson(json);

  Map<String, dynamic> toJson() => _$FraudStatsRecentTrendInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

