//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'badge_benefits.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BadgeBenefits {
  /// Returns a new [BadgeBenefits] instance.
  const BadgeBenefits({this.priorityBoost, this.commissionReduction});
  // minimum: 0
  // maximum: 1000
  @JsonKey(name: r'priorityBoost', required: false, includeIfNull: false)
  final int? priorityBoost;

  // minimum: 0
  // maximum: 0.5
  @JsonKey(name: r'commissionReduction', required: false, includeIfNull: false)
  final num? commissionReduction;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeBenefits &&
          other.priorityBoost == priorityBoost &&
          other.commissionReduction == commissionReduction;

  @override
  int get hashCode => priorityBoost.hashCode + commissionReduction.hashCode;

  factory BadgeBenefits.fromJson(Map<String, dynamic> json) =>
      _$BadgeBenefitsFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeBenefitsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
