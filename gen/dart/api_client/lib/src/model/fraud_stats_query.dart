//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'fraud_stats_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FraudStatsQuery {
  /// Returns a new [FraudStatsQuery] instance.
  const FraudStatsQuery({
     this.startDate,
     this.endDate,
     this.trendDays,
  });
  @JsonKey(name: r'startDate', required: false, includeIfNull: false)
  final DateTime? startDate;
  
  @JsonKey(name: r'endDate', required: false, includeIfNull: false)
  final DateTime? endDate;
  
          // minimum: 1
          // maximum: 90
  @JsonKey(name: r'trendDays', required: false, includeIfNull: false)
  final int? trendDays;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is FraudStatsQuery &&
    other.startDate == startDate &&
    other.endDate == endDate &&
    other.trendDays == trendDays;

  @override
  int get hashCode =>
      startDate.hashCode +
      endDate.hashCode +
      trendDays.hashCode;

  factory FraudStatsQuery.fromJson(Map<String, dynamic> json) => _$FraudStatsQueryFromJson(json);

  Map<String, dynamic> toJson() => _$FraudStatsQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

