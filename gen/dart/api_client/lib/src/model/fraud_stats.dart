//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/fraud_stats_recent_trend_inner.dart';
import 'package:api_client/src/model/fraud_stats_events_by_severity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'fraud_stats.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FraudStats {
  /// Returns a new [FraudStats] instance.
  const FraudStats({
    required this.totalEvents,
    required this.pendingEvents,
    required this.reviewingEvents,
    required this.confirmedEvents,
    required this.dismissedEvents,
    required this.eventsBySeverity,
    required this.eventsByType,
    required this.highRiskUsers,
    required this.recentTrend,
  });
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'totalEvents', required: true, includeIfNull: false)
  final int totalEvents;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'pendingEvents', required: true, includeIfNull: false)
  final int pendingEvents;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'reviewingEvents', required: true, includeIfNull: false)
  final int reviewingEvents;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'confirmedEvents', required: true, includeIfNull: false)
  final int confirmedEvents;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'dismissedEvents', required: true, includeIfNull: false)
  final int dismissedEvents;
  
  @JsonKey(name: r'eventsBySeverity', required: true, includeIfNull: false)
  final FraudStatsEventsBySeverity eventsBySeverity;
  
  @JsonKey(name: r'eventsByType', required: true, includeIfNull: false)
  final Map<String, int> eventsByType;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'highRiskUsers', required: true, includeIfNull: false)
  final int highRiskUsers;
  
  @JsonKey(name: r'recentTrend', required: true, includeIfNull: false)
  final List<FraudStatsRecentTrendInner> recentTrend;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is FraudStats &&
    other.totalEvents == totalEvents &&
    other.pendingEvents == pendingEvents &&
    other.reviewingEvents == reviewingEvents &&
    other.confirmedEvents == confirmedEvents &&
    other.dismissedEvents == dismissedEvents &&
    other.eventsBySeverity == eventsBySeverity &&
    other.eventsByType == eventsByType &&
    other.highRiskUsers == highRiskUsers &&
    other.recentTrend == recentTrend;

  @override
  int get hashCode =>
      totalEvents.hashCode +
      pendingEvents.hashCode +
      reviewingEvents.hashCode +
      confirmedEvents.hashCode +
      dismissedEvents.hashCode +
      eventsBySeverity.hashCode +
      eventsByType.hashCode +
      highRiskUsers.hashCode +
      recentTrend.hashCode;

  factory FraudStats.fromJson(Map<String, dynamic> json) => _$FraudStatsFromJson(json);

  Map<String, dynamic> toJson() => _$FraudStatsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

