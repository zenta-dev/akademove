//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_get_analytics200_response_data_earnings_by_type_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverGetAnalytics200ResponseDataEarningsByTypeInner {
  /// Returns a new [DriverGetAnalytics200ResponseDataEarningsByTypeInner] instance.
  const DriverGetAnalytics200ResponseDataEarningsByTypeInner({
    required this.type,
    required this.orders,
    required this.earnings,
    required this.commission,
  });
  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final DriverGetAnalytics200ResponseDataEarningsByTypeInnerTypeEnum type;

  @JsonKey(name: r'orders', required: true, includeIfNull: false)
  final num orders;

  @JsonKey(name: r'earnings', required: true, includeIfNull: false)
  final num earnings;

  @JsonKey(name: r'commission', required: true, includeIfNull: false)
  final num commission;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverGetAnalytics200ResponseDataEarningsByTypeInner &&
          other.type == type &&
          other.orders == orders &&
          other.earnings == earnings &&
          other.commission == commission;

  @override
  int get hashCode =>
      type.hashCode + orders.hashCode + earnings.hashCode + commission.hashCode;

  factory DriverGetAnalytics200ResponseDataEarningsByTypeInner.fromJson(
    Map<String, dynamic> json,
  ) => _$DriverGetAnalytics200ResponseDataEarningsByTypeInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DriverGetAnalytics200ResponseDataEarningsByTypeInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum DriverGetAnalytics200ResponseDataEarningsByTypeInnerTypeEnum {
  @JsonValue(r'RIDE')
  RIDE(r'RIDE'),
  @JsonValue(r'DELIVERY')
  DELIVERY(r'DELIVERY'),
  @JsonValue(r'FOOD')
  FOOD(r'FOOD');

  const DriverGetAnalytics200ResponseDataEarningsByTypeInnerTypeEnum(
    this.value,
  );

  final String value;

  @override
  String toString() => value;
}
