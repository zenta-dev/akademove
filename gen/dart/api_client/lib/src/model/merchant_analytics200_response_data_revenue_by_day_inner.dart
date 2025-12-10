//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_analytics200_response_data_revenue_by_day_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantAnalytics200ResponseDataRevenueByDayInner {
  /// Returns a new [MerchantAnalytics200ResponseDataRevenueByDayInner] instance.
  const MerchantAnalytics200ResponseDataRevenueByDayInner({
    required this.date,
    required this.revenue,
    required this.orders,
  });
  @JsonKey(name: r'date', required: true, includeIfNull: true)
  final String? date;

  @JsonKey(name: r'revenue', required: true, includeIfNull: false)
  final num revenue;

  @JsonKey(name: r'orders', required: true, includeIfNull: false)
  final num orders;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantAnalytics200ResponseDataRevenueByDayInner &&
          other.date == date &&
          other.revenue == revenue &&
          other.orders == orders;

  @override
  int get hashCode =>
      (date == null ? 0 : date.hashCode) + revenue.hashCode + orders.hashCode;

  factory MerchantAnalytics200ResponseDataRevenueByDayInner.fromJson(
    Map<String, dynamic> json,
  ) => _$MerchantAnalytics200ResponseDataRevenueByDayInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MerchantAnalytics200ResponseDataRevenueByDayInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
