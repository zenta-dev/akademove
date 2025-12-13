//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_submit_rejection_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverSubmitRejectionRequest {
  /// Returns a new [DriverSubmitRejectionRequest] instance.
  const DriverSubmitRejectionRequest({required this.reason});
  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverSubmitRejectionRequest && other.reason == reason;

  @override
  int get hashCode => reason.hashCode;

  factory DriverSubmitRejectionRequest.fromJson(Map<String, dynamic> json) =>
      _$DriverSubmitRejectionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DriverSubmitRejectionRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
