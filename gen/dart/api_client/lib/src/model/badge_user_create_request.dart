//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user_badge_metadata.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'badge_user_create_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BadgeUserCreateRequest {
  /// Returns a new [BadgeUserCreateRequest] instance.
  const BadgeUserCreateRequest({
    required this.userId,
    required this.badgeId,
    this.metadata,
  });
  @JsonKey(name: r'userId', required: true, includeIfNull: true)
  final String? userId;

  @JsonKey(name: r'badgeId', required: true, includeIfNull: true)
  final String? badgeId;

  @JsonKey(name: r'metadata', required: false, includeIfNull: false)
  final UserBadgeMetadata? metadata;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeUserCreateRequest &&
          other.userId == userId &&
          other.badgeId == badgeId &&
          other.metadata == metadata;

  @override
  int get hashCode =>
      (userId == null ? 0 : userId.hashCode) +
      (badgeId == null ? 0 : badgeId.hashCode) +
      metadata.hashCode;

  factory BadgeUserCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$BadgeUserCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeUserCreateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
