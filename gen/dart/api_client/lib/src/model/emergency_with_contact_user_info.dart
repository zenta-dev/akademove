//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'emergency_with_contact_user_info.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmergencyWithContactUserInfo {
  /// Returns a new [EmergencyWithContactUserInfo] instance.
  const EmergencyWithContactUserInfo({
    required this.id,
    required this.name,
    this.phone,
    this.gender,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'phone', required: false, includeIfNull: false)
  final String? phone;

  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final String? gender;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyWithContactUserInfo &&
          other.id == id &&
          other.name == name &&
          other.phone == phone &&
          other.gender == gender;

  @override
  int get hashCode =>
      id.hashCode + name.hashCode + phone.hashCode + gender.hashCode;

  factory EmergencyWithContactUserInfo.fromJson(Map<String, dynamic> json) =>
      _$EmergencyWithContactUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyWithContactUserInfoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
