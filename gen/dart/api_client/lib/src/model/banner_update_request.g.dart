// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BannerUpdateRequestCWProxy {
  BannerUpdateRequest title(String? title);

  BannerUpdateRequest description(String? description);

  BannerUpdateRequest imageUrl(String? imageUrl);

  BannerUpdateRequest actionType(BannerUpdateRequestActionTypeEnum? actionType);

  BannerUpdateRequest actionValue(String? actionValue);

  BannerUpdateRequest placement(BannerUpdateRequestPlacementEnum? placement);

  BannerUpdateRequest targetAudience(
    BannerUpdateRequestTargetAudienceEnum? targetAudience,
  );

  BannerUpdateRequest isActive(bool? isActive);

  BannerUpdateRequest priority(int? priority);

  BannerUpdateRequest startAt(DateTime? startAt);

  BannerUpdateRequest endAt(DateTime? endAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerUpdateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerUpdateRequest call({
    String? title,
    String? description,
    String? imageUrl,
    BannerUpdateRequestActionTypeEnum? actionType,
    String? actionValue,
    BannerUpdateRequestPlacementEnum? placement,
    BannerUpdateRequestTargetAudienceEnum? targetAudience,
    bool? isActive,
    int? priority,
    DateTime? startAt,
    DateTime? endAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBannerUpdateRequest.copyWith(...)` or call `instanceOfBannerUpdateRequest.copyWith.fieldName(value)` for a single field.
class _$BannerUpdateRequestCWProxyImpl implements _$BannerUpdateRequestCWProxy {
  const _$BannerUpdateRequestCWProxyImpl(this._value);

  final BannerUpdateRequest _value;

  @override
  BannerUpdateRequest title(String? title) => call(title: title);

  @override
  BannerUpdateRequest description(String? description) =>
      call(description: description);

  @override
  BannerUpdateRequest imageUrl(String? imageUrl) => call(imageUrl: imageUrl);

  @override
  BannerUpdateRequest actionType(
    BannerUpdateRequestActionTypeEnum? actionType,
  ) => call(actionType: actionType);

  @override
  BannerUpdateRequest actionValue(String? actionValue) =>
      call(actionValue: actionValue);

  @override
  BannerUpdateRequest placement(BannerUpdateRequestPlacementEnum? placement) =>
      call(placement: placement);

  @override
  BannerUpdateRequest targetAudience(
    BannerUpdateRequestTargetAudienceEnum? targetAudience,
  ) => call(targetAudience: targetAudience);

  @override
  BannerUpdateRequest isActive(bool? isActive) => call(isActive: isActive);

  @override
  BannerUpdateRequest priority(int? priority) => call(priority: priority);

  @override
  BannerUpdateRequest startAt(DateTime? startAt) => call(startAt: startAt);

  @override
  BannerUpdateRequest endAt(DateTime? endAt) => call(endAt: endAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerUpdateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerUpdateRequest call({
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
    return BannerUpdateRequest(
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      imageUrl: imageUrl == const $CopyWithPlaceholder()
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String?,
      actionType: actionType == const $CopyWithPlaceholder()
          ? _value.actionType
          // ignore: cast_nullable_to_non_nullable
          : actionType as BannerUpdateRequestActionTypeEnum?,
      actionValue: actionValue == const $CopyWithPlaceholder()
          ? _value.actionValue
          // ignore: cast_nullable_to_non_nullable
          : actionValue as String?,
      placement: placement == const $CopyWithPlaceholder()
          ? _value.placement
          // ignore: cast_nullable_to_non_nullable
          : placement as BannerUpdateRequestPlacementEnum?,
      targetAudience: targetAudience == const $CopyWithPlaceholder()
          ? _value.targetAudience
          // ignore: cast_nullable_to_non_nullable
          : targetAudience as BannerUpdateRequestTargetAudienceEnum?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
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

extension $BannerUpdateRequestCopyWith on BannerUpdateRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBannerUpdateRequest.copyWith(...)` or `instanceOfBannerUpdateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BannerUpdateRequestCWProxy get copyWith =>
      _$BannerUpdateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerUpdateRequest _$BannerUpdateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BannerUpdateRequest', json, ($checkedConvert) {
      final val = BannerUpdateRequest(
        title: $checkedConvert('title', (v) => v as String?),
        description: $checkedConvert('description', (v) => v as String?),
        imageUrl: $checkedConvert('imageUrl', (v) => v as String?),
        actionType: $checkedConvert(
          'actionType',
          (v) => $enumDecodeNullable(
            _$BannerUpdateRequestActionTypeEnumEnumMap,
            v,
          ),
        ),
        actionValue: $checkedConvert('actionValue', (v) => v as String?),
        placement: $checkedConvert(
          'placement',
          (v) =>
              $enumDecodeNullable(_$BannerUpdateRequestPlacementEnumEnumMap, v),
        ),
        targetAudience: $checkedConvert(
          'targetAudience',
          (v) => $enumDecodeNullable(
            _$BannerUpdateRequestTargetAudienceEnumEnumMap,
            v,
          ),
        ),
        isActive: $checkedConvert('isActive', (v) => v as bool?),
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

Map<String, dynamic> _$BannerUpdateRequestToJson(
  BannerUpdateRequest instance,
) => <String, dynamic>{
  'title': ?instance.title,
  'description': ?instance.description,
  'imageUrl': ?instance.imageUrl,
  'actionType':
      ?_$BannerUpdateRequestActionTypeEnumEnumMap[instance.actionType],
  'actionValue': ?instance.actionValue,
  'placement': ?_$BannerUpdateRequestPlacementEnumEnumMap[instance.placement],
  'targetAudience':
      ?_$BannerUpdateRequestTargetAudienceEnumEnumMap[instance.targetAudience],
  'isActive': ?instance.isActive,
  'priority': ?instance.priority,
  'startAt': ?instance.startAt?.toIso8601String(),
  'endAt': ?instance.endAt?.toIso8601String(),
};

const _$BannerUpdateRequestActionTypeEnumEnumMap = {
  BannerUpdateRequestActionTypeEnum.NONE: 'NONE',
  BannerUpdateRequestActionTypeEnum.LINK: 'LINK',
  BannerUpdateRequestActionTypeEnum.ROUTE: 'ROUTE',
};

const _$BannerUpdateRequestPlacementEnumEnumMap = {
  BannerUpdateRequestPlacementEnum.USER_HOME: 'USER_HOME',
  BannerUpdateRequestPlacementEnum.DRIVER_HOME: 'DRIVER_HOME',
  BannerUpdateRequestPlacementEnum.MERCHANT_HOME: 'MERCHANT_HOME',
};

const _$BannerUpdateRequestTargetAudienceEnumEnumMap = {
  BannerUpdateRequestTargetAudienceEnum.ALL: 'ALL',
  BannerUpdateRequestTargetAudienceEnum.USERS: 'USERS',
  BannerUpdateRequestTargetAudienceEnum.DRIVERS: 'DRIVERS',
  BannerUpdateRequestTargetAudienceEnum.MERCHANTS: 'MERCHANTS',
};
