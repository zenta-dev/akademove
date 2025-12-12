//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'broadcast_create_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BroadcastCreateRequest {
  /// Returns a new [BroadcastCreateRequest] instance.
  const BroadcastCreateRequest({
    required this.title,
    required this.message,
    required this.type,
    required this.targetAudience,
    this.targetIds,
    this.scheduledAt,
  });
  @JsonKey(name: r'title', required: true, includeIfNull: false)
  final String title;

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final BroadcastCreateRequestTypeEnum type;

  @JsonKey(name: r'targetAudience', required: true, includeIfNull: false)
  final BroadcastCreateRequestTargetAudienceEnum targetAudience;

  @JsonKey(name: r'targetIds', required: false, includeIfNull: false)
  final List<String>? targetIds;

  @JsonKey(name: r'scheduledAt', required: false, includeIfNull: false)
  final DateTime? scheduledAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroadcastCreateRequest &&
          other.title == title &&
          other.message == message &&
          other.type == type &&
          other.targetAudience == targetAudience &&
          other.targetIds == targetIds &&
          other.scheduledAt == scheduledAt;

  @override
  int get hashCode =>
      title.hashCode +
      message.hashCode +
      type.hashCode +
      targetAudience.hashCode +
      targetIds.hashCode +
      (scheduledAt == null ? 0 : scheduledAt.hashCode);

  factory BroadcastCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$BroadcastCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BroadcastCreateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum BroadcastCreateRequestTypeEnum {
  @JsonValue(r'EMAIL')
  EMAIL(r'EMAIL'),
  @JsonValue(r'IN_APP')
  IN_APP(r'IN_APP'),
  @JsonValue(r'ALL')
  ALL(r'ALL');

  const BroadcastCreateRequestTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum BroadcastCreateRequestTargetAudienceEnum {
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

  const BroadcastCreateRequestTargetAudienceEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
