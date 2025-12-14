//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'emergency_with_contact_driver_info.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmergencyWithContactDriverInfo {
  /// Returns a new [EmergencyWithContactDriverInfo] instance.
  const EmergencyWithContactDriverInfo({
    required this.id,
    required this.userId,
    required this.name,
    this.phone,
    this.gender,
    this.vehiclePlate,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'phone', required: false, includeIfNull: false)
  final String? phone;

  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final String? gender;

  @JsonKey(name: r'vehiclePlate', required: false, includeIfNull: false)
  final String? vehiclePlate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyWithContactDriverInfo &&
          other.id == id &&
          other.userId == userId &&
          other.name == name &&
          other.phone == phone &&
          other.gender == gender &&
          other.vehiclePlate == vehiclePlate;

  @override
  int get hashCode =>
      id.hashCode +
      userId.hashCode +
      name.hashCode +
      phone.hashCode +
      gender.hashCode +
      vehiclePlate.hashCode;

  factory EmergencyWithContactDriverInfo.fromJson(Map<String, dynamic> json) =>
      _$EmergencyWithContactDriverInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyWithContactDriverInfoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
