//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_summary_breakdown.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_summary.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderSummary {
  /// Returns a new [OrderSummary] instance.
  const OrderSummary({
    required this.distanceKm,
    required this.baseFare,
    required this.distanceFare,
    required this.additionalFees,
    required this.subtotal,
    required this.platformFee,
    required this.tax,
    required this.totalCost,
    required this.breakdown,
  });

  @JsonKey(name: r'distanceKm', required: true, includeIfNull: false)
  final num distanceKm;
  
  @JsonKey(name: r'baseFare', required: true, includeIfNull: false)
  final num baseFare;
  
  @JsonKey(name: r'distanceFare', required: true, includeIfNull: false)
  final num distanceFare;
  
  @JsonKey(name: r'additionalFees', required: true, includeIfNull: false)
  final num additionalFees;
  
  @JsonKey(name: r'subtotal', required: true, includeIfNull: false)
  final num subtotal;
  
  @JsonKey(name: r'platformFee', required: true, includeIfNull: false)
  final num platformFee;
  
  @JsonKey(name: r'tax', required: true, includeIfNull: false)
  final num tax;
  
  @JsonKey(name: r'totalCost', required: true, includeIfNull: false)
  final num totalCost;
  
  @JsonKey(name: r'breakdown', required: true, includeIfNull: false)
  final OrderSummaryBreakdown breakdown;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderSummary &&
    other.distanceKm == distanceKm &&
    other.baseFare == baseFare &&
    other.distanceFare == distanceFare &&
    other.additionalFees == additionalFees &&
    other.subtotal == subtotal &&
    other.platformFee == platformFee &&
    other.tax == tax &&
    other.totalCost == totalCost &&
    other.breakdown == breakdown;

  @override
  int get hashCode =>
      distanceKm.hashCode +
      baseFare.hashCode +
      distanceFare.hashCode +
      additionalFees.hashCode +
      subtotal.hashCode +
      platformFee.hashCode +
      tax.hashCode +
      totalCost.hashCode +
      breakdown.hashCode;

  factory OrderSummary.fromJson(Map<String, dynamic> json) => _$OrderSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSummaryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

