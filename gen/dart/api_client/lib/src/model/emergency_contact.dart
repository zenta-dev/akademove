//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'emergency_contact.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmergencyContact {
  /// Returns a new [EmergencyContact] instance.
  const EmergencyContact({
    required this.id,
    required this.name,
    required this.phone,
    this.description,
    required this.isActive,
    this.priority = 0,
    required this.createdAt,
    required this.updatedAt,
    this.createdById,
    this.updatedById,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

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

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @JsonKey(name: r'createdById', required: false, includeIfNull: false)
  final String? createdById;

  @JsonKey(name: r'updatedById', required: false, includeIfNull: false)
  final String? updatedById;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyContact &&
          other.id == id &&
          other.name == name &&
          other.phone == phone &&
          other.description == description &&
          other.isActive == isActive &&
          other.priority == priority &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.createdById == createdById &&
          other.updatedById == updatedById;

  @override
  int get hashCode =>
      id.hashCode +
      name.hashCode +
      phone.hashCode +
      description.hashCode +
      isActive.hashCode +
      priority.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode +
      createdById.hashCode +
      updatedById.hashCode;

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyContactToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
