//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/emergency_location.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'log_emergency.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LogEmergency {
  /// Returns a new [LogEmergency] instance.
  const LogEmergency({required this.orderId, this.location});
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'location', required: false, includeIfNull: false)
  final EmergencyLocation? location;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogEmergency &&
          other.orderId == orderId &&
          other.location == location;

  @override
  int get hashCode => orderId.hashCode + location.hashCode;

  factory LogEmergency.fromJson(Map<String, dynamic> json) =>
      _$LogEmergencyFromJson(json);

  Map<String, dynamic> toJson() => _$LogEmergencyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
