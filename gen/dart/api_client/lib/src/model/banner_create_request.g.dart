// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_create_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BannerCreateRequestCWProxy {
  BannerCreateRequest title(String title);

  BannerCreateRequest description(String? description);

  BannerCreateRequest imageUrl(String imageUrl);

  BannerCreateRequest actionType(BannerCreateRequestActionTypeEnum actionType);

  BannerCreateRequest actionValue(String? actionValue);

  BannerCreateRequest placement(BannerCreateRequestPlacementEnum placement);

  BannerCreateRequest targetAudience(
    BannerCreateRequestTargetAudienceEnum targetAudience,
  );

  BannerCreateRequest isActive(bool isActive);

  BannerCreateRequest priority(int? priority);

  BannerCreateRequest startAt(DateTime? startAt);

  BannerCreateRequest endAt(DateTime? endAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerCreateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerCreateRequest call({
    String title,
    String? description,
    String imageUrl,
    BannerCreateRequestActionTypeEnum actionType,
    String? actionValue,
    BannerCreateRequestPlacementEnum placement,
    BannerCreateRequestTargetAudienceEnum targetAudience,
    bool isActive,
    int? priority,
    DateTime? startAt,
    DateTime? endAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBannerCreateRequest.copyWith(...)` or call `instanceOfBannerCreateRequest.copyWith.fieldName(value)` for a single field.
class _$BannerCreateRequestCWProxyImpl implements _$BannerCreateRequestCWProxy {
  const _$BannerCreateRequestCWProxyImpl(this._value);

  final BannerCreateRequest _value;

  @override
  BannerCreateRequest title(String title) => call(title: title);

  @override
  BannerCreateRequest description(String? description) =>
      call(description: description);

  @override
  BannerCreateRequest imageUrl(String imageUrl) => call(imageUrl: imageUrl);

  @override
  BannerCreateRequest actionType(
    BannerCreateRequestActionTypeEnum actionType,
  ) => call(actionType: actionType);

  @override
  BannerCreateRequest actionValue(String? actionValue) =>
      call(actionValue: actionValue);

  @override
  BannerCreateRequest placement(BannerCreateRequestPlacementEnum placement) =>
      call(placement: placement);

  @override
  BannerCreateRequest targetAudience(
    BannerCreateRequestTargetAudienceEnum targetAudience,
  ) => call(targetAudience: targetAudience);

  @override
  BannerCreateRequest isActive(bool isActive) => call(isActive: isActive);

  @override
  BannerCreateRequest priority(int? priority) => call(priority: priority);

  @override
  BannerCreateRequest startAt(DateTime? startAt) => call(startAt: startAt);

  @override
  BannerCreateRequest endAt(DateTime? endAt) => call(endAt: endAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerCreateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerCreateRequest call({
    Object? title = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? actionType = const $CopyWithPlaceholder(),
    Object? actionValue = const $CopyWithPlaceholder(),
    Object? placement = const $CopyWithPlaceholder(),
    Object? targetAudience = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? priority = const $CopyWithPlaceholder(),
    Object? startAt = const $CopyWithPlaceholder(),
    Object? endAt = const $CopyWithPlaceholder(),
  }) {
    return BannerCreateRequest(
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      imageUrl: imageUrl == const $CopyWithPlaceholder() || imageUrl == null
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String,
      actionType:
          actionType == const $CopyWithPlaceholder() || actionType == null
          ? _value.actionType
          // ignore: cast_nullable_to_non_nullable
          : actionType as BannerCreateRequestActionTypeEnum,
      actionValue: actionValue == const $CopyWithPlaceholder()
          ? _value.actionValue
          // ignore: cast_nullable_to_non_nullable
          : actionValue as String?,
      placement: placement == const $CopyWithPlaceholder() || placement == null
          ? _value.placement
          // ignore: cast_nullable_to_non_nullable
          : placement as BannerCreateRequestPlacementEnum,
      targetAudience:
          targetAudience == const $CopyWithPlaceholder() ||
              targetAudience == null
          ? _value.targetAudience
          // ignore: cast_nullable_to_non_nullable
          : targetAudience as BannerCreateRequestTargetAudienceEnum,
      isActive: isActive == const $CopyWithPlaceholder() || isActive == null
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      priority: priority == const $CopyWithPlaceholder()
          ? _value.priority
          // ignore: cast_nullable_to_non_nullable
          : priority as int?,
      startAt: startAt == const $CopyWithPlaceholder()
          ? _value.startAt
          // ignore: cast_nullable_to_non_nullable
          : startAt as DateTime?,
      endAt: endAt == const $CopyWithPlaceholder()
          ? _value.endAt
          // ignore: cast_nullable_to_non_nullable
          : endAt as DateTime?,
    );
  }
}

extension $BannerCreateRequestCopyWith on BannerCreateRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBannerCreateRequest.copyWith(...)` or `instanceOfBannerCreateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BannerCreateRequestCWProxy get copyWith =>
      _$BannerCreateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerCreateRequest _$BannerCreateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BannerCreateRequest', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'title',
          'imageUrl',
          'actionType',
          'placement',
          'targetAudience',
          'isActive',
        ],
      );
      final val = BannerCreateRequest(
        title: $checkedConvert('title', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
        imageUrl: $checkedConvert('imageUrl', (v) => v as String),
        actionType: $checkedConvert(
          'actionType',
          (v) => $enumDecode(_$BannerCreateRequestActionTypeEnumEnumMap, v),
        ),
        actionValue: $checkedConvert('actionValue', (v) => v as String?),
        placement: $checkedConvert(
          'placement',
          (v) => $enumDecode(_$BannerCreateRequestPlacementEnumEnumMap, v),
        ),
        targetAudience: $checkedConvert(
          'targetAudience',
          (v) => $enumDecode(_$BannerCreateRequestTargetAudienceEnumEnumMap, v),
        ),
        isActive: $checkedConvert('isActive', (v) => v as bool),
        priority: $checkedConvert('priority', (v) => (v as num?)?.toInt() ?? 0),
        startAt: $checkedConvert(
          'startAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        endAt: $checkedConvert(
          'endAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BannerCreateRequestToJson(
  BannerCreateRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': ?instance.description,
  'imageUrl': instance.imageUrl,
  'actionType':
      _$BannerCreateRequestActionTypeEnumEnumMap[instance.actionType]!,
  'actionValue': ?instance.actionValue,
  'placement': _$BannerCreateRequestPlacementEnumEnumMap[instance.placement]!,
  'targetAudience':
      _$BannerCreateRequestTargetAudienceEnumEnumMap[instance.targetAudience]!,
  'isActive': instance.isActive,
  'priority': ?instance.priority,
  'startAt': ?instance.startAt?.toIso8601String(),
  'endAt': ?instance.endAt?.toIso8601String(),
};

const _$BannerCreateRequestActionTypeEnumEnumMap = {
  BannerCreateRequestActionTypeEnum.NONE: 'NONE',
  BannerCreateRequestActionTypeEnum.LINK: 'LINK',
  BannerCreateRequestActionTypeEnum.ROUTE: 'ROUTE',
};

const _$BannerCreateRequestPlacementEnumEnumMap = {
  BannerCreateRequestPlacementEnum.USER_HOME: 'USER_HOME',
  BannerCreateRequestPlacementEnum.DRIVER_HOME: 'DRIVER_HOME',
  BannerCreateRequestPlacementEnum.MERCHANT_HOME: 'MERCHANT_HOME',
};

const _$BannerCreateRequestTargetAudienceEnumEnumMap = {
  BannerCreateRequestTargetAudienceEnum.ALL: 'ALL',
  BannerCreateRequestTargetAudienceEnum.USERS: 'USERS',
  BannerCreateRequestTargetAudienceEnum.DRIVERS: 'DRIVERS',
  BannerCreateRequestTargetAudienceEnum.MERCHANTS: 'MERCHANTS',
};
