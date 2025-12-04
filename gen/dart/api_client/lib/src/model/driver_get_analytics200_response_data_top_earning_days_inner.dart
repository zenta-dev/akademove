//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_get_analytics200_response_data_top_earning_days_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverGetAnalytics200ResponseDataTopEarningDaysInner {
  /// Returns a new [DriverGetAnalytics200ResponseDataTopEarningDaysInner] instance.
  const DriverGetAnalytics200ResponseDataTopEarningDaysInner({
    required this.date,
    required this.earnings,
    required this.orders,
  });

  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'earnings', required: true, includeIfNull: false)
  final num earnings;

  @JsonKey(name: r'orders', required: true, includeIfNull: false)
  final num orders;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverGetAnalytics200ResponseDataTopEarningDaysInner &&
          other.date == date &&
          other.earnings == earnings &&
          other.orders == orders;

  @override
  int get hashCode => date.hashCode + earnings.hashCode + orders.hashCode;

  factory DriverGetAnalytics200ResponseDataTopEarningDaysInner.fromJson(
    Map<String, dynamic> json,
  ) => _$DriverGetAnalytics200ResponseDataTopEarningDaysInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DriverGetAnalytics200ResponseDataTopEarningDaysInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
