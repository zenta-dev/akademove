// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeCWProxy {
  Badge id(String id);

  Badge code(String code);

  Badge name(String name);

  Badge description(String description);

  Badge type(BadgeType type);

  Badge level(BadgeLevel level);

  Badge targetRole(BadgeTargetRole targetRole);

  Badge icon(String? icon);

  Badge criteria(BadgeCreateRequestCriteria criteria);

  Badge benefits(BadgeBenefits? benefits);

  Badge isActive(bool? isActive);

  Badge displayOrder(int? displayOrder);

  Badge createdAt(DateTime createdAt);

  Badge updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Badge(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Badge(...).copyWith(id: 12, name: "My name")
  /// ````
  Badge call({
    String id,
    String code,
    String name,
    String description,
    BadgeType type,
    BadgeLevel level,
    BadgeTargetRole targetRole,
    String? icon,
    BadgeCreateRequestCriteria criteria,
    BadgeBenefits? benefits,
    bool? isActive,
    int? displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBadge.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBadge.copyWith.fieldName(...)`
class _$BadgeCWProxyImpl implements _$BadgeCWProxy {
  const _$BadgeCWProxyImpl(this._value);

  final Badge _value;

  @override
  Badge id(String id) => this(id: id);

  @override
  Badge code(String code) => this(code: code);

  @override
  Badge name(String name) => this(name: name);

  @override
  Badge description(String description) => this(description: description);

  @override
  Badge type(BadgeType type) => this(type: type);

  @override
  Badge level(BadgeLevel level) => this(level: level);

  @override
  Badge targetRole(BadgeTargetRole targetRole) => this(targetRole: targetRole);

  @override
  Badge icon(String? icon) => this(icon: icon);

  @override
  Badge criteria(BadgeCreateRequestCriteria criteria) =>
      this(criteria: criteria);

  @override
  Badge benefits(BadgeBenefits? benefits) => this(benefits: benefits);

  @override
  Badge isActive(bool? isActive) => this(isActive: isActive);

  @override
  Badge displayOrder(int? displayOrder) => this(displayOrder: displayOrder);

  @override
  Badge createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Badge updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Badge(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Badge(...).copyWith(id: 12, name: "My name")
  /// ````
  Badge call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? level = const $CopyWithPlaceholder(),
    Object? targetRole = const $CopyWithPlaceholder(),
    Object? icon = const $CopyWithPlaceholder(),
    Object? criteria = const $CopyWithPlaceholder(),
    Object? benefits = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Badge(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as BadgeType,
      level: level == const $CopyWithPlaceholder()
          ? _value.level
          // ignore: cast_nullable_to_non_nullable
          : level as BadgeLevel,
      targetRole: targetRole == const $CopyWithPlaceholder()
          ? _value.targetRole
          // ignore: cast_nullable_to_non_nullable
          : targetRole as BadgeTargetRole,
      icon: icon == const $CopyWithPlaceholder()
          ? _value.icon
          // ignore: cast_nullable_to_non_nullable
          : icon as String?,
      criteria: criteria == const $CopyWithPlaceholder()
          ? _value.criteria
          // ignore: cast_nullable_to_non_nullable
          : criteria as BadgeCreateRequestCriteria,
      benefits: benefits == const $CopyWithPlaceholder()
          ? _value.benefits
          // ignore: cast_nullable_to_non_nullable
          : benefits as BadgeBenefits?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $BadgeCopyWith on Badge {
  /// Returns a callable class that can be used as follows: `instanceOfBadge.copyWith(...)` or like so:`instanceOfBadge.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeCWProxy get copyWith => _$BadgeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Badge _$BadgeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Badge', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'code',
      'name',
      'description',
      'type',
      'level',
      'targetRole',
      'criteria',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = Badge(
    id: $checkedConvert('id', (v) => v as String),
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    description: $checkedConvert('description', (v) => v as String),
    type: $checkedConvert('type', (v) => $enumDecode(_$BadgeTypeEnumMap, v)),
    level: $checkedConvert('level', (v) => $enumDecode(_$BadgeLevelEnumMap, v)),
    targetRole: $checkedConvert(
      'targetRole',
      (v) => $enumDecode(_$BadgeTargetRoleEnumMap, v),
    ),
    icon: $checkedConvert('icon', (v) => v as String?),
    criteria: $checkedConvert(
      'criteria',
      (v) => BadgeCreateRequestCriteria.fromJson(v as Map<String, dynamic>),
    ),
    benefits: $checkedConvert(
      'benefits',
      (v) =>
          v == null ? null : BadgeBenefits.fromJson(v as Map<String, dynamic>),
    ),
    isActive: $checkedConvert('isActive', (v) => v as bool? ?? true),
    displayOrder: $checkedConvert(
      'displayOrder',
      (v) => (v as num?)?.toInt() ?? 0,
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
  'description': instance.description,
  'type': _$BadgeTypeEnumMap[instance.type]!,
  'level': _$BadgeLevelEnumMap[instance.level]!,
  'targetRole': _$BadgeTargetRoleEnumMap[instance.targetRole]!,
  'icon': ?instance.icon,
  'criteria': instance.criteria.toJson(),
  'benefits': ?instance.benefits?.toJson(),
  'isActive': ?instance.isActive,
  'displayOrder': ?instance.displayOrder,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$BadgeTypeEnumMap = {
  BadgeType.performance: 'performance',
  BadgeType.volume: 'volume',
  BadgeType.streak: 'streak',
  BadgeType.milestone: 'milestone',
  BadgeType.special: 'special',
};

const _$BadgeLevelEnumMap = {
  BadgeLevel.bronze: 'bronze',
  BadgeLevel.silver: 'silver',
  BadgeLevel.gold: 'gold',
  BadgeLevel.platinum: 'platinum',
  BadgeLevel.diamond: 'diamond',
};

const _$BadgeTargetRoleEnumMap = {
  BadgeTargetRole.driver: 'driver',
  BadgeTargetRole.merchant: 'merchant',
  BadgeTargetRole.user: 'user',
};
