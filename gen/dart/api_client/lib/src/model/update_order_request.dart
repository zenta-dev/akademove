//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_note.dart';
import 'package:api_client/src/model/insert_order_request_driver.dart';
import 'package:api_client/src/model/insert_order_request_user.dart';
import 'package:api_client/src/model/insert_order_request_merchant.dart';
import 'package:api_client/src/model/order_item.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_order_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateOrderRequest {
  /// Returns a new [UpdateOrderRequest] instance.
  UpdateOrderRequest({
    this.driverId,

    this.merchantId,

    this.type,

    this.status,

    this.distanceKm,

    this.tip,

    this.totalPrice,

    this.note,

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
  final UpdateOrderRequestTypeEnum? type;

  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final UpdateOrderRequestStatusEnum? status;

  @JsonKey(name: r'distanceKm', required: false, includeIfNull: false)
  final num? distanceKm;

  @JsonKey(name: r'tip', required: false, includeIfNull: false)
  final num? tip;

  @JsonKey(name: r'totalPrice', required: false, includeIfNull: false)
  final num? totalPrice;

  @JsonKey(name: r'note', required: false, includeIfNull: false)
  final OrderNote? note;

  @JsonKey(name: r'itemCount', required: false, includeIfNull: false)
  final num? itemCount;

  @JsonKey(name: r'items', required: false, includeIfNull: false)
  final List<OrderItem>? items;

  @JsonKey(name: r'user', required: false, includeIfNull: false)
  final InsertOrderRequestUser? user;

  @JsonKey(name: r'driver', required: false, includeIfNull: false)
  final InsertOrderRequestDriver? driver;

  @JsonKey(name: r'merchant', required: false, includeIfNull: false)
  final InsertOrderRequestMerchant? merchant;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateOrderRequest &&
          other.driverId == driverId &&
          other.merchantId == merchantId &&
          other.type == type &&
          other.status == status &&
          other.distanceKm == distanceKm &&
          other.tip == tip &&
          other.totalPrice == totalPrice &&
          other.note == note &&
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
      itemCount.hashCode +
      items.hashCode +
      user.hashCode +
      driver.hashCode +
      merchant.hashCode;

  factory UpdateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum UpdateOrderRequestTypeEnum {
  @JsonValue(r'ride')
  ride(r'ride'),
  @JsonValue(r'delivery')
  delivery(r'delivery'),
  @JsonValue(r'food')
  food(r'food');

  const UpdateOrderRequestTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum UpdateOrderRequestStatusEnum {
  @JsonValue(r'requested')
  requested(r'requested'),
  @JsonValue(r'matching')
  matching(r'matching'),
  @JsonValue(r'accepted')
  accepted(r'accepted'),
  @JsonValue(r'arriving')
  arriving(r'arriving'),
  @JsonValue(r'in_trip')
  inTrip(r'in_trip'),
  @JsonValue(r'completed')
  completed(r'completed'),
  @JsonValue(r'cancelled_by_user')
  cancelledByUser(r'cancelled_by_user'),
  @JsonValue(r'cancelled_by_driver')
  cancelledByDriver(r'cancelled_by_driver'),
  @JsonValue(r'cancelled_by_system')
  cancelledBySystem(r'cancelled_by_system');

  const UpdateOrderRequestStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
