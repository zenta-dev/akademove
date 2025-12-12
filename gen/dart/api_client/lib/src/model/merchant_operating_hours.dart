//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/day_of_week.dart';
import 'package:api_client/src/model/time.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_operating_hours.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantOperatingHours {
  /// Returns a new [MerchantOperatingHours] instance.
  const MerchantOperatingHours({
    required this.id,
    required this.merchantId,
    required this.dayOfWeek,
    required this.isOpen,
    required this.is24Hours,
    this.openTime,
    this.closeTime,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'merchantId', required: true, includeIfNull: false)
  final String merchantId;

  @JsonKey(name: r'dayOfWeek', required: true, includeIfNull: false)
  final DayOfWeek dayOfWeek;

  /// Whether the merchant is open on this day
  @JsonKey(name: r'isOpen', required: true, includeIfNull: false)
  final bool isOpen;

  /// Whether the merchant operates 24 hours on this day
  @JsonKey(name: r'is24Hours', required: true, includeIfNull: false)
  final bool is24Hours;

  /// Opening time (h: 0-23, m: 0-59)
  @JsonKey(name: r'openTime', required: false, includeIfNull: false)
  final Time? openTime;

  /// Closing time (h: 0-23, m: 0-59)
  @JsonKey(name: r'closeTime', required: false, includeIfNull: false)
  final Time? closeTime;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantOperatingHours &&
          other.id == id &&
          other.merchantId == merchantId &&
          other.dayOfWeek == dayOfWeek &&
          other.isOpen == isOpen &&
          other.is24Hours == is24Hours &&
          other.openTime == openTime &&
          other.closeTime == closeTime &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      merchantId.hashCode +
      dayOfWeek.hashCode +
      isOpen.hashCode +
      is24Hours.hashCode +
      openTime.hashCode +
      closeTime.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory MerchantOperatingHours.fromJson(Map<String, dynamic> json) =>
      _$MerchantOperatingHoursFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantOperatingHoursToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
