// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BroadcastUpdateRequestCWProxy {
  BroadcastUpdateRequest title(String? title);

  BroadcastUpdateRequest message(String? message);

  BroadcastUpdateRequest type(BroadcastUpdateRequestTypeEnum? type);

  BroadcastUpdateRequest targetAudience(
    BroadcastUpdateRequestTargetAudienceEnum? targetAudience,
  );

  BroadcastUpdateRequest targetIds(List<String>? targetIds);

  BroadcastUpdateRequest scheduledAt(DateTime? scheduledAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastUpdateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastUpdateRequest call({
    String? title,
    String? message,
    BroadcastUpdateRequestTypeEnum? type,
    BroadcastUpdateRequestTargetAudienceEnum? targetAudience,
    List<String>? targetIds,
    DateTime? scheduledAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBroadcastUpdateRequest.copyWith(...)` or call `instanceOfBroadcastUpdateRequest.copyWith.fieldName(value)` for a single field.
class _$BroadcastUpdateRequestCWProxyImpl
    implements _$BroadcastUpdateRequestCWProxy {
  const _$BroadcastUpdateRequestCWProxyImpl(this._value);

  final BroadcastUpdateRequest _value;

  @override
  BroadcastUpdateRequest title(String? title) => call(title: title);

  @override
  BroadcastUpdateRequest message(String? message) => call(message: message);

  @override
  BroadcastUpdateRequest type(BroadcastUpdateRequestTypeEnum? type) =>
      call(type: type);

  @override
  BroadcastUpdateRequest targetAudience(
    BroadcastUpdateRequestTargetAudienceEnum? targetAudience,
  ) => call(targetAudience: targetAudience);

  @override
  BroadcastUpdateRequest targetIds(List<String>? targetIds) =>
      call(targetIds: targetIds);

  @override
  BroadcastUpdateRequest scheduledAt(DateTime? scheduledAt) =>
      call(scheduledAt: scheduledAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastUpdateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastUpdateRequest call({
    Object? title = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? targetAudience = const $CopyWithPlaceholder(),
    Object? targetIds = const $CopyWithPlaceholder(),
    Object? scheduledAt = const $CopyWithPlaceholder(),
  }) {
    return BroadcastUpdateRequest(
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as BroadcastUpdateRequestTypeEnum?,
      targetAudience: targetAudience == const $CopyWithPlaceholder()
          ? _value.targetAudience
          // ignore: cast_nullable_to_non_nullable
          : targetAudience as BroadcastUpdateRequestTargetAudienceEnum?,
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

extension $BroadcastUpdateRequestCopyWith on BroadcastUpdateRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBroadcastUpdateRequest.copyWith(...)` or `instanceOfBroadcastUpdateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BroadcastUpdateRequestCWProxy get copyWith =>
      _$BroadcastUpdateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BroadcastUpdateRequest _$BroadcastUpdateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BroadcastUpdateRequest', json, ($checkedConvert) {
  final val = BroadcastUpdateRequest(
    title: $checkedConvert('title', (v) => v as String?),
    message: $checkedConvert('message', (v) => v as String?),
    type: $checkedConvert(
      'type',
      (v) => $enumDecodeNullable(_$BroadcastUpdateRequestTypeEnumEnumMap, v),
    ),
    targetAudience: $checkedConvert(
      'targetAudience',
      (v) => $enumDecodeNullable(
        _$BroadcastUpdateRequestTargetAudienceEnumEnumMap,
        v,
      ),
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

Map<String, dynamic> _$BroadcastUpdateRequestToJson(
  BroadcastUpdateRequest instance,
) => <String, dynamic>{
  'title': ?instance.title,
  'message': ?instance.message,
  'type': ?_$BroadcastUpdateRequestTypeEnumEnumMap[instance.type],
  'targetAudience':
      ?_$BroadcastUpdateRequestTargetAudienceEnumEnumMap[instance
          .targetAudience],
  'targetIds': ?instance.targetIds,
  'scheduledAt': ?instance.scheduledAt?.toIso8601String(),
};

const _$BroadcastUpdateRequestTypeEnumEnumMap = {
  BroadcastUpdateRequestTypeEnum.EMAIL: 'EMAIL',
  BroadcastUpdateRequestTypeEnum.IN_APP: 'IN_APP',
  BroadcastUpdateRequestTypeEnum.ALL: 'ALL',
};

const _$BroadcastUpdateRequestTargetAudienceEnumEnumMap = {
  BroadcastUpdateRequestTargetAudienceEnum.ALL: 'ALL',
  BroadcastUpdateRequestTargetAudienceEnum.USERS: 'USERS',
  BroadcastUpdateRequestTargetAudienceEnum.DRIVERS: 'DRIVERS',
  BroadcastUpdateRequestTargetAudienceEnum.MERCHANTS: 'MERCHANTS',
  BroadcastUpdateRequestTargetAudienceEnum.ADMINS: 'ADMINS',
  BroadcastUpdateRequestTargetAudienceEnum.OPERATORS: 'OPERATORS',
};
