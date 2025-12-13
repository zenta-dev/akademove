//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'chart_data_point.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ChartDataPoint {
  /// Returns a new [ChartDataPoint] instance.
  const ChartDataPoint({
    required this.label,
    required this.income,
    required this.outcome,
  });
  @JsonKey(name: r'label', required: true, includeIfNull: false)
  final String label;

  @JsonKey(name: r'income', required: true, includeIfNull: false)
  final num income;

  @JsonKey(name: r'outcome', required: true, includeIfNull: false)
  final num outcome;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChartDataPoint &&
          other.label == label &&
          other.income == income &&
          other.outcome == outcome;

  @override
  int get hashCode => label.hashCode + income.hashCode + outcome.hashCode;

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) =>
      _$ChartDataPointFromJson(json);

  Map<String, dynamic> toJson() => _$ChartDataPointToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
