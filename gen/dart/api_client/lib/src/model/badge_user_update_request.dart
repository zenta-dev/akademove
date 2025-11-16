//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user_badge_metadata.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'badge_user_update_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BadgeUserUpdateRequest {
  /// Returns a new [BadgeUserUpdateRequest] instance.
  const BadgeUserUpdateRequest({this.metadata});

  @JsonKey(name: r'metadata', required: false, includeIfNull: false)
  final UserBadgeMetadata? metadata;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeUserUpdateRequest && other.metadata == metadata;

  @override
  int get hashCode => metadata.hashCode;

  factory BadgeUserUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$BadgeUserUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeUserUpdateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
