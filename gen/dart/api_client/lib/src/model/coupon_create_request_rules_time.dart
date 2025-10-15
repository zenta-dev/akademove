//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_create_request_rules_time.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponCreateRequestRulesTime {
  /// Returns a new [CouponCreateRequestRulesTime] instance.
  CouponCreateRequestRulesTime({this.allowedDays, this.allowedHours});

  @JsonKey(name: r'allowedDays', required: false, includeIfNull: false)
  final List<CouponCreateRequestRulesTimeAllowedDaysEnum>? allowedDays;

  @JsonKey(name: r'allowedHours', required: false, includeIfNull: false)
  final List<int>? allowedHours;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponCreateRequestRulesTime &&
          other.allowedDays == allowedDays &&
          other.allowedHours == allowedHours;

  @override
  int get hashCode => allowedDays.hashCode + allowedHours.hashCode;

  factory CouponCreateRequestRulesTime.fromJson(Map<String, dynamic> json) =>
      _$CouponCreateRequestRulesTimeFromJson(json);

  Map<String, dynamic> toJson() => _$CouponCreateRequestRulesTimeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum CouponCreateRequestRulesTimeAllowedDaysEnum {
  @JsonValue(r'sunday')
  sunday(r'sunday'),
  @JsonValue(r'monday')
  monday(r'monday'),
  @JsonValue(r'tuesday')
  tuesday(r'tuesday'),
  @JsonValue(r'wednesday')
  wednesday(r'wednesday'),
  @JsonValue(r'thursday')
  thursday(r'thursday'),
  @JsonValue(r'friday')
  friday(r'friday'),
  @JsonValue(r'saturday')
  saturday(r'saturday');

  const CouponCreateRequestRulesTimeAllowedDaysEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
