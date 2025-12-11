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

part 'merchant.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Merchant {
  /// Returns a new [Merchant] instance.
  const Merchant({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
     this.phone,
    required this.address,
     this.location,
    required this.status,
    required this.isActive,
    required this.isOnline,
    required this.operatingStatus,
    required this.activeOrderCount,
    required this.rating,
     this.document,
     this.image,
    required this.category,
    required this.categories,
    required this.bank,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;
  
  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;
  
  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;
  
  @JsonKey(name: r'phone', required: false, includeIfNull: false)
  final Phone? phone;
  
  @JsonKey(name: r'address', required: true, includeIfNull: false)
  final String address;
  
  @JsonKey(name: r'location', required: false, includeIfNull: false)
  final Coordinate? location;
  
      /// Merchant approval status
  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final MerchantStatusEnum status;
  
  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;
  
      /// Whether merchant is currently online/available
  @JsonKey(name: r'isOnline', required: true, includeIfNull: false)
  final bool isOnline;
  
      /// Current operating status (OPEN, CLOSED, BREAK, MAINTENANCE)
  @JsonKey(name: r'operatingStatus', required: true, includeIfNull: false)
  final MerchantOperatingStatusEnum operatingStatus;
  
      /// Number of active orders being processed by merchant
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(name: r'activeOrderCount', required: true, includeIfNull: false)
  final int activeOrderCount;
  
  @JsonKey(name: r'rating', required: true, includeIfNull: false)
  final num rating;
  
  @JsonKey(name: r'document', required: false, includeIfNull: false)
  final String? document;
  
  @JsonKey(name: r'image', required: false, includeIfNull: false)
  final String? image;
  
  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final MerchantCategory category;
  
      /// List of merchant item categories
  @JsonKey(name: r'categories', required: true, includeIfNull: false)
  final List<String> categories;
  
  @JsonKey(name: r'bank', required: true, includeIfNull: false)
  final Bank bank;
  
  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;
  
  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is Merchant &&
    other.id == id &&
    other.userId == userId &&
    other.name == name &&
    other.email == email &&
    other.phone == phone &&
    other.address == address &&
    other.location == location &&
    other.status == status &&
    other.isActive == isActive &&
    other.isOnline == isOnline &&
    other.operatingStatus == operatingStatus &&
    other.activeOrderCount == activeOrderCount &&
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
      status.hashCode +
      isActive.hashCode +
      isOnline.hashCode +
      operatingStatus.hashCode +
      activeOrderCount.hashCode +
      rating.hashCode +
      document.hashCode +
      image.hashCode +
      category.hashCode +
      categories.hashCode +
      bank.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory Merchant.fromJson(Map<String, dynamic> json) => _$MerchantFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}
/// Merchant approval status
enum MerchantStatusEnum {
      /// Merchant approval status
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
      /// Merchant approval status
  @JsonValue(r'APPROVED')
  APPROVED(r'APPROVED'),
      /// Merchant approval status
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED'),
      /// Merchant approval status
  @JsonValue(r'ACTIVE')
  ACTIVE(r'ACTIVE'),
      /// Merchant approval status
  @JsonValue(r'INACTIVE')
  INACTIVE(r'INACTIVE'),
      /// Merchant approval status
  @JsonValue(r'SUSPENDED')
  SUSPENDED(r'SUSPENDED');
  
  const MerchantStatusEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}
/// Current operating status (OPEN, CLOSED, BREAK, MAINTENANCE)
enum MerchantOperatingStatusEnum {
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
  
  const MerchantOperatingStatusEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

