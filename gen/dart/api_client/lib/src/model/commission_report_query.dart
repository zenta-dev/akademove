//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/commission_report_period.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'commission_report_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CommissionReportQuery {
  /// Returns a new [CommissionReportQuery] instance.
  const CommissionReportQuery({
    this.period = CommissionReportPeriod.daily,
    this.startDate,
    this.endDate,
  });
  @JsonKey(
    defaultValue: CommissionReportPeriod.daily,
    name: r'period',
    required: false,
    includeIfNull: false,
  )
  final CommissionReportPeriod? period;

  @JsonKey(name: r'startDate', required: false, includeIfNull: false)
  final DateTime? startDate;

  @JsonKey(name: r'endDate', required: false, includeIfNull: false)
  final DateTime? endDate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommissionReportQuery &&
          other.period == period &&
          other.startDate == startDate &&
          other.endDate == endDate;

  @override
  int get hashCode =>
      period.hashCode +
      (startDate == null ? 0 : startDate.hashCode) +
      (endDate == null ? 0 : endDate.hashCode);

  factory CommissionReportQuery.fromJson(Map<String, dynamic> json) =>
      _$CommissionReportQueryFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionReportQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
