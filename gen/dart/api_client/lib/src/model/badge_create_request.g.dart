// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_create_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeCreateRequestCWProxy {
  BadgeCreateRequest code(String code);

  BadgeCreateRequest name(String name);

  BadgeCreateRequest description(String description);

  BadgeCreateRequest type(BadgeType type);

  BadgeCreateRequest level(BadgeLevel level);

  BadgeCreateRequest targetRole(BadgeTargetRole targetRole);

  BadgeCreateRequest icon(String? icon);

  BadgeCreateRequest criteria(BadgeCreateRequestCriteria criteria);

  BadgeCreateRequest benefits(BadgeBenefits? benefits);

  BadgeCreateRequest isActive(bool? isActive);

  BadgeCreateRequest displayOrder(int? displayOrder);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeCreateRequest call({
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
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBadgeCreateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBadgeCreateRequest.copyWith.fieldName(...)`
class _$BadgeCreateRequestCWProxyImpl implements _$BadgeCreateRequestCWProxy {
  const _$BadgeCreateRequestCWProxyImpl(this._value);

  final BadgeCreateRequest _value;

  @override
  BadgeCreateRequest code(String code) => this(code: code);

  @override
  BadgeCreateRequest name(String name) => this(name: name);

  @override
  BadgeCreateRequest description(String description) =>
      this(description: description);

  @override
  BadgeCreateRequest type(BadgeType type) => this(type: type);

  @override
  BadgeCreateRequest level(BadgeLevel level) => this(level: level);

  @override
  BadgeCreateRequest targetRole(BadgeTargetRole targetRole) =>
      this(targetRole: targetRole);

  @override
  BadgeCreateRequest icon(String? icon) => this(icon: icon);

  @override
  BadgeCreateRequest criteria(BadgeCreateRequestCriteria criteria) =>
      this(criteria: criteria);

  @override
  BadgeCreateRequest benefits(BadgeBenefits? benefits) =>
      this(benefits: benefits);

  @override
  BadgeCreateRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  BadgeCreateRequest displayOrder(int? displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeCreateRequest call({
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
  }) {
    return BadgeCreateRequest(
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
    );
  }
}

extension $BadgeCreateRequestCopyWith on BadgeCreateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfBadgeCreateRequest.copyWith(...)` or like so:`instanceOfBadgeCreateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeCreateRequestCWProxy get copyWith =>
      _$BadgeCreateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeCreateRequest _$BadgeCreateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BadgeCreateRequest', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'code',
      'name',
      'description',
      'type',
      'level',
      'targetRole',
      'criteria',
    ],
  );
  final val = BadgeCreateRequest(
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
  );
  return val;
});

Map<String, dynamic> _$BadgeCreateRequestToJson(BadgeCreateRequest instance) =>
    <String, dynamic>{
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
