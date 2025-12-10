//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/emergency_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'emergency_update_status_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmergencyUpdateStatusRequest {
  /// Returns a new [EmergencyUpdateStatusRequest] instance.
  const EmergencyUpdateStatusRequest({
    this.status,
    this.resolution,
    this.respondedById,
  });
  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final EmergencyStatus? status;

  @JsonKey(name: r'resolution', required: false, includeIfNull: false)
  final String? resolution;

  @JsonKey(name: r'respondedById', required: false, includeIfNull: false)
  final String? respondedById;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyUpdateStatusRequest &&
          other.status == status &&
          other.resolution == resolution &&
          other.respondedById == respondedById;

  @override
  int get hashCode =>
      status.hashCode +
      (resolution == null ? 0 : resolution.hashCode) +
      (respondedById == null ? 0 : respondedById.hashCode);

  factory EmergencyUpdateStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$EmergencyUpdateStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyUpdateStatusRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
