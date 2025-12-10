//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_type.dart';
import 'package:api_client/src/model/user_gender.dart';
import 'package:api_client/src/model/order_item.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_estimate_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderEstimateRequest {
  /// Returns a new [OrderEstimateRequest] instance.
  const OrderEstimateRequest({
    required this.dropoffLocationX,
    required this.dropoffLocationY,
    required this.pickupLocationX,
    required this.pickupLocationY,
     this.notePickup,
     this.noteSenderName,
     this.noteSenderPhone,
     this.notePickupInstructions,
     this.noteDropoff,
     this.noteRecevierName,
     this.noteRecevierPhone,
     this.noteDropoffInstructions,
    required this.type,
     this.items,
     this.gender,
     this.genderPreference,
     this.couponCode,
     this.discountIds,
     this.weight,
  });
      /// Longitude (X-axis, East-West)
          // minimum: -180
          // maximum: 180
  @JsonKey(name: r'dropoffLocation_x', required: true, includeIfNull: false)
  final num dropoffLocationX;
  
      /// Latitude (Y-axis, North-South)
          // minimum: -90
          // maximum: 90
  @JsonKey(name: r'dropoffLocation_y', required: true, includeIfNull: false)
  final num dropoffLocationY;
  
      /// Longitude (X-axis, East-West)
          // minimum: -180
          // maximum: 180
  @JsonKey(name: r'pickupLocation_x', required: true, includeIfNull: false)
  final num pickupLocationX;
  
      /// Latitude (Y-axis, North-South)
          // minimum: -90
          // maximum: 90
  @JsonKey(name: r'pickupLocation_y', required: true, includeIfNull: false)
  final num pickupLocationY;
  
  @JsonKey(name: r'note_pickup', required: false, includeIfNull: false)
  final String? notePickup;
  
  @JsonKey(name: r'note_senderName', required: false, includeIfNull: false)
  final String? noteSenderName;
  
  @JsonKey(name: r'note_senderPhone', required: false, includeIfNull: false)
  final String? noteSenderPhone;
  
  @JsonKey(name: r'note_pickupInstructions', required: false, includeIfNull: false)
  final String? notePickupInstructions;
  
  @JsonKey(name: r'note_dropoff', required: false, includeIfNull: false)
  final String? noteDropoff;
  
  @JsonKey(name: r'note_recevierName', required: false, includeIfNull: false)
  final String? noteRecevierName;
  
  @JsonKey(name: r'note_recevierPhone', required: false, includeIfNull: false)
  final String? noteRecevierPhone;
  
  @JsonKey(name: r'note_dropoffInstructions', required: false, includeIfNull: false)
  final String? noteDropoffInstructions;
  
  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final OrderType type;
  
  @JsonKey(name: r'items', required: false, includeIfNull: false)
  final List<OrderItem>? items;
  
  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final UserGender? gender;
  
  @JsonKey(name: r'genderPreference', required: false, includeIfNull: false)
  final OrderEstimateRequestGenderPreferenceEnum? genderPreference;
  
  @JsonKey(name: r'couponCode', required: false, includeIfNull: false)
  final String? couponCode;
  
  @JsonKey(name: r'discountIds', required: false, includeIfNull: false)
  final List<num>? discountIds;
  
          // maximum: 20
  @JsonKey(name: r'weight', required: false, includeIfNull: false)
  final num? weight;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderEstimateRequest &&
    other.dropoffLocationX == dropoffLocationX &&
    other.dropoffLocationY == dropoffLocationY &&
    other.pickupLocationX == pickupLocationX &&
    other.pickupLocationY == pickupLocationY &&
    other.notePickup == notePickup &&
    other.noteSenderName == noteSenderName &&
    other.noteSenderPhone == noteSenderPhone &&
    other.notePickupInstructions == notePickupInstructions &&
    other.noteDropoff == noteDropoff &&
    other.noteRecevierName == noteRecevierName &&
    other.noteRecevierPhone == noteRecevierPhone &&
    other.noteDropoffInstructions == noteDropoffInstructions &&
    other.type == type &&
    other.items == items &&
    other.gender == gender &&
    other.genderPreference == genderPreference &&
    other.couponCode == couponCode &&
    other.discountIds == discountIds &&
    other.weight == weight;

  @override
  int get hashCode =>
      dropoffLocationX.hashCode +
      dropoffLocationY.hashCode +
      pickupLocationX.hashCode +
      pickupLocationY.hashCode +
      (notePickup == null ? 0 : notePickup.hashCode) +
      (noteSenderName == null ? 0 : noteSenderName.hashCode) +
      (noteSenderPhone == null ? 0 : noteSenderPhone.hashCode) +
      (notePickupInstructions == null ? 0 : notePickupInstructions.hashCode) +
      (noteDropoff == null ? 0 : noteDropoff.hashCode) +
      (noteRecevierName == null ? 0 : noteRecevierName.hashCode) +
      (noteRecevierPhone == null ? 0 : noteRecevierPhone.hashCode) +
      (noteDropoffInstructions == null ? 0 : noteDropoffInstructions.hashCode) +
      type.hashCode +
      items.hashCode +
      gender.hashCode +
      genderPreference.hashCode +
      (couponCode == null ? 0 : couponCode.hashCode) +
      discountIds.hashCode +
      weight.hashCode;

  factory OrderEstimateRequest.fromJson(Map<String, dynamic> json) => _$OrderEstimateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEstimateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum OrderEstimateRequestGenderPreferenceEnum {
  @JsonValue(r'SAME')
  SAME(r'SAME'),
  @JsonValue(r'ANY')
  ANY(r'ANY');
  
  const OrderEstimateRequestGenderPreferenceEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

