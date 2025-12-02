//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/badge_target_role.dart';
import 'package:api_client/src/model/badge_type.dart';
import 'package:api_client/src/model/badge_level.dart';
import 'package:api_client/src/model/badge_benefits.dart';
import 'package:api_client/src/model/badge_criteria.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'badge.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class Badge {
  /// Returns a new [Badge] instance.
  const Badge({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.type,
    required this.level,
    required this.targetRole,
    this.icon,
    required this.criteria,
    this.benefits,
    this.isActive = true,
    this.displayOrder = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'description', required: true, includeIfNull: false)
  final String description;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final BadgeType type;

  @JsonKey(name: r'level', required: true, includeIfNull: false)
  final BadgeLevel level;

  @JsonKey(name: r'targetRole', required: true, includeIfNull: false)
  final BadgeTargetRole targetRole;

  @JsonKey(name: r'icon', required: false, includeIfNull: false)
  final String? icon;

  @JsonKey(name: r'criteria', required: true, includeIfNull: false)
  final BadgeCriteria criteria;

  @JsonKey(name: r'benefits', required: false, includeIfNull: false)
  final BadgeBenefits? benefits;

  @JsonKey(defaultValue: true, name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(defaultValue: 0, name: r'displayOrder', required: false, includeIfNull: false)
  final int? displayOrder;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Badge &&
          other.id == id &&
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
          other.displayOrder == displayOrder &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
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
      displayOrder.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
