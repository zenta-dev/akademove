//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_submit_approval_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverSubmitApprovalRequest {
  /// Returns a new [DriverSubmitApprovalRequest] instance.
  const DriverSubmitApprovalRequest({
     this.reviewNotes,
  });
  @JsonKey(name: r'reviewNotes', required: false, includeIfNull: false)
  final String? reviewNotes;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DriverSubmitApprovalRequest &&
    other.reviewNotes == reviewNotes;

  @override
  int get hashCode =>
      reviewNotes.hashCode;

  factory DriverSubmitApprovalRequest.fromJson(Map<String, dynamic> json) => _$DriverSubmitApprovalRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DriverSubmitApprovalRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

