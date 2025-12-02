// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_emergency.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateEmergencyCWProxy {
  UpdateEmergency orderId(String? orderId);

  UpdateEmergency userId(String? userId);

  UpdateEmergency driverId(String? driverId);

  UpdateEmergency type(EmergencyType? type);

  UpdateEmergency status(EmergencyStatus? status);

  UpdateEmergency description(String? description);

  UpdateEmergency location(EmergencyLocation? location);

  UpdateEmergency contactedAuthorities(List<String>? contactedAuthorities);

  UpdateEmergency respondedById(String? respondedById);

  UpdateEmergency resolution(String? resolution);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateEmergency(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateEmergency(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateEmergency call({
    String? orderId,
    String? userId,
    String? driverId,
    EmergencyType? type,
    EmergencyStatus? status,
    String? description,
    EmergencyLocation? location,
    List<String>? contactedAuthorities,
    String? respondedById,
    String? resolution,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateEmergency.copyWith(...)` or call `instanceOfUpdateEmergency.copyWith.fieldName(value)` for a single field.
class _$UpdateEmergencyCWProxyImpl implements _$UpdateEmergencyCWProxy {
  const _$UpdateEmergencyCWProxyImpl(this._value);

  final UpdateEmergency _value;

  @override
  UpdateEmergency orderId(String? orderId) => call(orderId: orderId);

  @override
  UpdateEmergency userId(String? userId) => call(userId: userId);

  @override
  UpdateEmergency driverId(String? driverId) => call(driverId: driverId);

  @override
  UpdateEmergency type(EmergencyType? type) => call(type: type);

  @override
  UpdateEmergency status(EmergencyStatus? status) => call(status: status);

  @override
  UpdateEmergency description(String? description) => call(description: description);

  @override
  UpdateEmergency location(EmergencyLocation? location) => call(location: location);

  @override
  UpdateEmergency contactedAuthorities(List<String>? contactedAuthorities) =>
      call(contactedAuthorities: contactedAuthorities);

  @override
  UpdateEmergency respondedById(String? respondedById) => call(respondedById: respondedById);

  @override
  UpdateEmergency resolution(String? resolution) => call(resolution: resolution);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateEmergency(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateEmergency(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateEmergency call({
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
    return UpdateEmergency(
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      driverId: driverId == const $CopyWithPlaceholder()
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as EmergencyType?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as EmergencyStatus?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
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

extension $UpdateEmergencyCopyWith on UpdateEmergency {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateEmergency.copyWith(...)` or `instanceOfUpdateEmergency.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateEmergencyCWProxy get copyWith => _$UpdateEmergencyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateEmergency _$UpdateEmergencyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateEmergency', json, ($checkedConvert) {
      final val = UpdateEmergency(
        orderId: $checkedConvert('orderId', (v) => v as String?),
        userId: $checkedConvert('userId', (v) => v as String?),
        driverId: $checkedConvert('driverId', (v) => v as String?),
        type: $checkedConvert('type', (v) => $enumDecodeNullable(_$EmergencyTypeEnumMap, v)),
        status: $checkedConvert('status', (v) => $enumDecodeNullable(_$EmergencyStatusEnumMap, v)),
        description: $checkedConvert('description', (v) => v as String?),
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

Map<String, dynamic> _$UpdateEmergencyToJson(UpdateEmergency instance) => <String, dynamic>{
  'orderId': ?instance.orderId,
  'userId': ?instance.userId,
  'driverId': ?instance.driverId,
  'type': ?_$EmergencyTypeEnumMap[instance.type],
  'status': ?_$EmergencyStatusEnumMap[instance.status],
  'description': ?instance.description,
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
