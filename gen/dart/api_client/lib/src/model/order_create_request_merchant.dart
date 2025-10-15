//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/location.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_create_request_merchant.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderCreateRequestMerchant {
  /// Returns a new [OrderCreateRequestMerchant] instance.
  OrderCreateRequestMerchant({
    this.id,

    this.userId,

    this.type,

    this.name,

    this.email,

    this.phone,

    this.address,

    this.location,

    this.isActive,

    this.rating,

    this.document,

    this.createdAt,

    this.updatedAt,
  });

  @JsonKey(name: r'id', required: false, includeIfNull: false)
  final String? id;

  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;

  @JsonKey(name: r'type', required: false, includeIfNull: false)
  final OrderCreateRequestMerchantTypeEnum? type;

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'email', required: false, includeIfNull: false)
  final String? email;

  @JsonKey(name: r'phone', required: false, includeIfNull: false)
  final String? phone;

  @JsonKey(name: r'address', required: false, includeIfNull: false)
  final String? address;

  @JsonKey(name: r'location', required: false, includeIfNull: false)
  final Location? location;

  @JsonKey(name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;

  @JsonKey(name: r'rating', required: false, includeIfNull: false)
  final num? rating;

  @JsonKey(name: r'document', required: false, includeIfNull: false)
  final String? document;

  @JsonKey(name: r'createdAt', required: false, includeIfNull: false)
  final DateTime? createdAt;

  @JsonKey(name: r'updatedAt', required: false, includeIfNull: false)
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderCreateRequestMerchant &&
          other.id == id &&
          other.userId == userId &&
          other.type == type &&
          other.name == name &&
          other.email == email &&
          other.phone == phone &&
          other.address == address &&
          other.location == location &&
          other.isActive == isActive &&
          other.rating == rating &&
          other.document == document &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      userId.hashCode +
      type.hashCode +
      name.hashCode +
      email.hashCode +
      phone.hashCode +
      address.hashCode +
      location.hashCode +
      isActive.hashCode +
      rating.hashCode +
      document.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory OrderCreateRequestMerchant.fromJson(Map<String, dynamic> json) =>
      _$OrderCreateRequestMerchantFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateRequestMerchantToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum OrderCreateRequestMerchantTypeEnum {
  @JsonValue(r'merchant')
  merchant(r'merchant'),
  @JsonValue(r'tenant')
  tenant(r'tenant');

  const OrderCreateRequestMerchantTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
