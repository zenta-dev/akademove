//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coordinate.dart';
import 'package:api_client/src/model/bank.dart';
import 'package:api_client/src/model/phone.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_place_order200_response_data_merchant.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderPlaceOrder200ResponseDataMerchant {
  /// Returns a new [OrderPlaceOrder200ResponseDataMerchant] instance.
  const OrderPlaceOrder200ResponseDataMerchant({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.location,
    this.isActive,
    this.rating,
    this.document,
    this.image,
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

  @JsonKey(name: r'rating', required: false, includeIfNull: false)
  final num? rating;

  @JsonKey(name: r'document', required: false, includeIfNull: false)
  final String? document;

  @JsonKey(name: r'image', required: false, includeIfNull: false)
  final String? image;

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
      other is OrderPlaceOrder200ResponseDataMerchant &&
          other.id == id &&
          other.userId == userId &&
          other.name == name &&
          other.email == email &&
          other.phone == phone &&
          other.address == address &&
          other.location == location &&
          other.isActive == isActive &&
          other.rating == rating &&
          other.document == document &&
          other.image == image &&
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
      rating.hashCode +
      document.hashCode +
      image.hashCode +
      categories.hashCode +
      bank.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory OrderPlaceOrder200ResponseDataMerchant.fromJson(
    Map<String, dynamic> json,
  ) => _$OrderPlaceOrder200ResponseDataMerchantFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OrderPlaceOrder200ResponseDataMerchantToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
