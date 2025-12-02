//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/emergency_status.dart';
import 'package:api_client/src/model/emergency_type.dart';
import 'package:api_client/src/model/emergency_location.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_emergency.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateEmergency {
  /// Returns a new [UpdateEmergency] instance.
  const UpdateEmergency({
     this.orderId,
     this.userId,
     this.driverId,
     this.type,
     this.status,
     this.description,
     this.location,
     this.contactedAuthorities,
     this.respondedById,
     this.resolution,
  });

  @JsonKey(name: r'orderId', required: false, includeIfNull: false)
  final String? orderId;
  
  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;
  
  @JsonKey(name: r'driverId', required: false, includeIfNull: false)
  final String? driverId;
  
  @JsonKey(name: r'type', required: false, includeIfNull: false)
  final EmergencyType? type;
  
  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final EmergencyStatus? status;
  
  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;
  
  @JsonKey(name: r'location', required: false, includeIfNull: false)
  final EmergencyLocation? location;
  
  @JsonKey(name: r'contactedAuthorities', required: false, includeIfNull: false)
  final List<String>? contactedAuthorities;
  
  @JsonKey(name: r'respondedById', required: false, includeIfNull: false)
  final String? respondedById;
  
  @JsonKey(name: r'resolution', required: false, includeIfNull: false)
  final String? resolution;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateEmergency &&
    other.orderId == orderId &&
    other.userId == userId &&
    other.driverId == driverId &&
    other.type == type &&
    other.status == status &&
    other.description == description &&
    other.location == location &&
    other.contactedAuthorities == contactedAuthorities &&
    other.respondedById == respondedById &&
    other.resolution == resolution;

  @override
  int get hashCode =>
      orderId.hashCode +
      userId.hashCode +
      driverId.hashCode +
      type.hashCode +
      status.hashCode +
      description.hashCode +
      location.hashCode +
      contactedAuthorities.hashCode +
      respondedById.hashCode +
      resolution.hashCode;

  factory UpdateEmergency.fromJson(Map<String, dynamic> json) => _$UpdateEmergencyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateEmergencyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

