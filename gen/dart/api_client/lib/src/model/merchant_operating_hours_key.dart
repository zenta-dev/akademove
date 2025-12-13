//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum MerchantOperatingHoursKey {
      @JsonValue(r'id')
      id(r'id'),
      @JsonValue(r'merchantId')
      merchantId(r'merchantId'),
      @JsonValue(r'dayOfWeek')
      dayOfWeek(r'dayOfWeek'),
      @JsonValue(r'isOpen')
      isOpen(r'isOpen'),
      @JsonValue(r'is24Hours')
      is24Hours(r'is24Hours'),
      @JsonValue(r'openTime')
      openTime(r'openTime'),
      @JsonValue(r'closeTime')
      closeTime(r'closeTime'),
      @JsonValue(r'createdAt')
      createdAt(r'createdAt'),
      @JsonValue(r'updatedAt')
      updatedAt(r'updatedAt');

  const MerchantOperatingHoursKey(this.value);

  final String value;

  @override
  String toString() => value;
}
