//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coordinate.dart';
import 'package:api_client/src/model/merchant_category.dart';
import 'package:api_client/src/model/bank.dart';
import 'package:api_client/src/model/phone.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_merchant.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderMerchant {
  /// Returns a new [OrderMerchant] instance.
  const OrderMerchant({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.location,
    this.isActive,
    this.isOnline,
    this.isTakingOrders,
    this.operatingStatus,
    this.rating,
    this.document,
    this.image,
    this.category,
    this.categories,
    this.bank,
    this.createdAt,
    this.updatedAt,
  });
  @JsonKey(name: r'id', required: false, includeIfNull: false)
  final String? id;

  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'email', required: false, includeIfNull: false)
  final String? email;

  @JsonKey(name: r'phone', required: false, includeIfNull: false)
  final Phone? phone;

  @JsonKey(name: r'address', required: false, includeIfNull: false)
  final String? address;

  @JsonKey(name: r'location', required: false, includeIfNull: false)
  final Coordinate? location;

  @JsonKey(name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;

  /// Whether merchant is currently online/available
  @JsonKey(name: r'isOnline', required: false, includeIfNull: false)
  final bool? isOnline;

  /// Whether merchant is actively taking orders (subset of online)
  @JsonKey(name: r'isTakingOrders', required: false, includeIfNull: false)
  final bool? isTakingOrders;

  /// Current operating status (OPEN, CLOSED, BREAK, MAINTENANCE)
  @JsonKey(name: r'operatingStatus', required: false, includeIfNull: false)
  final OrderMerchantOperatingStatusEnum? operatingStatus;

  @JsonKey(name: r'rating', required: false, includeIfNull: false)
  final num? rating;

  @JsonKey(name: r'document', required: false, includeIfNull: false)
  final String? document;

  @JsonKey(name: r'image', required: false, includeIfNull: false)
  final String? image;

  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final MerchantCategory? category;

  /// List of merchant item categories
  @JsonKey(name: r'categories', required: false, includeIfNull: false)
  final List<String>? categories;

  @JsonKey(name: r'bank', required: false, includeIfNull: false)
  final Bank? bank;

  @JsonKey(name: r'createdAt', required: false, includeIfNull: false)
  final DateTime? createdAt;

  @JsonKey(name: r'updatedAt', required: false, includeIfNull: false)
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderMerchant &&
          other.id == id &&
          other.userId == userId &&
          other.name == name &&
          other.email == email &&
          other.phone == phone &&
          other.address == address &&
          other.location == location &&
          other.isActive == isActive &&
          other.isOnline == isOnline &&
          other.isTakingOrders == isTakingOrders &&
          other.operatingStatus == operatingStatus &&
          other.rating == rating &&
          other.document == document &&
          other.image == image &&
          other.category == category &&
          other.categories == categories &&
          other.bank == bank &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      userId.hashCode +
      name.hashCode +
      email.hashCode +
      phone.hashCode +
      address.hashCode +
      location.hashCode +
      isActive.hashCode +
      isOnline.hashCode +
      isTakingOrders.hashCode +
      operatingStatus.hashCode +
      rating.hashCode +
      document.hashCode +
      image.hashCode +
      category.hashCode +
      categories.hashCode +
      bank.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory OrderMerchant.fromJson(Map<String, dynamic> json) =>
      _$OrderMerchantFromJson(json);

  Map<String, dynamic> toJson() => _$OrderMerchantToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

/// Current operating status (OPEN, CLOSED, BREAK, MAINTENANCE)
enum OrderMerchantOperatingStatusEnum {
  /// Current operating status (OPEN, CLOSED, BREAK, MAINTENANCE)
  @JsonValue(r'OPEN')
  OPEN(r'OPEN'),

  /// Current operating status (OPEN, CLOSED, BREAK, MAINTENANCE)
  @JsonValue(r'CLOSED')
  CLOSED(r'CLOSED'),

  /// Current operating status (OPEN, CLOSED, BREAK, MAINTENANCE)
  @JsonValue(r'BREAK')
  BREAK(r'BREAK'),

  /// Current operating status (OPEN, CLOSED, BREAK, MAINTENANCE)
  @JsonValue(r'MAINTENANCE')
  MAINTENANCE(r'MAINTENANCE');

  const OrderMerchantOperatingStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
