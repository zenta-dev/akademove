//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/location.dart';
import 'package:api_client/src/model/order_create_request_user.dart';
import 'package:api_client/src/model/bank.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_create_request_driver.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderCreateRequestDriver {
  /// Returns a new [OrderCreateRequestDriver] instance.
  OrderCreateRequestDriver({
    this.id,

    this.userId,

    this.studentId,

    this.licensePlate,

    this.status,

    this.rating,

    this.isOnline,

    this.currentLocation,

    this.lastLocationUpdate,

    this.createdAt,

    this.studentCard,

    this.driverLicense,

    this.vehicleCertificate,

    this.bank,

    this.user,
  });

  @JsonKey(name: r'id', required: false, includeIfNull: false)
  final String? id;

  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;

  @JsonKey(name: r'studentId', required: false, includeIfNull: false)
  final num? studentId;

  @JsonKey(name: r'licensePlate', required: false, includeIfNull: false)
  final String? licensePlate;

  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final OrderCreateRequestDriverStatusEnum? status;

  @JsonKey(name: r'rating', required: false, includeIfNull: false)
  final num? rating;

  @JsonKey(name: r'isOnline', required: false, includeIfNull: false)
  final bool? isOnline;

  @JsonKey(name: r'currentLocation', required: false, includeIfNull: false)
  final Location? currentLocation;

  @JsonKey(name: r'lastLocationUpdate', required: false, includeIfNull: false)
  final DateTime? lastLocationUpdate;

  @JsonKey(name: r'createdAt', required: false, includeIfNull: false)
  final DateTime? createdAt;

  @JsonKey(name: r'studentCard', required: false, includeIfNull: false)
  final String? studentCard;

  @JsonKey(name: r'driverLicense', required: false, includeIfNull: false)
  final String? driverLicense;

  @JsonKey(name: r'vehicleCertificate', required: false, includeIfNull: false)
  final String? vehicleCertificate;

  @JsonKey(name: r'bank', required: false, includeIfNull: false)
  final Bank? bank;

  @JsonKey(name: r'user', required: false, includeIfNull: false)
  final OrderCreateRequestUser? user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderCreateRequestDriver &&
          other.id == id &&
          other.userId == userId &&
          other.studentId == studentId &&
          other.licensePlate == licensePlate &&
          other.status == status &&
          other.rating == rating &&
          other.isOnline == isOnline &&
          other.currentLocation == currentLocation &&
          other.lastLocationUpdate == lastLocationUpdate &&
          other.createdAt == createdAt &&
          other.studentCard == studentCard &&
          other.driverLicense == driverLicense &&
          other.vehicleCertificate == vehicleCertificate &&
          other.bank == bank &&
          other.user == user;

  @override
  int get hashCode =>
      id.hashCode +
      userId.hashCode +
      studentId.hashCode +
      licensePlate.hashCode +
      status.hashCode +
      rating.hashCode +
      isOnline.hashCode +
      currentLocation.hashCode +
      lastLocationUpdate.hashCode +
      createdAt.hashCode +
      studentCard.hashCode +
      driverLicense.hashCode +
      vehicleCertificate.hashCode +
      bank.hashCode +
      user.hashCode;

  factory OrderCreateRequestDriver.fromJson(Map<String, dynamic> json) =>
      _$OrderCreateRequestDriverFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateRequestDriverToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum OrderCreateRequestDriverStatusEnum {
  @JsonValue(r'pending')
  pending(r'pending'),
  @JsonValue(r'approved')
  approved(r'approved'),
  @JsonValue(r'rejected')
  rejected(r'rejected'),
  @JsonValue(r'active')
  active(r'active'),
  @JsonValue(r'inactive')
  inactive(r'inactive'),
  @JsonValue(r'suspended')
  suspended(r'suspended');

  const OrderCreateRequestDriverStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
