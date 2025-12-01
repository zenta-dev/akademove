//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_merchant.dart';
import 'package:api_client/src/model/order_status.dart';
import 'package:api_client/src/model/order_type.dart';
import 'package:api_client/src/model/order_note.dart';
import 'package:api_client/src/model/user_gender.dart';
import 'package:api_client/src/model/driver_user.dart';
import 'package:api_client/src/model/order_driver.dart';
import 'package:api_client/src/model/order_item.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_order.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateOrder {
  /// Returns a new [UpdateOrder] instance.
  const UpdateOrder({
     this.driverId,
     this.merchantId,
     this.type,
     this.status,
     this.distanceKm,
     this.tip,
     this.totalPrice,
     this.note,
     this.cancelReason,
     this.gender,
     this.itemCount,
     this.items,
     this.user,
     this.driver,
     this.merchant,
  });

  @JsonKey(name: r'driverId', required: false, includeIfNull: false)
  final String? driverId;
  
  @JsonKey(name: r'merchantId', required: false, includeIfNull: false)
  final String? merchantId;
  
  @JsonKey(name: r'type', required: false, includeIfNull: false)
  final OrderType? type;
  
  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final OrderStatus? status;
  
  @JsonKey(name: r'distanceKm', required: false, includeIfNull: false)
  final num? distanceKm;
  
  @JsonKey(name: r'tip', required: false, includeIfNull: false)
  final num? tip;
  
  @JsonKey(name: r'totalPrice', required: false, includeIfNull: false)
  final num? totalPrice;
  
  @JsonKey(name: r'note', required: false, includeIfNull: false)
  final OrderNote? note;
  
  @JsonKey(name: r'cancelReason', required: false, includeIfNull: false)
  final String? cancelReason;
  
  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final UserGender? gender;
  
  @JsonKey(name: r'itemCount', required: false, includeIfNull: false)
  final num? itemCount;
  
  @JsonKey(name: r'items', required: false, includeIfNull: false)
  final List<OrderItem>? items;
  
  @JsonKey(name: r'user', required: false, includeIfNull: false)
  final DriverUser? user;
  
  @JsonKey(name: r'driver', required: false, includeIfNull: false)
  final OrderDriver? driver;
  
  @JsonKey(name: r'merchant', required: false, includeIfNull: false)
  final OrderMerchant? merchant;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateOrder &&
    other.driverId == driverId &&
    other.merchantId == merchantId &&
    other.type == type &&
    other.status == status &&
    other.distanceKm == distanceKm &&
    other.tip == tip &&
    other.totalPrice == totalPrice &&
    other.note == note &&
    other.cancelReason == cancelReason &&
    other.gender == gender &&
    other.itemCount == itemCount &&
    other.items == items &&
    other.user == user &&
    other.driver == driver &&
    other.merchant == merchant;

  @override
  int get hashCode =>
      driverId.hashCode +
      merchantId.hashCode +
      type.hashCode +
      status.hashCode +
      distanceKm.hashCode +
      tip.hashCode +
      totalPrice.hashCode +
      note.hashCode +
      cancelReason.hashCode +
      gender.hashCode +
      itemCount.hashCode +
      items.hashCode +
      user.hashCode +
      driver.hashCode +
      merchant.hashCode;

  factory UpdateOrder.fromJson(Map<String, dynamic> json) => _$UpdateOrderFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

