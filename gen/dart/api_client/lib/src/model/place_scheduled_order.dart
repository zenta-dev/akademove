//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_type.dart';
import 'package:api_client/src/model/coordinate.dart';
import 'package:api_client/src/model/order_note.dart';
import 'package:api_client/src/model/user_gender.dart';
import 'package:api_client/src/model/order_item.dart';
import 'package:api_client/src/model/place_order_payment.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'place_scheduled_order.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PlaceScheduledOrder {
  /// Returns a new [PlaceScheduledOrder] instance.
  const PlaceScheduledOrder({
    required this.dropoffLocation,
    required this.pickupLocation,
    this.note,
    required this.type,
    this.items,
    this.gender,
    this.genderPreference,
    this.couponCode,
    required this.payment,
    required this.scheduledAt,
  });
  @JsonKey(name: r'dropoffLocation', required: true, includeIfNull: false)
  final Coordinate dropoffLocation;

  @JsonKey(name: r'pickupLocation', required: true, includeIfNull: false)
  final Coordinate pickupLocation;

  @JsonKey(name: r'note', required: false, includeIfNull: false)
  final OrderNote? note;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final OrderType type;

  @JsonKey(name: r'items', required: false, includeIfNull: false)
  final List<OrderItem>? items;

  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final UserGender? gender;

  @JsonKey(name: r'genderPreference', required: false, includeIfNull: false)
  final PlaceScheduledOrderGenderPreferenceEnum? genderPreference;

  @JsonKey(name: r'couponCode', required: false, includeIfNull: false)
  final String? couponCode;

  @JsonKey(name: r'payment', required: true, includeIfNull: false)
  final PlaceOrderPayment payment;

  @JsonKey(name: r'scheduledAt', required: true, includeIfNull: false)
  final DateTime scheduledAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceScheduledOrder &&
          other.dropoffLocation == dropoffLocation &&
          other.pickupLocation == pickupLocation &&
          other.note == note &&
          other.type == type &&
          other.items == items &&
          other.gender == gender &&
          other.genderPreference == genderPreference &&
          other.couponCode == couponCode &&
          other.payment == payment &&
          other.scheduledAt == scheduledAt;

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
      payment.hashCode +
      scheduledAt.hashCode;

  factory PlaceScheduledOrder.fromJson(Map<String, dynamic> json) =>
      _$PlaceScheduledOrderFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceScheduledOrderToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum PlaceScheduledOrderGenderPreferenceEnum {
  @JsonValue(r'SAME')
  SAME(r'SAME'),
  @JsonValue(r'ANY')
  ANY(r'ANY');

  const PlaceScheduledOrderGenderPreferenceEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
