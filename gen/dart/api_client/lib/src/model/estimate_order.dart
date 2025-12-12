//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_type.dart';
import 'package:api_client/src/model/coordinate.dart';
import 'package:api_client/src/model/order_note.dart';
import 'package:api_client/src/model/user_gender.dart';
import 'package:api_client/src/model/order_item.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'estimate_order.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EstimateOrder {
  /// Returns a new [EstimateOrder] instance.
  const EstimateOrder({
    required this.dropoffLocation,
    required this.pickupLocation,
     this.note,
    required this.type,
    this.items,
    this.gender,·
  
  @JsonKey(name: r'note', required: false, includeIfNull: false)
  final OrderNote? note;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final OrderType type;

  @JsonKey(name: r'items', required: false, includeIfNull: false)
  final List<OrderItem>? items;

  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final UserGender? gender;

  @JsonKey(name: r'genderPreference', required: false, includeIfNull: false)
  final EstimateOrderGenderPreferenceEnum? genderPreference;

  @JsonKey(name: r'couponCode', required: false, includeIfNull: false)
  final String? couponCode;

  @JsonKey(name: r'discountIds', required: false, includeIfNull: false)
  final List<int>? discountIds;

  // minimum: 0
  // maximum: 20
  @JsonKey(name: r'weight', required: false, includeIfNull: false)
  final int? weight;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EstimateOrder &&
    other.dropoffLocation == dropoffLocation &&
    other.pickupLocation == pickupLocation &&
    other.note == note &&
    other.type == type &&
    other.items == items &&
    other.gender == gender &&
    other.genderPreference == genderPreference &&
    other.couponCode == couponCode &&
    other.discountIds == discountIds &&
    other.weight == weight;

  @override
  int get hashCode =>
      dropoffLocation.hashCode +
      pickupLocation.hashCode +
      pickupAddress.hashCode +
      dropoffAddress.hashCode +
      note.hashCode +
      type.hashCode +
      items.hashCode +
      gender.hashCode +
      genderPreference.hashCode +
      couponCode.hashCode +
      discountIds.hashCode +
      weight.hashCode;

  factory EstimateOrder.fromJson(Map<String, dynamic> json) =>
      _$EstimateOrderFromJson(json);

  Map<String, dynamic> toJson() => _$EstimateOrderToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum EstimateOrderGenderPreferenceEnum {
  @JsonValue(r'SAME')
  SAME(r'SAME'),
  @JsonValue(r'ANY')
  ANY(r'ANY');

  const EstimateOrderGenderPreferenceEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
