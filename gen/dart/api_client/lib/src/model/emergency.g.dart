// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyCWProxy {
  Emergency id(String id);

  Emergency orderId(String orderId);

  Emergency userId(String userId);

  Emergency driverId(String? driverId);

  Emergency type(EmergencyType type);

  Emergency status(EmergencyStatus status);

  Emergency description(String description);

  Emergency location(EmergencyLocation? location);

  Emergency contactedAuthorities(List<String>? contactedAuthorities);

  Emergency respondedById(String? respondedById);

  Emergency resolution(String? resolution);

  Emergency reportedAt(DateTime reportedAt);

  Emergency acknowledgedAt(DateTime? acknowledgedAt);

  Emergency respondingAt(DateTime? respondingAt);

  Emergency resolvedAt(DateTime? resolvedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Emergency(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Emergency(...).copyWith(id: 12, name: "My name")
  /// ```
  Emergency call({
    String id,
    String orderId,
    String userId,
    String? driverId,
    EmergencyType type,
    EmergencyStatus status,
    String description,
    EmergencyLocation? location,
    List<String>? contactedAuthorities,
    String? respondedById,
    String? resolution,
    DateTime reportedAt,
    DateTime? acknowledgedAt,
    DateTime? respondingAt,
    DateTime? resolvedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergency.copyWith(...)` or call `instanceOfEmergency.copyWith.fieldName(value)` for a single field.
class _$EmergencyCWProxyImpl implements _$EmergencyCWProxy {
  const _$EmergencyCWProxyImpl(this._value);

  final Emergency _value;

  @override
  Emergency id(String id) => call(id: id);

  @override
  Emergency orderId(String orderId) => call(orderId: orderId);

  @override
  Emergency userId(String userId) => call(userId: userId);

  @override
  Emergency driverId(String? driverId) => call(driverId: driverId);

  @override
  Emergency type(EmergencyType type) => call(type: type);

  @override
  Emergency status(EmergencyStatus status) => call(status: status);

  @override
  Emergency description(String description) => call(description: description);

  @override
  Emergency location(EmergencyLocation? location) => call(location: location);

  @override
  Emergency contactedAuthorities(List<String>? contactedAuthorities) =>
      call(contactedAuthorities: contactedAuthorities);

  @override
  Emergency respondedById(String? respondedById) =>
      call(respondedById: respondedById);

  @override
  Emergency resolution(String? resolution) => call(resolution: resolution);

  @override
  Emergency reportedAt(DateTime reportedAt) => call(reportedAt: reportedAt);

  @override
  Emergency acknowledgedAt(DateTime? acknowledgedAt) =>
      call(acknowledgedAt: acknowledgedAt);

  @override
  Emergency respondingAt(DateTime? respondingAt) =>
      call(respondingAt: respondingAt);

  @override
  Emergency resolvedAt(DateTime? resolvedAt) => call(resolvedAt: resolvedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Emergency(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Emergency(...).copyWith(id: 12, name: "My name")
  /// ```
  Emergency call({
    Object? id = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? driverId = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? location = const $CopyWithPlaceholder(),
    Object? contactedAuthorities = const $CopyWithPlaceholder(),
    Object? respondedById = const $CopyWithPlaceholder(),
    Object? resolution = const $CopyWithPlaceholder(),
    Object? reportedAt = const $CopyWithPlaceholder(),
    Object? acknowledgedAt = const $CopyWithPlaceholder(),
    Object? respondingAt = const $CopyWithPlaceholder(),
    Object? resolvedAt = const $CopyWithPlaceholder(),
  }) {
    return Emergency(
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
          : type as EmergencyType,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as EmergencyStatus,
      description:
          description == const $CopyWithPlaceholder() || description == null
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      location: location == const $CopyWithPlaceholder()
          ? _value.location
          // ignore: cast_nullable_to_non_nullable
          : location as EmergencyLocation?,
      contactedAuthorities: contactedAuthorities == const $CopyWithPlaceholder()
          ? _value.contactedAuthorities
          // ignore: cast_nullable_to_non_nullable
          : contactedAuthorities as List<String>?,
      respondedById: respondedById == const $CopyWithPlaceholder()
          ? _value.respondedById
          // ignore: cast_nullable_to_non_nullable
          : respondedById as String?,
      resolution: resolution == const $CopyWithPlaceholder()
          ? _value.resolution
          // ignore: cast_nullable_to_non_nullable
          : resolution as String?,
      reportedAt:
          reportedAt == const $CopyWithPlaceholder() || reportedAt == null
          ? _value.reportedAt
          // ignore: cast_nullable_to_non_nullable
          : reportedAt as DateTime,
      acknowledgedAt: acknowledgedAt == const $CopyWithPlaceholder()
          ? _value.acknowledgedAt
          // ignore: cast_nullable_to_non_nullable
          : acknowledgedAt as DateTime?,
      respondingAt: respondingAt == const $CopyWithPlaceholder()
          ? _value.respondingAt
          // ignore: cast_nullable_to_non_nullable
          : respondingAt as DateTime?,
      resolvedAt: resolvedAt == const $CopyWithPlaceholder()
          ? _value.resolvedAt
          // ignore: cast_nullable_to_non_nullable
          : resolvedAt as DateTime?,
    );
  }
}

extension $EmergencyCopyWith on Emergency {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergency.copyWith(...)` or `instanceOfEmergency.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyCWProxy get copyWith => _$EmergencyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Emergency _$EmergencyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Emergency', json, ($checkedConvert) {
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
      final val = Emergency(
        id: $checkedConvert('id', (v) => v as String),
        orderId: $checkedConvert('orderId', (v) => v as String),
        userId: $checkedConvert('userId', (v) => v as String),
        driverId: $checkedConvert('driverId', (v) => v as String?),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$EmergencyTypeEnumMap, v),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$EmergencyStatusEnumMap, v),
        ),
        description: $checkedConvert('description', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => v == null
              ? null
              : EmergencyLocation.fromJson(v as Map<String, dynamic>),
        ),
        contactedAuthorities: $checkedConvert(
          'contactedAuthorities',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        respondedById: $checkedConvert('respondedById', (v) => v as String?),
        resolution: $checkedConvert('resolution', (v) => v as String?),
        reportedAt: $checkedConvert(
          'reportedAt',
          (v) => DateTime.parse(v as String),
        ),
        acknowledgedAt: $checkedConvert(
          'acknowledgedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        respondingAt: $checkedConvert(
          'respondingAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        resolvedAt: $checkedConvert(
          'resolvedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EmergencyToJson(Emergency instance) => <String, dynamic>{
  'id': instance.id,
  'orderId': instance.orderId,
  'userId': instance.userId,
  'driverId': ?instance.driverId,
  'type': _$EmergencyTypeEnumMap[instance.type]!,
  'status': _$EmergencyStatusEnumMap[instance.status]!,
  'description': instance.description,
  'location': ?instance.location?.toJson(),
  'contactedAuthorities': ?instance.contactedAuthorities,
  'respondedById': ?instance.respondedById,
  'resolution': ?instance.resolution,
  'reportedAt': instance.reportedAt.toIso8601String(),
  'acknowledgedAt': ?instance.acknowledgedAt?.toIso8601String(),
  'respondingAt': ?instance.respondingAt?.toIso8601String(),
  'resolvedAt': ?instance.resolvedAt?.toIso8601String(),
};

const _$EmergencyTypeEnumMap = {
  EmergencyType.ACCIDENT: 'ACCIDENT',
  EmergencyType.HARASSMENT: 'HARASSMENT',
  EmergencyType.THEFT: 'THEFT',
  EmergencyType.MEDICAL: 'MEDICAL',
  EmergencyType.OTHER: 'OTHER',
};

const _$EmergencyStatusEnumMap = {
  EmergencyStatus.REPORTED: 'REPORTED',
  EmergencyStatus.ACKNOWLEDGED: 'ACKNOWLEDGED',
  EmergencyStatus.RESPONDING: 'RESPONDING',
  EmergencyStatus.RESOLVED: 'RESOLVED',
};
