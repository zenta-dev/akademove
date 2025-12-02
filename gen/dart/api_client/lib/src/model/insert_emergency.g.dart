// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_emergency.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertEmergencyCWProxy {
  InsertEmergency orderId(String orderId);

  InsertEmergency userId(String userId);

  InsertEmergency driverId(String? driverId);

  InsertEmergency type(EmergencyType type);

  InsertEmergency status(EmergencyStatus status);

  InsertEmergency description(String description);

  InsertEmergency location(EmergencyLocation? location);

  InsertEmergency contactedAuthorities(List<String>? contactedAuthorities);

  InsertEmergency respondedById(String? respondedById);

  InsertEmergency resolution(String? resolution);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertEmergency(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertEmergency(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertEmergency call({
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
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertEmergency.copyWith(...)` or call `instanceOfInsertEmergency.copyWith.fieldName(value)` for a single field.
class _$InsertEmergencyCWProxyImpl implements _$InsertEmergencyCWProxy {
  const _$InsertEmergencyCWProxyImpl(this._value);

  final InsertEmergency _value;

  @override
  InsertEmergency orderId(String orderId) => call(orderId: orderId);

  @override
  InsertEmergency userId(String userId) => call(userId: userId);

  @override
  InsertEmergency driverId(String? driverId) => call(driverId: driverId);

  @override
  InsertEmergency type(EmergencyType type) => call(type: type);

  @override
  InsertEmergency status(EmergencyStatus status) => call(status: status);

  @override
  InsertEmergency description(String description) => call(description: description);

  @override
  InsertEmergency location(EmergencyLocation? location) => call(location: location);

  @override
  InsertEmergency contactedAuthorities(List<String>? contactedAuthorities) =>
      call(contactedAuthorities: contactedAuthorities);

  @override
  InsertEmergency respondedById(String? respondedById) => call(respondedById: respondedById);

  @override
  InsertEmergency resolution(String? resolution) => call(resolution: resolution);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertEmergency(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertEmergency(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertEmergency call({
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
  }) {
    return InsertEmergency(
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
      description: description == const $CopyWithPlaceholder() || description == null
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
    );
  }
}

extension $InsertEmergencyCopyWith on InsertEmergency {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertEmergency.copyWith(...)` or `instanceOfInsertEmergency.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertEmergencyCWProxy get copyWith => _$InsertEmergencyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertEmergency _$InsertEmergencyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertEmergency', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['orderId', 'userId', 'type', 'status', 'description']);
      final val = InsertEmergency(
        orderId: $checkedConvert('orderId', (v) => v as String),
        userId: $checkedConvert('userId', (v) => v as String),
        driverId: $checkedConvert('driverId', (v) => v as String?),
        type: $checkedConvert('type', (v) => $enumDecode(_$EmergencyTypeEnumMap, v)),
        status: $checkedConvert('status', (v) => $enumDecode(_$EmergencyStatusEnumMap, v)),
        description: $checkedConvert('description', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => v == null ? null : EmergencyLocation.fromJson(v as Map<String, dynamic>),
        ),
        contactedAuthorities: $checkedConvert(
          'contactedAuthorities',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        respondedById: $checkedConvert('respondedById', (v) => v as String?),
        resolution: $checkedConvert('resolution', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$InsertEmergencyToJson(InsertEmergency instance) => <String, dynamic>{
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
