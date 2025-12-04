//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'dashboard_stats_high_cancellation_drivers_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardStatsHighCancellationDriversInner {
  /// Returns a new [DashboardStatsHighCancellationDriversInner] instance.
  const DashboardStatsHighCancellationDriversInner({
    required this.id,
    required this.name,
    required this.totalOrders,
    required this.cancelledOrders,
    required this.cancellationRate,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'totalOrders', required: true, includeIfNull: false)
  final num totalOrders;

  @JsonKey(name: r'cancelledOrders', required: true, includeIfNull: false)
  final num cancelledOrders;

  @JsonKey(name: r'cancellationRate', required: true, includeIfNull: false)
  final num cancellationRate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardStatsHighCancellationDriversInner &&
          other.id == id &&
          other.name == name &&
          other.totalOrders == totalOrders &&
          other.cancelledOrders == cancelledOrders &&
          other.cancellationRate == cancellationRate;

  @override
  int get hashCode =>
      id.hashCode +
      name.hashCode +
      totalOrders.hashCode +
      cancelledOrders.hashCode +
      cancellationRate.hashCode;

  factory DashboardStatsHighCancellationDriversInner.fromJson(
    Map<String, dynamic> json,
  ) => _$DashboardStatsHighCancellationDriversInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DashboardStatsHighCancellationDriversInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
