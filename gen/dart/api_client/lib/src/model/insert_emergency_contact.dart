//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_emergency_contact.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertEmergencyContact {
  /// Returns a new [InsertEmergencyContact] instance.
  const InsertEmergencyContact({
    required this.name,
    required this.phone,
    this.description,
    required this.isActive,
    this.priority = 0,
  });
  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final String phone;

  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;

  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(
    defaultValue: 0,
    name: r'priority',
    required: false,
    includeIfNull: false,
  )
  final int? priority;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsertEmergencyContact &&
          other.name == name &&
          other.phone == phone &&
          other.description == description &&
          other.isActive == isActive &&
          other.priority == priority;

  @override
  int get hashCode =>
      name.hashCode +
      phone.hashCode +
      description.hashCode +
      isActive.hashCode +
      priority.hashCode;

  factory InsertEmergencyContact.fromJson(Map<String, dynamic> json) =>
      _$InsertEmergencyContactFromJson(json);

  Map<String, dynamic> toJson() => _$InsertEmergencyContactToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
