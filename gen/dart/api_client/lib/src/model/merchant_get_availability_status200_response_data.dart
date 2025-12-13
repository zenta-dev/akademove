//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_get_availability_status200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantGetAvailabilityStatus200ResponseData {
  /// Returns a new [MerchantGetAvailabilityStatus200ResponseData] instance.
  const MerchantGetAvailabilityStatus200ResponseData({
    required this.id,
    required this.isOnline,
    required this.operatingStatus,
    required this.activeOrderCount,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @JsonKey(name: r'isOnline', required: true, includeIfNull: false)
  final bool isOnline;
  
      /// Merchant operating status
  @JsonKey(name: r'operatingStatus', required: true, includeIfNull: false)
  final MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnum operatingStatus;
  
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(name: r'activeOrderCount', required: true, includeIfNull: false)
  final int activeOrderCount;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is MerchantGetAvailabilityStatus200ResponseData &&
    other.id == id &&
    other.isOnline == isOnline &&
    other.operatingStatus == operatingStatus &&
    other.activeOrderCount == activeOrderCount;

  @override
  int get hashCode =>
      id.hashCode +
      isOnline.hashCode +
      operatingStatus.hashCode +
      activeOrderCount.hashCode;

  factory MerchantGetAvailabilityStatus200ResponseData.fromJson(Map<String, dynamic> json) => _$MerchantGetAvailabilityStatus200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantGetAvailabilityStatus200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}
/// Merchant operating status
enum MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnum {
      /// Merchant operating status
  @JsonValue(r'OPEN')
  OPEN(r'OPEN'),
      /// Merchant operating status
  @JsonValue(r'CLOSED')
  CLOSED(r'CLOSED'),
      /// Merchant operating status
  @JsonValue(r'BREAK')
  BREAK(r'BREAK'),
      /// Merchant operating status
  @JsonValue(r'MAINTENANCE')
  MAINTENANCE(r'MAINTENANCE');
  
  const MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

