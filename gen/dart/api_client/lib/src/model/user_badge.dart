//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user_badge_metadata.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user_badge.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserBadge {
  /// Returns a new [UserBadge] instance.
  const UserBadge({
    required this.id,
    required this.userId,
    required this.badgeId,
    required this.earnedAt,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'badgeId', required: true, includeIfNull: false)
  final String badgeId;

  @JsonKey(name: r'earnedAt', required: true, includeIfNull: false)
  final DateTime earnedAt;

  @JsonKey(name: r'metadata', required: false, includeIfNull: false)
  final UserBadgeMetadata? metadata;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBadge &&
          other.id == id &&
          other.userId == userId &&
          other.badgeId == badgeId &&
          other.earnedAt == earnedAt &&
          other.metadata == metadata &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      userId.hashCode +
      badgeId.hashCode +
      earnedAt.hashCode +
      metadata.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory UserBadge.fromJson(Map<String, dynamic> json) =>
      _$UserBadgeFromJson(json);

  Map<String, dynamic> toJson() => _$UserBadgeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
