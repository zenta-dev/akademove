//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_merchant.dart';
import 'package:api_client/src/model/order_status.dart';
import 'package:api_client/src/model/order_type.dart';
import 'package:api_client/src/model/coordinate.dart';
import 'package:api_client/src/model/order_note.dart';
import 'package:api_client/src/model/user_gender.dart';
import 'package:api_client/src/model/driver_user.dart';
import 'package:api_client/src/model/order_driver.dart';
import 'package:api_client/src/model/order_item.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Order {
  /// Returns a new [Order] instance.
  const Order({
    required this.id,
    required this.userId,
    this.driverId,
    this.merchantId,
    required this.type,
    required this.status,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.distanceKm,
    required this.basePrice,
    this.tip,
    required this.totalPrice,
    this.platformCommission,
    this.driverEarning,
    this.merchantCommission,
    this.couponId,
    this.couponCode,
    this.discountAmount,
    this.note,
    required this.requestedAt,
    this.acceptedAt,
    this.preparedAt,
    this.readyAt,
    this.arrivedAt,
    this.cancelReason,
    required this.createdAt,
    required this.updatedAt,
    this.gender,
    this.genderPreference,
    this.proofOfDeliveryUrl,
    this.deliveryOtp,
    this.otpVerifiedAt,
    this.itemCount,
    this.items,
    this.user,
    this.driver,
    this.merchant,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'driverId', required: false, includeIfNull: false)
  final String? driverId;

  @JsonKey(name: r'merchantId', required: false, includeIfNull: false)
  final String? merchantId;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final OrderType type;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final OrderStatus status;

  @JsonKey(name: r'pickupLocation', required: true, includeIfNull: false)
  final Coordinate pickupLocation;

  @JsonKey(name: r'dropoffLocation', required: true, includeIfNull: false)
  final Coordinate dropoffLocation;

  @JsonKey(name: r'distanceKm', required: true, includeIfNull: false)
  final num distanceKm;

  @JsonKey(name: r'basePrice', required: true, includeIfNull: false)
  final num basePrice;

  @JsonKey(name: r'tip', required: false, includeIfNull: false)
  final num? tip;

  @JsonKey(name: r'totalPrice', required: true, includeIfNull: false)
  final num totalPrice;

  @JsonKey(name: r'platformCommission', required: false, includeIfNull: false)
  final num? platformCommission;

  @JsonKey(name: r'driverEarning', required: false, includeIfNull: false)
  final num? driverEarning;

  @JsonKey(name: r'merchantCommission', required: false, includeIfNull: false)
  final num? merchantCommission;

  @JsonKey(name: r'couponId', required: false, includeIfNull: false)
  final String? couponId;

  @JsonKey(name: r'couponCode', required: false, includeIfNull: false)
  final String? couponCode;

  @JsonKey(name: r'discountAmount', required: false, includeIfNull: false)
  final num? discountAmount;

  @JsonKey(name: r'note', required: false, includeIfNull: false)
  final OrderNote? note;

  @JsonKey(name: r'requestedAt', required: true, includeIfNull: false)
  final DateTime requestedAt;

  @JsonKey(name: r'acceptedAt', required: false, includeIfNull: false)
  final DateTime? acceptedAt;

  @JsonKey(name: r'preparedAt', required: false, includeIfNull: false)
  final DateTime? preparedAt;

  @JsonKey(name: r'readyAt', required: false, includeIfNull: false)
  final DateTime? readyAt;

  @JsonKey(name: r'arrivedAt', required: false, includeIfNull: false)
  final DateTime? arrivedAt;

  @JsonKey(name: r'cancelReason', required: false, includeIfNull: false)
  final String? cancelReason;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final UserGender? gender;

  @JsonKey(name: r'genderPreference', required: false, includeIfNull: false)
  final OrderGenderPreferenceEnum? genderPreference;

  @JsonKey(name: r'proofOfDeliveryUrl', required: false, includeIfNull: false)
  final String? proofOfDeliveryUrl;

  @JsonKey(name: r'deliveryOtp', required: false, includeIfNull: false)
  final String? deliveryOtp;

  @JsonKey(name: r'otpVerifiedAt', required: false, includeIfNull: false)
  final DateTime? otpVerifiedAt;

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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          other.id == id &&
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
          other.platformCommission == platformCommission &&
          other.driverEarning == driverEarning &&
          other.merchantCommission == merchantCommission &&
          other.couponId == couponId &&
          other.couponCode == couponCode &&
          other.discountAmount == discountAmount &&
          other.note == note &&
          other.requestedAt == requestedAt &&
          other.acceptedAt == acceptedAt &&
          other.preparedAt == preparedAt &&
          other.readyAt == readyAt &&
          other.arrivedAt == arrivedAt &&
          other.cancelReason == cancelReason &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.gender == gender &&
          other.genderPreference == genderPreference &&
          other.proofOfDeliveryUrl == proofOfDeliveryUrl &&
          other.deliveryOtp == deliveryOtp &&
          other.otpVerifiedAt == otpVerifiedAt &&
          other.itemCount == itemCount &&
          other.items == items &&
          other.user == user &&
          other.driver == driver &&
          other.merchant == merchant;

  @override
  int get hashCode =>
      id.hashCode +
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
      platformCommission.hashCode +
      driverEarning.hashCode +
      merchantCommission.hashCode +
      couponId.hashCode +
      couponCode.hashCode +
      discountAmount.hashCode +
      note.hashCode +
      requestedAt.hashCode +
      acceptedAt.hashCode +
      preparedAt.hashCode +
      readyAt.hashCode +
      arrivedAt.hashCode +
      cancelReason.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode +
      gender.hashCode +
      genderPreference.hashCode +
      proofOfDeliveryUrl.hashCode +
      deliveryOtp.hashCode +
      otpVerifiedAt.hashCode +
      itemCount.hashCode +
      items.hashCode +
      user.hashCode +
      driver.hashCode +
      merchant.hashCode;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum OrderGenderPreferenceEnum {
  @JsonValue(r'SAME')
  SAME(r'SAME'),
  @JsonValue(r'ANY')
  ANY(r'ANY');

  const OrderGenderPreferenceEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
