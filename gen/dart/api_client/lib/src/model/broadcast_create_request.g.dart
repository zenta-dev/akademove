// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_create_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BroadcastCreateRequestCWProxy {
  BroadcastCreateRequest title(String title);

  BroadcastCreateRequest message(String message);

  BroadcastCreateRequest type(BroadcastCreateRequestTypeEnum type);

  BroadcastCreateRequest targetAudience(
    BroadcastCreateRequestTargetAudienceEnum targetAudience,
  );

  BroadcastCreateRequest targetIds(List<String>? targetIds);

  BroadcastCreateRequest scheduledAt(DateTime? scheduledAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastCreateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastCreateRequest call({
    String title,
    String message,
    BroadcastCreateRequestTypeEnum type,
    BroadcastCreateRequestTargetAudienceEnum targetAudience,
    List<String>? targetIds,
    DateTime? scheduledAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBroadcastCreateRequest.copyWith(...)` or call `instanceOfBroadcastCreateRequest.copyWith.fieldName(value)` for a single field.
class _$BroadcastCreateRequestCWProxyImpl
    implements _$BroadcastCreateRequestCWProxy {
  const _$BroadcastCreateRequestCWProxyImpl(this._value);

  final BroadcastCreateRequest _value;

  @override
  BroadcastCreateRequest title(String title) => call(title: title);

  @override
  BroadcastCreateRequest message(String message) => call(message: message);

  @override
  BroadcastCreateRequest type(BroadcastCreateRequestTypeEnum type) =>
      call(type: type);

  @override
  BroadcastCreateRequest targetAudience(
    BroadcastCreateRequestTargetAudienceEnum targetAudience,
  ) => call(targetAudience: targetAudience);

  @override
  BroadcastCreateRequest targetIds(List<String>? targetIds) =>
      call(targetIds: targetIds);

  @override
  BroadcastCreateRequest scheduledAt(DateTime? scheduledAt) =>
      call(scheduledAt: scheduledAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastCreateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastCreateRequest call({
    Object? title = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? targetAudience = const $CopyWithPlaceholder(),
    Object? targetIds = const $CopyWithPlaceholder(),
    Object? scheduledAt = const $CopyWithPlaceholder(),
  }) {
    return BroadcastCreateRequest(
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as BroadcastCreateRequestTypeEnum,
      targetAudience:
          targetAudience == const $CopyWithPlaceholder() ||
              targetAudience == null
          ? _value.targetAudience
          // ignore: cast_nullable_to_non_nullable
          : targetAudience as BroadcastCreateRequestTargetAudienceEnum,
      targetIds: targetIds == const $CopyWithPlaceholder()
          ? _value.targetIds
          // ignore: cast_nullable_to_non_nullable
          : targetIds as List<String>?,
      scheduledAt: scheduledAt == const $CopyWithPlaceholder()
          ? _value.scheduledAt
          // ignore: cast_nullable_to_non_nullable
          : scheduledAt as DateTime?,
    );
  }
}

extension $BroadcastCreateRequestCopyWith on BroadcastCreateRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBroadcastCreateRequest.copyWith(...)` or `instanceOfBroadcastCreateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BroadcastCreateRequestCWProxy get copyWith =>
      _$BroadcastCreateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BroadcastCreateRequest _$BroadcastCreateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BroadcastCreateRequest', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['title', 'message', 'type', 'targetAudience'],
  );
  final val = BroadcastCreateRequest(
    title: $checkedConvert('title', (v) => v as String),
    message: $checkedConvert('message', (v) => v as String),
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$BroadcastCreateRequestTypeEnumEnumMap, v),
    ),
    targetAudience: $checkedConvert(
      'targetAudience',
      (v) => $enumDecode(_$BroadcastCreateRequestTargetAudienceEnumEnumMap, v),
    ),
    targetIds: $checkedConvert(
      'targetIds',
      (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
    ),
    scheduledAt: $checkedConvert(
      'scheduledAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$BroadcastCreateRequestToJson(
  BroadcastCreateRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'message': instance.message,
  'type': _$BroadcastCreateRequestTypeEnumEnumMap[instance.type]!,
  'targetAudience':
      _$BroadcastCreateRequestTargetAudienceEnumEnumMap[instance
          .targetAudience]!,
  'targetIds': ?instance.targetIds,
  'scheduledAt': ?instance.scheduledAt?.toIso8601String(),
};

const _$BroadcastCreateRequestTypeEnumEnumMap = {
  BroadcastCreateRequestTypeEnum.EMAIL: 'EMAIL',
  BroadcastCreateRequestTypeEnum.IN_APP: 'IN_APP',
  BroadcastCreateRequestTypeEnum.ALL: 'ALL',
};

const _$BroadcastCreateRequestTargetAudienceEnumEnumMap = {
  BroadcastCreateRequestTargetAudienceEnum.ALL: 'ALL',
  BroadcastCreateRequestTargetAudienceEnum.USERS: 'USERS',
  BroadcastCreateRequestTargetAudienceEnum.DRIVERS: 'DRIVERS',
  BroadcastCreateRequestTargetAudienceEnum.MERCHANTS: 'MERCHANTS',
  BroadcastCreateRequestTargetAudienceEnum.ADMINS: 'ADMINS',
  BroadcastCreateRequestTargetAudienceEnum.OPERATORS: 'OPERATORS',
};
