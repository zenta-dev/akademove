//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/general_rule_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'general_rules.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class GeneralRules {
  /// Returns a new [GeneralRules] instance.
  const GeneralRules({this.type, this.minOrderAmount, this.maxDiscountAmount});

  @JsonKey(name: r'type', required: false, includeIfNull: false)
  final GeneralRuleType? type;

  // minimum: 0
  @JsonKey(name: r'minOrderAmount', required: false, includeIfNull: false)
  final num? minOrderAmount;

  // minimum: 0
  @JsonKey(name: r'maxDiscountAmount', required: false, includeIfNull: false)
  final num? maxDiscountAmount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneralRules &&
          other.type == type &&
          other.minOrderAmount == minOrderAmount &&
          other.maxDiscountAmount == maxDiscountAmount;

  @override
  int get hashCode => type.hashCode + minOrderAmount.hashCode + maxDiscountAmount.hashCode;

  factory GeneralRules.fromJson(Map<String, dynamic> json) => _$GeneralRulesFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralRulesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
