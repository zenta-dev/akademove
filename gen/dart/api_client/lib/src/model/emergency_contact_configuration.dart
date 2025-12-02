//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'emergency_contact_configuration.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmergencyContactConfiguration {
  /// Returns a new [EmergencyContactConfiguration] instance.
  const EmergencyContactConfiguration({
    required this.name,
    required this.phone,
    required this.type,
     this.description,
     this.isActive = true,
  });

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;
  
  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final String phone;
  
  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final EmergencyContactConfigurationTypeEnum type;
  
  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;
  
  @JsonKey(defaultValue: true,name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is EmergencyContactConfiguration &&
    other.name == name &&
    other.phone == phone &&
    other.type == type &&
    other.description == description &&
    other.isActive == isActive;

  @override
  int get hashCode =>
      name.hashCode +
      phone.hashCode +
      type.hashCode +
      description.hashCode +
      isActive.hashCode;

  factory EmergencyContactConfiguration.fromJson(Map<String, dynamic> json) => _$EmergencyContactConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyContactConfigurationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum EmergencyContactConfigurationTypeEnum {
  @JsonValue(r'CAMPUS_SECURITY')
  CAMPUS_SECURITY(r'CAMPUS_SECURITY'),
  @JsonValue(r'POLICE')
  POLICE(r'POLICE'),
  @JsonValue(r'AMBULANCE')
  AMBULANCE(r'AMBULANCE'),
  @JsonValue(r'FIRE_DEPT')
  FIRE_DEPT(r'FIRE_DEPT'),
  @JsonValue(r'OTHER')
  OTHER(r'OTHER');
  
  const EmergencyContactConfigurationTypeEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


