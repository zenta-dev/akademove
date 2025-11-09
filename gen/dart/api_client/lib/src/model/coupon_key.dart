//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum CouponKey {
  @JsonValue(r'id')
  id(r'id'),
  @JsonValue(r'name')
  name(r'name'),
  @JsonValue(r'code')
  code(r'code'),
  @JsonValue(r'rules')
  rules(r'rules'),
  @JsonValue(r'discountAmount')
  discountAmount(r'discountAmount'),
  @JsonValue(r'discountPercentage')
  discountPercentage(r'discountPercentage'),
  @JsonValue(r'usageLimit')
  usageLimit(r'usageLimit'),
  @JsonValue(r'usedCount')
  usedCount(r'usedCount'),
  @JsonValue(r'periodStart')
  periodStart(r'periodStart'),
  @JsonValue(r'periodEnd')
  periodEnd(r'periodEnd'),
  @JsonValue(r'isActive')
  isActive(r'isActive'),
  @JsonValue(r'createdById')
  createdById(r'createdById'),
  @JsonValue(r'createdAt')
  createdAt(r'createdAt');

  const CouponKey(this.value);

  final String value;

  @override
  String toString() => value;
}
