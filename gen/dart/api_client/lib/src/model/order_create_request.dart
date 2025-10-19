//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_create_request_note.dart';
import 'package:api_client/src/model/location.dart';
import 'package:api_client/src/model/order_create_request_user.dart';
import 'package:api_client/src/model/order_create_request_merchant.dart';
import 'package:api_client/src/model/order_create_request_driver.dart';
import 'package:api_client/src/model/order_create_request_items_inner.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_create_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderCreateRequest {
  /// Returns a new [OrderCreateRequest] instance.
  OrderCreateRequest({

    required  this.userId,

     this.driverId,

     this.merchantId,

    required  this.type,

    required  this.status,

    required  this.pickupLocation,

    required  this.dropoffLocation,

    required  this.distanceKm,

    required  this.basePrice,

     this.tip,

    required  this.totalPrice,

     this.note,

     this.itemCount,

     this.items,

     this.user,

     this.driver,

     this.merchant,
  });

  @JsonKey(
    
    name: r'userId',
    required: true,
    includeIfNull: false,
  )


  final String userId;



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
    required: true,
    includeIfNull: false,
  )


  final OrderCreateRequestTypeEnum type;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final OrderCreateRequestStatusEnum status;



  @JsonKey(
    
    name: r'pickupLocation',
    required: true,
    includeIfNull: false,
  )


  final Location pickupLocation;



  @JsonKey(
    
    name: r'dropoffLocation',
    required: true,
    includeIfNull: false,
  )


  final Location dropoffLocation;



  @JsonKey(
    
    name: r'distanceKm',
    required: true,
    includeIfNull: false,
  )


  final num distanceKm;



  @JsonKey(
    
    name: r'basePrice',
    required: true,
    includeIfNull: false,
  )


  final num basePrice;



  @JsonKey(
    
    name: r'tip',
    required: false,
    includeIfNull: false,
  )


  final num? tip;



  @JsonKey(
    
    name: r'totalPrice',
    required: true,
    includeIfNull: false,
  )


  final num totalPrice;



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
    bool operator ==(Object other) => identical(this, other) || other is OrderCreateRequest &&
      other.userId == userId &&
      other.driverId == driverId &&
      other.merchantId == merchantId &&
      other.type == type &&
      other.status == status &&
      other.pickupLocation == pickupLocation &&
      other.dropoffLocation == dropoffLocation &&
      other.distanceKm == distanceKm &&
      other.basePrice == basePrice &&
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
        userId.hashCode +
        driverId.hashCode +
        merchantId.hashCode +
        type.hashCode +
        status.hashCode +
        pickupLocation.hashCode +
        dropoffLocation.hashCode +
        distanceKm.hashCode +
        basePrice.hashCode +
        tip.hashCode +
        totalPrice.hashCode +
        note.hashCode +
        itemCount.hashCode +
        items.hashCode +
        user.hashCode +
        driver.hashCode +
        merchant.hashCode;

  factory OrderCreateRequest.fromJson(Map<String, dynamic> json) => _$OrderCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum OrderCreateRequestTypeEnum {
@JsonValue(r'ride')
ride(r'ride'),
@JsonValue(r'delivery')
delivery(r'delivery'),
@JsonValue(r'food')
food(r'food');

const OrderCreateRequestTypeEnum(this.value);

final String value;

@override
String toString() => value;
}



enum OrderCreateRequestStatusEnum {
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

const OrderCreateRequestStatusEnum(this.value);

final String value;

@override
String toString() => value;
}


