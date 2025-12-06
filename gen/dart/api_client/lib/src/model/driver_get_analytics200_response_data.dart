//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_get_analytics200_response_data_earnings_by_type_inner.dart';
import 'package:api_client/src/model/driver_get_analytics200_response_data_earnings_by_day_inner.dart';
import 'package:api_client/src/model/driver_get_analytics200_response_data_top_earning_days_inner.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_get_analytics200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverGetAnalytics200ResponseData {
  /// Returns a new [DriverGetAnalytics200ResponseData] instance.
  const DriverGetAnalytics200ResponseData({
    required this.totalEarnings,
    required this.totalCommission,
    required this.netEarnings,
    required this.totalOrders,
    required this.completedOrders,
    required this.cancelledOrders,
    required this.completionRate,
    required this.averageRating,
    required this.earningsByType,
    required this.earningsByDay,
    required this.topEarningDays,
  });
  @JsonKey(name: r'totalEarnings', required: true, includeIfNull: false)
  final num totalEarnings;

  @JsonKey(name: r'totalCommission', required: true, includeIfNull: false)
  final num totalCommission;

  @JsonKey(name: r'netEarnings', required: true, includeIfNull: false)
  final num netEarnings;

  @JsonKey(name: r'totalOrders', required: true, includeIfNull: false)
  final num totalOrders;

  @JsonKey(name: r'completedOrders', required: true, includeIfNull: false)
  final num completedOrders;

  @JsonKey(name: r'cancelledOrders', required: true, includeIfNull: false)
  final num cancelledOrders;

  @JsonKey(name: r'completionRate', required: true, includeIfNull: false)
  final num completionRate;

  @JsonKey(name: r'averageRating', required: true, includeIfNull: false)
  final num averageRating;

  @JsonKey(name: r'earningsByType', required: true, includeIfNull: false)
  final List<DriverGetAnalytics200ResponseDataEarningsByTypeInner>
  earningsByType;

  @JsonKey(name: r'earningsByDay', required: true, includeIfNull: false)
  final List<DriverGetAnalytics200ResponseDataEarningsByDayInner> earningsByDay;

  @JsonKey(name: r'topEarningDays', required: true, includeIfNull: false)
  final List<DriverGetAnalytics200ResponseDataTopEarningDaysInner>
  topEarningDays;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverGetAnalytics200ResponseData &&
          other.totalEarnings == totalEarnings &&
          other.totalCommission == totalCommission &&
          other.netEarnings == netEarnings &&
          other.totalOrders == totalOrders &&
          other.completedOrders == completedOrders &&
          other.cancelledOrders == cancelledOrders &&
          other.completionRate == completionRate &&
          other.averageRating == averageRating &&
          other.earningsByType == earningsByType &&
          other.earningsByDay == earningsByDay &&
          other.topEarningDays == topEarningDays;

  @override
  int get hashCode =>
      totalEarnings.hashCode +
      totalCommission.hashCode +
      netEarnings.hashCode +
      totalOrders.hashCode +
      completedOrders.hashCode +
      cancelledOrders.hashCode +
      completionRate.hashCode +
      averageRating.hashCode +
      earningsByType.hashCode +
      earningsByDay.hashCode +
      topEarningDays.hashCode;

  factory DriverGetAnalytics200ResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$DriverGetAnalytics200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DriverGetAnalytics200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
