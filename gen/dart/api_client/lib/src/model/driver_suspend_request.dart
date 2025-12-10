//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_suspend_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverSuspendRequest {
  /// Returns a new [DriverSuspendRequest] instance.
  const DriverSuspendRequest({required this.reason, this.suspendUntil});
  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'suspendUntil', required: false, includeIfNull: false)
  final DateTime? suspendUntil;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverSuspendRequest &&
          other.reason == reason &&
          other.suspendUntil == suspendUntil;

  @override
  int get hashCode =>
      reason.hashCode + (suspendUntil == null ? 0 : suspendUntil.hashCode);

  factory DriverSuspendRequest.fromJson(Map<String, dynamic> json) =>
      _$DriverSuspendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DriverSuspendRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
