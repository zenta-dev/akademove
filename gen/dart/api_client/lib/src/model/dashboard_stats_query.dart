//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'dashboard_stats_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardStatsQuery {
  /// Returns a new [DashboardStatsQuery] instance.
  const DashboardStatsQuery({
     this.startDate,
     this.endDate,
     this.period,
  });
  @JsonKey(name: r'startDate', required: false, includeIfNull: false)
  final DateTime? startDate;
  
  @JsonKey(name: r'endDate', required: false, includeIfNull: false)
  final DateTime? endDate;
  
  @JsonKey(name: r'period', required: false, includeIfNull: false)
  final DashboardStatsQueryPeriodEnum? period;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DashboardStatsQuery &&
    other.startDate == startDate &&
    other.endDate == endDate &&
    other.period == period;

  @override
  int get hashCode =>
      startDate.hashCode +
      endDate.hashCode +
      period.hashCode;

  factory DashboardStatsQuery.fromJson(Map<String, dynamic> json) => _$DashboardStatsQueryFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardStatsQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum DashboardStatsQueryPeriodEnum {
  @JsonValue(r'today')
  today(r'today'),
  @JsonValue(r'week')
  week(r'week'),
  @JsonValue(r'month')
  month(r'month'),
  @JsonValue(r'year')
  year(r'year');
  
  const DashboardStatsQueryPeriodEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

