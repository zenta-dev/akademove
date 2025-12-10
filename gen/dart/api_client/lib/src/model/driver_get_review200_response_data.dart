//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_get_review200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverGetReview200ResponseData {
  /// Returns a new [DriverGetReview200ResponseData] instance.
  const DriverGetReview200ResponseData({
    required this.id,
    required this.driverId,
    required this.status,
    required this.studentCardStatus,
    required this.studentCardReason,
    required this.driverLicenseStatus,
    required this.driverLicenseReason,
    required this.vehicleRegistrationStatus,
    required this.vehicleRegistrationReason,
    required this.quizVerified,
    required this.quizReviewedAt,
    required this.reviewedBy,
    required this.reviewedAt,
    required this.reviewNotes,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: true)
  final String? id;

  @JsonKey(name: r'driverId', required: true, includeIfNull: true)
  final String? driverId;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final DriverGetReview200ResponseDataStatusEnum status;

  @JsonKey(name: r'studentCardStatus', required: true, includeIfNull: false)
  final DriverGetReview200ResponseDataStudentCardStatusEnum studentCardStatus;

  @JsonKey(name: r'studentCardReason', required: true, includeIfNull: true)
  final String? studentCardReason;

  @JsonKey(name: r'driverLicenseStatus', required: true, includeIfNull: false)
  final DriverGetReview200ResponseDataDriverLicenseStatusEnum
  driverLicenseStatus;

  @JsonKey(name: r'driverLicenseReason', required: true, includeIfNull: true)
  final String? driverLicenseReason;

  @JsonKey(
    name: r'vehicleRegistrationStatus',
    required: true,
    includeIfNull: false,
  )
  final DriverGetReview200ResponseDataVehicleRegistrationStatusEnum
  vehicleRegistrationStatus;

  @JsonKey(
    name: r'vehicleRegistrationReason',
    required: true,
    includeIfNull: true,
  )
  final String? vehicleRegistrationReason;

  @JsonKey(name: r'quizVerified', required: true, includeIfNull: false)
  final bool quizVerified;

  @JsonKey(name: r'quizReviewedAt', required: true, includeIfNull: true)
  final DateTime? quizReviewedAt;

  @JsonKey(name: r'reviewedBy', required: true, includeIfNull: true)
  final String? reviewedBy;

  @JsonKey(name: r'reviewedAt', required: true, includeIfNull: true)
  final DateTime? reviewedAt;

  @JsonKey(name: r'reviewNotes', required: true, includeIfNull: true)
  final String? reviewNotes;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: true)
  final DateTime? createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: true)
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverGetReview200ResponseData &&
          other.id == id &&
          other.driverId == driverId &&
          other.status == status &&
          other.studentCardStatus == studentCardStatus &&
          other.studentCardReason == studentCardReason &&
          other.driverLicenseStatus == driverLicenseStatus &&
          other.driverLicenseReason == driverLicenseReason &&
          other.vehicleRegistrationStatus == vehicleRegistrationStatus &&
          other.vehicleRegistrationReason == vehicleRegistrationReason &&
          other.quizVerified == quizVerified &&
          other.quizReviewedAt == quizReviewedAt &&
          other.reviewedBy == reviewedBy &&
          other.reviewedAt == reviewedAt &&
          other.reviewNotes == reviewNotes &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      (id == null ? 0 : id.hashCode) +
      (driverId == null ? 0 : driverId.hashCode) +
      status.hashCode +
      studentCardStatus.hashCode +
      (studentCardReason == null ? 0 : studentCardReason.hashCode) +
      driverLicenseStatus.hashCode +
      (driverLicenseReason == null ? 0 : driverLicenseReason.hashCode) +
      vehicleRegistrationStatus.hashCode +
      (vehicleRegistrationReason == null
          ? 0
          : vehicleRegistrationReason.hashCode) +
      quizVerified.hashCode +
      (quizReviewedAt == null ? 0 : quizReviewedAt.hashCode) +
      (reviewedBy == null ? 0 : reviewedBy.hashCode) +
      (reviewedAt == null ? 0 : reviewedAt.hashCode) +
      (reviewNotes == null ? 0 : reviewNotes.hashCode) +
      (createdAt == null ? 0 : createdAt.hashCode) +
      (updatedAt == null ? 0 : updatedAt.hashCode);

  factory DriverGetReview200ResponseData.fromJson(Map<String, dynamic> json) =>
      _$DriverGetReview200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$DriverGetReview200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum DriverGetReview200ResponseDataStatusEnum {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'APPROVED')
  APPROVED(r'APPROVED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED');

  const DriverGetReview200ResponseDataStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum DriverGetReview200ResponseDataStudentCardStatusEnum {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'APPROVED')
  APPROVED(r'APPROVED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED');

  const DriverGetReview200ResponseDataStudentCardStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum DriverGetReview200ResponseDataDriverLicenseStatusEnum {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'APPROVED')
  APPROVED(r'APPROVED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED');

  const DriverGetReview200ResponseDataDriverLicenseStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum DriverGetReview200ResponseDataVehicleRegistrationStatusEnum {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'APPROVED')
  APPROVED(r'APPROVED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED');

  const DriverGetReview200ResponseDataVehicleRegistrationStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
