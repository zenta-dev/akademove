//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/day_of_week.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'time_rules.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TimeRules {
  /// Returns a new [TimeRules] instance.
  const TimeRules({this.allowedDays, this.allowedHours});

  @JsonKey(name: r'allowedDays', required: false, includeIfNull: false)
  final List<DayOfWeek>? allowedDays;

  @JsonKey(name: r'allowedHours', required: false, includeIfNull: false)
  final List<int>? allowedHours;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeRules &&
          other.allowedDays == allowedDays &&
          other.allowedHours == allowedHours;

  @override
  int get hashCode => allowedDays.hashCode + allowedHours.hashCode;

  factory TimeRules.fromJson(Map<String, dynamic> json) =>
      _$TimeRulesFromJson(json);

  Map<String, dynamic> toJson() => _$TimeRulesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
