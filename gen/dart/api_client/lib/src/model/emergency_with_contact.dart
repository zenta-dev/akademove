//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/emergency_with_contact_emergency.dart';
import 'package:api_client/src/model/emergency_contact.dart';
import 'package:api_client/src/model/emergency_with_contact_driver_info.dart';
import 'package:api_client/src/model/emergency_with_contact_order_info.dart';
import 'package:api_client/src/model/emergency_with_contact_user_info.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'emergency_with_contact.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmergencyWithContact {
  /// Returns a new [EmergencyWithContact] instance.
  const EmergencyWithContact({
    required this.emergency,
    required this.contacts,
    required this.orderInfo,
    required this.userInfo,
    this.driverInfo,
  });
  @JsonKey(name: r'emergency', required: true, includeIfNull: false)
  final EmergencyWithContactEmergency emergency;

  @JsonKey(name: r'contacts', required: true, includeIfNull: false)
  final List<EmergencyContact> contacts;

  @JsonKey(name: r'orderInfo', required: true, includeIfNull: false)
  final EmergencyWithContactOrderInfo orderInfo;

  @JsonKey(name: r'userInfo', required: true, includeIfNull: false)
  final EmergencyWithContactUserInfo userInfo;

  @JsonKey(name: r'driverInfo', required: false, includeIfNull: false)
  final EmergencyWithContactDriverInfo? driverInfo;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyWithContact &&
          other.emergency == emergency &&
          other.contacts == contacts &&
          other.orderInfo == orderInfo &&
          other.userInfo == userInfo &&
          other.driverInfo == driverInfo;

  @override
  int get hashCode =>
      emergency.hashCode +
      contacts.hashCode +
      orderInfo.hashCode +
      userInfo.hashCode +
      driverInfo.hashCode;

  factory EmergencyWithContact.fromJson(Map<String, dynamic> json) =>
      _$EmergencyWithContactFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyWithContactToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
