//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'emergency_log200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmergencyLog200ResponseData {
  /// Returns a new [EmergencyLog200ResponseData] instance.
  const EmergencyLog200ResponseData({required this.logged});
  @JsonKey(name: r'logged', required: true, includeIfNull: false)
  final bool logged;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyLog200ResponseData && other.logged == logged;

  @override
  int get hashCode => logged.hashCode;

  factory EmergencyLog200ResponseData.fromJson(Map<String, dynamic> json) =>
      _$EmergencyLog200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyLog200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
