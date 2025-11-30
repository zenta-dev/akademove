//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coordinate.dart';
import 'package:api_client/src/model/bank.dart';
import 'package:api_client/src/model/driver_user.dart';
import 'package:api_client/src/model/driver_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Driver {
  /// Returns a new [Driver] instance.
  const Driver({
    required this.id,
    required this.userId,
    required this.studentId,
    required this.licensePlate,
    required this.status,
    required this.rating,
    required this.isTakingOrder,
    required this.isOnline,
     this.currentLocation,
     this.lastLocationUpdate,
    required this.createdAt,
    required this.studentCard,
    required this.driverLicense,
    required this.vehicleCertificate,
    required this.bank,
     this.user,
     this.distance,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;
  
  @JsonKey(name: r'studentId', required: true, includeIfNull: false)
  final num studentId;
  
  @JsonKey(name: r'licensePlate', required: true, includeIfNull: false)
  final String licensePlate;
  
  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final DriverStatus status;
  
  @JsonKey(name: r'rating', required: true, includeIfNull: false)
  final num rating;
  
  @JsonKey(name: r'isTakingOrder', required: true, includeIfNull: false)
  final bool isTakingOrder;
  
  @JsonKey(name: r'isOnline', required: true, includeIfNull: false)
  final bool isOnline;
  
  @JsonKey(name: r'currentLocation', required: false, includeIfNull: false)
  final Coordinate? currentLocation;
  
  @JsonKey(name: r'lastLocationUpdate', required: false, includeIfNull: false)
  final DateTime? lastLocationUpdate;
  
  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;
  
  @JsonKey(name: r'studentCard', required: true, includeIfNull: false)
  final String studentCard;
  
  @JsonKey(name: r'driverLicense', required: true, includeIfNull: false)
  final String driverLicense;
  
  @JsonKey(name: r'vehicleCertificate', required: true, includeIfNull: false)
  final String vehicleCertificate;
  
  @JsonKey(name: r'bank', required: true, includeIfNull: false)
  final Bank bank;
  
  @JsonKey(name: r'user', required: false, includeIfNull: false)
  final DriverUser? user;
  
      /// Each user has different result since it calculated value
  @JsonKey(name: r'distance', required: false, includeIfNull: false)
  final num? distance;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is Driver &&
    other.id == id &&
    other.userId == userId &&
    other.studentId == studentId &&
    other.licensePlate == licensePlate &&
    other.status == status &&
    other.rating == rating &&
    other.isTakingOrder == isTakingOrder &&
    other.isOnline == isOnline &&
    other.currentLocation == currentLocation &&
    other.lastLocationUpdate == lastLocationUpdate &&
    other.createdAt == createdAt &&
    other.studentCard == studentCard &&
    other.driverLicense == driverLicense &&
    other.vehicleCertificate == vehicleCertificate &&
    other.bank == bank &&
    other.user == user &&
    other.distance == distance;

  @override
  int get hashCode =>
      id.hashCode +
      userId.hashCode +
      studentId.hashCode +
      licensePlate.hashCode +
      status.hashCode +
      rating.hashCode +
      isTakingOrder.hashCode +
      isOnline.hashCode +
      currentLocation.hashCode +
      lastLocationUpdate.hashCode +
      createdAt.hashCode +
      studentCard.hashCode +
      driverLicense.hashCode +
      vehicleCertificate.hashCode +
      bank.hashCode +
      user.hashCode +
      distance.hashCode;

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  Map<String, dynamic> toJson() => _$DriverToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

