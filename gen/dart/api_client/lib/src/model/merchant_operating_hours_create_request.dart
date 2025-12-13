//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/day_of_week.dart';
import 'package:api_client/src/model/time.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_operating_hours_create_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantOperatingHoursCreateRequest {
  /// Returns a new [MerchantOperatingHoursCreateRequest] instance.
  const MerchantOperatingHoursCreateRequest({
    required this.dayOfWeek,
    required this.isOpen,
    required this.is24Hours,
     this.openTime,
     this.closeTime,
  });
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
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is MerchantOperatingHoursCreateRequest &&
    other.dayOfWeek == dayOfWeek &&
    other.isOpen == isOpen &&
    other.is24Hours == is24Hours &&
    other.openTime == openTime &&
    other.closeTime == closeTime;

  @override
  int get hashCode =>
      dayOfWeek.hashCode +
      isOpen.hashCode +
      is24Hours.hashCode +
      openTime.hashCode +
      closeTime.hashCode;

  factory MerchantOperatingHoursCreateRequest.fromJson(Map<String, dynamic> json) => _$MerchantOperatingHoursCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantOperatingHoursCreateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

