//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/broadcast_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_broadcast.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertBroadcast {
  /// Returns a new [InsertBroadcast] instance.
  const InsertBroadcast({
    required this.title,
    required this.message,
    required this.type,
    required this.targetAudience,
     this.targetIds,
     this.scheduledAt,
     this.createdBy,
  });
  @JsonKey(name: r'title', required: true, includeIfNull: false)
  final String title;
  
  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;
  
  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final BroadcastType type;
  
  @JsonKey(name: r'targetAudience', required: true, includeIfNull: false)
  final InsertBroadcastTargetAudienceEnum targetAudience;
  
  @JsonKey(name: r'targetIds', required: false, includeIfNull: false)
  final List<String>? targetIds;
  
  @JsonKey(name: r'scheduledAt', required: false, includeIfNull: false)
  final DateTime? scheduledAt;
  
  @JsonKey(name: r'createdBy', required: false, includeIfNull: false)
  final String? createdBy;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is InsertBroadcast &&
    other.title == title &&
    other.message == message &&
    other.type == type &&
    other.targetAudience == targetAudience &&
    other.targetIds == targetIds &&
    other.scheduledAt == scheduledAt &&
    other.createdBy == createdBy;

  @override
  int get hashCode =>
      title.hashCode +
      message.hashCode +
      type.hashCode +
      targetAudience.hashCode +
      targetIds.hashCode +
      (scheduledAt == null ? 0 : scheduledAt.hashCode) +
      createdBy.hashCode;

  factory InsertBroadcast.fromJson(Map<String, dynamic> json) => _$InsertBroadcastFromJson(json);

  Map<String, dynamic> toJson() => _$InsertBroadcastToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum InsertBroadcastTargetAudienceEnum {
  @JsonValue(r'ALL')
  ALL(r'ALL'),
  @JsonValue(r'USERS')
  USERS(r'USERS'),
  @JsonValue(r'DRIVERS')
  DRIVERS(r'DRIVERS'),
  @JsonValue(r'MERCHANTS')
  MERCHANTS(r'MERCHANTS'),
  @JsonValue(r'ADMINS')
  ADMINS(r'ADMINS'),
  @JsonValue(r'OPERATORS')
  OPERATORS(r'OPERATORS');
  
  const InsertBroadcastTargetAudienceEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

