//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_create_request_note.dart';
import 'package:api_client/src/model/order_create_request_user.dart';
import 'package:api_client/src/model/order_create_request_merchant.dart';
import 'package:api_client/src/model/order_create_request_driver.dart';
import 'package:api_client/src/model/order_create_request_items_inner.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_update_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderUpdateRequest {
  /// Returns a new [OrderUpdateRequest] instance.
  OrderUpdateRequest({

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

  @JsonKey(
    
    name: r'driverId',
    required: false,
    includeIfNull: false,
  )


  final String? driverId;



  @JsonKey(
    
    name: r'merchantId',
    required: false,
    includeIfNull: false,
  )


  final String? merchantId;



  @JsonKey(
    
    name: r'type',
    required: false,
    includeIfNull: false,
  )


  final OrderUpdateRequestTypeEnum? type;



  @JsonKey(
    
    name: r'status',
    required: false,
    includeIfNull: false,
  )


  final OrderUpdateRequestStatusEnum? status;



  @JsonKey(
    
    name: r'distanceKm',
    required: false,
    includeIfNull: false,
  )


  final num? distanceKm;



  @JsonKey(
    
    name: r'tip',
    required: false,
    includeIfNull: false,
  )


  final num? tip;



  @JsonKey(
    
    name: r'totalPrice',
    required: false,
    includeIfNull: false,
  )


  final num? totalPrice;



  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final OrderCreateRequestNote? note;



  @JsonKey(
    
    name: r'itemCount',
    required: false,
    includeIfNull: false,
  )


  final num? itemCount;



  @JsonKey(
    
    name: r'items',
    required: false,
    includeIfNull: false,
  )


  final List<OrderCreateRequestItemsInner>? items;



  @JsonKey(
    
    name: r'user',
    required: false,
    includeIfNull: false,
  )


  final OrderCreateRequestUser? user;



  @JsonKey(
    
    name: r'driver',
    required: false,
    includeIfNull: false,
  )


  final OrderCreateRequestDriver? driver;



  @JsonKey(
    
    name: r'merchant',
    required: false,
    includeIfNull: false,
  )


  final OrderCreateRequestMerchant? merchant;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderUpdateRequest &&
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

  factory OrderUpdateRequest.fromJson(Map<String, dynamic> json) => _$OrderUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderUpdateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum OrderUpdateRequestTypeEnum {
@JsonValue(r'ride')
ride(r'ride'),
@JsonValue(r'delivery')
delivery(r'delivery'),
@JsonValue(r'food')
food(r'food');

const OrderUpdateRequestTypeEnum(this.value);

final String value;

@override
String toString() => value;
}



enum OrderUpdateRequestStatusEnum {
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

const OrderUpdateRequestStatusEnum(this.value);

final String value;

@override
String toString() => value;
}


