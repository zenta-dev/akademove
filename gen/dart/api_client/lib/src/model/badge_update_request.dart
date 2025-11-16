//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/badge_target_role.dart';
import 'package:api_client/src/model/badge_type.dart';
import 'package:api_client/src/model/badge_level.dart';
import 'package:api_client/src/model/badge_benefits.dart';
import 'package:api_client/src/model/badge_create_request_criteria.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'badge_update_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BadgeUpdateRequest {
  /// Returns a new [BadgeUpdateRequest] instance.
  const BadgeUpdateRequest({
    this.code,
    this.name,
    this.description,
    this.type,
    this.level,
    this.targetRole,
    this.icon,
    this.criteria,
    this.benefits,
    this.isActive = true,
    this.displayOrder = 0,
  });

  @JsonKey(name: r'code', required: false, includeIfNull: false)
  final String? code;

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;

  @JsonKey(name: r'type', required: false, includeIfNull: false)
  final BadgeType? type;

  @JsonKey(name: r'level', required: false, includeIfNull: false)
  final BadgeLevel? level;

  @JsonKey(name: r'targetRole', required: false, includeIfNull: false)
  final BadgeTargetRole? targetRole;

  @JsonKey(name: r'icon', required: false, includeIfNull: false)
  final String? icon;

  @JsonKey(name: r'criteria', required: false, includeIfNull: false)
  final BadgeCreateRequestCriteria? criteria;

  @JsonKey(name: r'benefits', required: false, includeIfNull: false)
  final BadgeBenefits? benefits;

  @JsonKey(
    defaultValue: true,
    name: r'isActive',
    required: false,
    includeIfNull: false,
  )
  final bool? isActive;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(
    defaultValue: 0,
    name: r'displayOrder',
    required: false,
    includeIfNull: false,
  )
  final int? displayOrder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeUpdateRequest &&
          other.code == code &&
          other.name == name &&
          other.description == description &&
          other.type == type &&
          other.level == level &&
          other.targetRole == targetRole &&
          other.icon == icon &&
          other.criteria == criteria &&
          other.benefits == benefits &&
          other.isActive == isActive &&
          other.displayOrder == displayOrder;

  @override
  int get hashCode =>
      code.hashCode +
      name.hashCode +
      description.hashCode +
      type.hashCode +
      level.hashCode +
      targetRole.hashCode +
      icon.hashCode +
      criteria.hashCode +
      benefits.hashCode +
      isActive.hashCode +
      displayOrder.hashCode;

  factory BadgeUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$BadgeUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeUpdateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
