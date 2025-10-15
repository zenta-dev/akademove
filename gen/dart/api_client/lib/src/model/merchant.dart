//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/location.dart';
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
  Merchant({
    required this.id,

    required this.userId,

    required this.type,

    required this.name,

    required this.email,

    required this.phone,

    required this.address,

    this.location,

    required this.isActive,

    required this.rating,

    this.document,

    required this.createdAt,

    required this.updatedAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final MerchantTypeEnum type;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final String phone;

  @JsonKey(name: r'address', required: true, includeIfNull: false)
  final String address;

  @JsonKey(name: r'location', required: false, includeIfNull: false)
  final Location? location;

  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;

  @JsonKey(name: r'rating', required: true, includeIfNull: false)
  final num rating;

  @JsonKey(name: r'document', required: false, includeIfNull: false)
  final String? document;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Merchant &&
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

  factory Merchant.fromJson(Map<String, dynamic> json) =>
      _$MerchantFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum MerchantTypeEnum {
  @JsonValue(r'merchant')
  merchant(r'merchant'),
  @JsonValue(r'tenant')
  tenant(r'tenant');

  const MerchantTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
