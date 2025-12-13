//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_update_document_status_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverUpdateDocumentStatusRequest {
  /// Returns a new [DriverUpdateDocumentStatusRequest] instance.
  const DriverUpdateDocumentStatusRequest({
    required this.document,
    required this.status,
     this.reason,
  });
  @JsonKey(name: r'document', required: true, includeIfNull: false)
  final DriverUpdateDocumentStatusRequestDocumentEnum document;
  
  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final DriverUpdateDocumentStatusRequestStatusEnum status;
  
  @JsonKey(name: r'reason', required: false, includeIfNull: false)
  final String? reason;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DriverUpdateDocumentStatusRequest &&
    other.document == document &&
    other.status == status &&
    other.reason == reason;

  @override
  int get hashCode =>
      document.hashCode +
      status.hashCode +
      reason.hashCode;

  factory DriverUpdateDocumentStatusRequest.fromJson(Map<String, dynamic> json) => _$DriverUpdateDocumentStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DriverUpdateDocumentStatusRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum DriverUpdateDocumentStatusRequestDocumentEnum {
  @JsonValue(r'studentCard')
  studentCard(r'studentCard'),
  @JsonValue(r'driverLicense')
  driverLicense(r'driverLicense'),
  @JsonValue(r'vehicleRegistration')
  vehicleRegistration(r'vehicleRegistration');
  
  const DriverUpdateDocumentStatusRequestDocumentEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

enum DriverUpdateDocumentStatusRequestStatusEnum {
  @JsonValue(r'APPROVED')
  APPROVED(r'APPROVED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED');
  
  const DriverUpdateDocumentStatusRequestStatusEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

