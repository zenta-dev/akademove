//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'broadcast_update_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BroadcastUpdateRequest {
  /// Returns a new [BroadcastUpdateRequest] instance.
  const BroadcastUpdateRequest({
    this.title,
    this.message,
    this.type,
    this.targetAudience,
    this.targetIds,
    this.scheduledAt,
  });
  @JsonKey(name: r'title', required: false, includeIfNull: false)
  final String? title;

  @JsonKey(name: r'message', required: false, includeIfNull: false)
  final String? message;

  @JsonKey(name: r'type', required: false, includeIfNull: false)
  final BroadcastUpdateRequestTypeEnum? type;

  @JsonKey(name: r'targetAudience', required: false, includeIfNull: false)
  final BroadcastUpdateRequestTargetAudienceEnum? targetAudience;

  @JsonKey(name: r'targetIds', required: false, includeIfNull: false)
  final List<String>? targetIds;

  @JsonKey(name: r'scheduledAt', required: false, includeIfNull: false)
  final DateTime? scheduledAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroadcastUpdateRequest &&
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
      scheduledAt.hashCode;

  factory BroadcastUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$BroadcastUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BroadcastUpdateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum BroadcastUpdateRequestTypeEnum {
  @JsonValue(r'EMAIL')
  EMAIL(r'EMAIL'),
  @JsonValue(r'IN_APP')
  IN_APP(r'IN_APP'),
  @JsonValue(r'ALL')
  ALL(r'ALL');

  const BroadcastUpdateRequestTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum BroadcastUpdateRequestTargetAudienceEnum {
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

  const BroadcastUpdateRequestTargetAudienceEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
