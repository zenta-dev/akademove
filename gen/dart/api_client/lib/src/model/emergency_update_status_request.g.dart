// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_update_status_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyUpdateStatusRequestCWProxy {
  EmergencyUpdateStatusRequest status(EmergencyStatus? status);

  EmergencyUpdateStatusRequest resolution(String? resolution);

  EmergencyUpdateStatusRequest respondedById(String? respondedById);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyUpdateStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyUpdateStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyUpdateStatusRequest call({
    EmergencyStatus? status,
    String? resolution,
    String? respondedById,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyUpdateStatusRequest.copyWith(...)` or call `instanceOfEmergencyUpdateStatusRequest.copyWith.fieldName(value)` for a single field.
class _$EmergencyUpdateStatusRequestCWProxyImpl
    implements _$EmergencyUpdateStatusRequestCWProxy {
  const _$EmergencyUpdateStatusRequestCWProxyImpl(this._value);

  final EmergencyUpdateStatusRequest _value;

  @override
  EmergencyUpdateStatusRequest status(EmergencyStatus? status) =>
      call(status: status);

  @override
  EmergencyUpdateStatusRequest resolution(String? resolution) =>
      call(resolution: resolution);

  @override
  EmergencyUpdateStatusRequest respondedById(String? respondedById) =>
      call(respondedById: respondedById);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyUpdateStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyUpdateStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyUpdateStatusRequest call({
    Object? status = const $CopyWithPlaceholder(),
    Object? resolution = const $CopyWithPlaceholder(),
    Object? respondedById = const $CopyWithPlaceholder(),
  }) {
    return EmergencyUpdateStatusRequest(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as EmergencyStatus?,
      resolution: resolution == const $CopyWithPlaceholder()
          ? _value.resolution
          // ignore: cast_nullable_to_non_nullable
          : resolution as String?,
      respondedById: respondedById == const $CopyWithPlaceholder()
          ? _value.respondedById
          // ignore: cast_nullable_to_non_nullable
          : respondedById as String?,
    );
  }
}

extension $EmergencyUpdateStatusRequestCopyWith
    on EmergencyUpdateStatusRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyUpdateStatusRequest.copyWith(...)` or `instanceOfEmergencyUpdateStatusRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyUpdateStatusRequestCWProxy get copyWith =>
      _$EmergencyUpdateStatusRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyUpdateStatusRequest _$EmergencyUpdateStatusRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmergencyUpdateStatusRequest', json, ($checkedConvert) {
  final val = EmergencyUpdateStatusRequest(
    status: $checkedConvert(
      'status',
      (v) => $enumDecodeNullable(_$EmergencyStatusEnumMap, v),
    ),
    resolution: $checkedConvert('resolution', (v) => v as String?),
    respondedById: $checkedConvert('respondedById', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$EmergencyUpdateStatusRequestToJson(
  EmergencyUpdateStatusRequest instance,
) => <String, dynamic>{
  'status': ?_$EmergencyStatusEnumMap[instance.status],
  'resolution': ?instance.resolution,
  'respondedById': ?instance.respondedById,
};

const _$EmergencyStatusEnumMap = {
  EmergencyStatus.REPORTED: 'REPORTED',
  EmergencyStatus.ACKNOWLEDGED: 'ACKNOWLEDGED',
  EmergencyStatus.RESPONDING: 'RESPONDING',
  EmergencyStatus.RESOLVED: 'RESOLVED',
};
