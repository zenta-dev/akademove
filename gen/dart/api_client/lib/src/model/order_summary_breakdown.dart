//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_summary_breakdown.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderSummaryBreakdown {
  /// Returns a new [OrderSummaryBreakdown] instance.
  const OrderSummaryBreakdown({
    this.distance,
    this.duration,
    this.perMinuteRate,
    this.weight,
    this.perKgRate,
  });
  @JsonKey(name: r'distance', required: false, includeIfNull: false)
  final num? distance;

  @JsonKey(name: r'duration', required: false, includeIfNull: false)
  final num? duration;

  @JsonKey(name: r'perMinuteRate', required: false, includeIfNull: false)
  final num? perMinuteRate;

  @JsonKey(name: r'weight', required: false, includeIfNull: false)
  final num? weight;

  @JsonKey(name: r'perKgRate', required: false, includeIfNull: false)
  final num? perKgRate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderSummaryBreakdown &&
          other.distance == distance &&
          other.duration == duration &&
          other.perMinuteRate == perMinuteRate &&
          other.weight == weight &&
          other.perKgRate == perKgRate;

  @override
  int get hashCode =>
      distance.hashCode +
      duration.hashCode +
      perMinuteRate.hashCode +
      weight.hashCode +
      perKgRate.hashCode;

  factory OrderSummaryBreakdown.fromJson(Map<String, dynamic> json) =>
      _$OrderSummaryBreakdownFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSummaryBreakdownToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
