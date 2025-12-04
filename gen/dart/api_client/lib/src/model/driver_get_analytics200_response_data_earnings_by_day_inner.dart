//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_get_analytics200_response_data_earnings_by_day_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverGetAnalytics200ResponseDataEarningsByDayInner {
  /// Returns a new [DriverGetAnalytics200ResponseDataEarningsByDayInner] instance.
  const DriverGetAnalytics200ResponseDataEarningsByDayInner({
    required this.date,
    required this.earnings,
    required this.orders,
    required this.commission,
  });

  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'earnings', required: true, includeIfNull: false)
  final num earnings;

  @JsonKey(name: r'orders', required: true, includeIfNull: false)
  final num orders;

  @JsonKey(name: r'commission', required: true, includeIfNull: false)
  final num commission;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverGetAnalytics200ResponseDataEarningsByDayInner &&
          other.date == date &&
          other.earnings == earnings &&
          other.orders == orders &&
          other.commission == commission;

  @override
  int get hashCode =>
      date.hashCode + earnings.hashCode + orders.hashCode + commission.hashCode;

  factory DriverGetAnalytics200ResponseDataEarningsByDayInner.fromJson(
    Map<String, dynamic> json,
  ) => _$DriverGetAnalytics200ResponseDataEarningsByDayInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DriverGetAnalytics200ResponseDataEarningsByDayInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
