// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_with_contact_emergency.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyWithContactEmergencyCWProxy {
  EmergencyWithContactEmergency id(String id);

  EmergencyWithContactEmergency orderId(String orderId);

  EmergencyWithContactEmergency userId(String userId);

  EmergencyWithContactEmergency driverId(String? driverId);

  EmergencyWithContactEmergency type(String type);

  EmergencyWithContactEmergency status(String status);

  EmergencyWithContactEmergency description(String description);

  EmergencyWithContactEmergency location(EmergencyLocation? location);

  EmergencyWithContactEmergency reportedAt(DateTime reportedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyWithContactEmergency(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyWithContactEmergency(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyWithContactEmergency call({
    String id,
    String orderId,
    String userId,
    String? driverId,
    String type,
    String status,
    String description,
    EmergencyLocation? location,
    DateTime reportedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyWithContactEmergency.copyWith(...)` or call `instanceOfEmergencyWithContactEmergency.copyWith.fieldName(value)` for a single field.
class _$EmergencyWithContactEmergencyCWProxyImpl
    implements _$EmergencyWithContactEmergencyCWProxy {
  const _$EmergencyWithContactEmergencyCWProxyImpl(this._value);

  final EmergencyWithContactEmergency _value;

  @override
  EmergencyWithContactEmergency id(String id) => call(id: id);

  @override
  EmergencyWithContactEmergency orderId(String orderId) =>
      call(orderId: orderId);

  @override
  EmergencyWithContactEmergency userId(String userId) => call(userId: userId);

  @override
  EmergencyWithContactEmergency driverId(String? driverId) =>
      call(driverId: driverId);

  @override
  EmergencyWithContactEmergency type(String type) => call(type: type);

  @override
  EmergencyWithContactEmergency status(String status) => call(status: status);

  @override
  EmergencyWithContactEmergency description(String description) =>
      call(description: description);

  @override
  EmergencyWithContactEmergency location(EmergencyLocation? location) =>
      call(location: location);

  @override
  EmergencyWithContactEmergency reportedAt(DateTime reportedAt) =>
      call(reportedAt: reportedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyWithContactEmergency(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyWithContactEmergency(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyWithContactEmergency call({
    Object? id = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? driverId = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? location = const $CopyWithPlaceholder(),
    Object? reportedAt = const $CopyWithPlaceholder(),
  }) {
    return EmergencyWithContactEmergency(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      driverId: driverId == const $CopyWithPlaceholder()
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String?,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String,
      description:
          description == const $CopyWithPlaceholder() || description == null
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      location: location == const $CopyWithPlaceholder()
          ? _value.location
          // ignore: cast_nullable_to_non_nullable
          : location as EmergencyLocation?,
      reportedAt:
          reportedAt == const $CopyWithPlaceholder() || reportedAt == null
          ? _value.reportedAt
          // ignore: cast_nullable_to_non_nullable
          : reportedAt as DateTime,
    );
  }
}

extension $EmergencyWithContactEmergencyCopyWith
    on EmergencyWithContactEmergency {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyWithContactEmergency.copyWith(...)` or `instanceOfEmergencyWithContactEmergency.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyWithContactEmergencyCWProxy get copyWith =>
      _$EmergencyWithContactEmergencyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyWithContactEmergency _$EmergencyWithContactEmergencyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmergencyWithContactEmergency', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'orderId',
      'userId',
      'type',
      'status',
      'description',
      'reportedAt',
    ],
  );
  final val = EmergencyWithContactEmergency(
    id: $checkedConvert('id', (v) => v as String),
    orderId: $checkedConvert('orderId', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    driverId: $checkedConvert('driverId', (v) => v as String?),
    type: $checkedConvert('type', (v) => v as String),
    status: $checkedConvert('status', (v) => v as String),
    description: $checkedConvert('description', (v) => v as String),
    location: $checkedConvert(
      'location',
      (v) => v == null
          ? null
          : EmergencyLocation.fromJson(v as Map<String, dynamic>),
    ),
    reportedAt: $checkedConvert(
      'reportedAt',
      (v) => DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$EmergencyWithContactEmergencyToJson(
  EmergencyWithContactEmergency instance,
) => <String, dynamic>{
  'id': instance.id,
  'orderId': instance.orderId,
  'userId': instance.userId,
  'driverId': ?instance.driverId,
  'type': instance.type,
  'status': instance.status,
  'description': instance.description,
  'location': ?instance.location?.toJson(),
  'reportedAt': instance.reportedAt.toIso8601String(),
};
