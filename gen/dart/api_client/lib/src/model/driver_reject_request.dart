//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_reject_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverRejectRequest {
  /// Returns a new [DriverRejectRequest] instance.
  const DriverRejectRequest({
    required this.reason,
  });
  @JsonKey(name: r'reason', required: true, includeIfNull: true)
  final String? reason;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DriverRejectRequest &&
    other.reason == reason;

  @override
  int get hashCode =>
      (reason == null ? 0 : reason.hashCode);

  factory DriverRejectRequest.fromJson(Map<String, dynamic> json) => _$DriverRejectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DriverRejectRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

