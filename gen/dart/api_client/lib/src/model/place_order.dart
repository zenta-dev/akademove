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

part 'place_order.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PlaceOrder {
  /// Returns a new [PlaceOrder] instance.
  const PlaceOrder({
    required this.dropoffLocation,
    required this.pickupLocation,
     this.note,
    required this.type,
     this.items,
     this.gender,
    required this.payment,
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
  
  @JsonKey(name: r'payment', required: true, includeIfNull: false)
  final PlaceOrderPayment payment;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is PlaceOrder &&
    other.dropoffLocation == dropoffLocation &&
    other.pickupLocation == pickupLocation &&
    other.note == note &&
    other.type == type &&
    other.items == items &&
    other.gender == gender &&
    other.payment == payment;

  @override
  int get hashCode =>
      dropoffLocation.hashCode +
      pickupLocation.hashCode +
      note.hashCode +
      type.hashCode +
      items.hashCode +
      gender.hashCode +
      payment.hashCode;

  factory PlaceOrder.fromJson(Map<String, dynamic> json) => _$PlaceOrderFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOrderToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

