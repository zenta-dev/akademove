// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudEventCWProxy {
  FraudEvent id(String id);

  FraudEvent eventType(FraudEventType eventType);

  FraudEvent severity(FraudSeverity severity);

  FraudEvent status(FraudStatus status);

  FraudEvent userId(String? userId);

  FraudEvent driverId(String? driverId);

  FraudEvent signals(List<FraudSignal> signals);

  FraudEvent score(num score);

  FraudEvent location(Location? location);

  FraudEvent previousLocation(Location? previousLocation);

  FraudEvent distanceKm(num? distanceKm);

  FraudEvent timeDeltaSeconds(int? timeDeltaSeconds);

  FraudEvent velocityKmh(num? velocityKmh);

  FraudEvent ipAddress(String? ipAddress);

  FraudEvent userAgent(String? userAgent);

  FraudEvent handledById(String? handledById);

  FraudEvent resolution(String? resolution);

  FraudEvent actionTaken(String? actionTaken);

  FraudEvent detectedAt(DateTime detectedAt);

  FraudEvent resolvedAt(DateTime? resolvedAt);

  FraudEvent createdAt(DateTime createdAt);

  FraudEvent updatedAt(DateTime updatedAt);

  FraudEvent user(FraudEventUser? user);

  FraudEvent driver(FraudEventDriver? driver);

  FraudEvent handledBy(FraudEventHandledBy? handledBy);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudEvent(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudEvent(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudEvent call({
    String id,
    FraudEventType eventType,
    FraudSeverity severity,
    FraudStatus status,
    String? userId,
    String? driverId,
    List<FraudSignal> signals,
    num score,
    Location? location,
    Location? previousLocation,
    num? distanceKm,
    int? timeDeltaSeconds,
    num? velocityKmh,
    String? ipAddress,
    String? userAgent,
    String? handledById,
    String? resolution,
    String? actionTaken,
    DateTime detectedAt,
    DateTime? resolvedAt,
    DateTime createdAt,
    DateTime updatedAt,
    FraudEventUser? user,
    FraudEventDriver? driver,
    FraudEventHandledBy? handledBy,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudEvent.copyWith(...)` or call `instanceOfFraudEvent.copyWith.fieldName(value)` for a single field.
class _$FraudEventCWProxyImpl implements _$FraudEventCWProxy {
  const _$FraudEventCWProxyImpl(this._value);

  final FraudEvent _value;

  @override
  FraudEvent id(String id) => call(id: id);

  @override
  FraudEvent eventType(FraudEventType eventType) => call(eventType: eventType);

  @override
  FraudEvent severity(FraudSeverity severity) => call(severity: severity);

  @override
  FraudEvent status(FraudStatus status) => call(status: status);

  @override
  FraudEvent userId(String? userId) => call(userId: userId);

  @override
  FraudEvent driverId(String? driverId) => call(driverId: driverId);

  @override
  FraudEvent signals(List<FraudSignal> signals) => call(signals: signals);

  @override
  FraudEvent score(num score) => call(score: score);

  @override
  FraudEvent location(Location? location) => call(location: location);

  @override
  FraudEvent previousLocation(Location? previousLocation) =>
      call(previousLocation: previousLocation);

  @override
  FraudEvent distanceKm(num? distanceKm) => call(distanceKm: distanceKm);

  @override
  FraudEvent timeDeltaSeconds(int? timeDeltaSeconds) =>
      call(timeDeltaSeconds: timeDeltaSeconds);

  @override
  FraudEvent velocityKmh(num? velocityKmh) => call(velocityKmh: velocityKmh);

  @override
  FraudEvent ipAddress(String? ipAddress) => call(ipAddress: ipAddress);

  @override
  FraudEvent userAgent(String? userAgent) => call(userAgent: userAgent);

  @override
  FraudEvent handledById(String? handledById) => call(handledById: handledById);

  @override
  FraudEvent resolution(String? resolution) => call(resolution: resolution);

  @override
  FraudEvent actionTaken(String? actionTaken) => call(actionTaken: actionTaken);

  @override
  FraudEvent detectedAt(DateTime detectedAt) => call(detectedAt: detectedAt);

  @override
  FraudEvent resolvedAt(DateTime? resolvedAt) => call(resolvedAt: resolvedAt);

  @override
  FraudEvent createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  FraudEvent updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  FraudEvent user(FraudEventUser? user) => call(user: user);

  @override
  FraudEvent driver(FraudEventDriver? driver) => call(driver: driver);

  @override
  FraudEvent handledBy(FraudEventHandledBy? handledBy) =>
      call(handledBy: handledBy);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudEvent(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudEvent(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudEvent call({
    Object? id = const $CopyWithPlaceholder(),
    Object? eventType = const $CopyWithPlaceholder(),
    Object? severity = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? driverId = const $CopyWithPlaceholder(),
    Object? signals = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
    Object? location = const $CopyWithPlaceholder(),
    Object? previousLocation = const $CopyWithPlaceholder(),
    Object? distanceKm = const $CopyWithPlaceholder(),
    Object? timeDeltaSeconds = const $CopyWithPlaceholder(),
    Object? velocityKmh = const $CopyWithPlaceholder(),
    Object? ipAddress = const $CopyWithPlaceholder(),
    Object? userAgent = const $CopyWithPlaceholder(),
    Object? handledById = const $CopyWithPlaceholder(),
    Object? resolution = const $CopyWithPlaceholder(),
    Object? actionTaken = const $CopyWithPlaceholder(),
    Object? detectedAt = const $CopyWithPlaceholder(),
    Object? resolvedAt = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? driver = const $CopyWithPlaceholder(),
    Object? handledBy = const $CopyWithPlaceholder(),
  }) {
    return FraudEvent(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      eventType: eventType == const $CopyWithPlaceholder() || eventType == null
          ? _value.eventType
          // ignore: cast_nullable_to_non_nullable
          : eventType as FraudEventType,
      severity: severity == const $CopyWithPlaceholder() || severity == null
          ? _value.severity
          // ignore: cast_nullable_to_non_nullable
          : severity as FraudSeverity,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as FraudStatus,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      driverId: driverId == const $CopyWithPlaceholder()
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String?,
      signals: signals == const $CopyWithPlaceholder() || signals == null
          ? _value.signals
          // ignore: cast_nullable_to_non_nullable
          : signals as List<FraudSignal>,
      score: score == const $CopyWithPlaceholder() || score == null
          ? _value.score
          // ignore: cast_nullable_to_non_nullable
          : score as num,
      location: location == const $CopyWithPlaceholder()
          ? _value.location
          // ignore: cast_nullable_to_non_nullable
          : location as Location?,
      previousLocation: previousLocation == const $CopyWithPlaceholder()
          ? _value.previousLocation
          // ignore: cast_nullable_to_non_nullable
          : previousLocation as Location?,
      distanceKm: distanceKm == const $CopyWithPlaceholder()
          ? _value.distanceKm
          // ignore: cast_nullable_to_non_nullable
          : distanceKm as num?,
      timeDeltaSeconds: timeDeltaSeconds == const $CopyWithPlaceholder()
          ? _value.timeDeltaSeconds
          // ignore: cast_nullable_to_non_nullable
          : timeDeltaSeconds as int?,
      velocityKmh: velocityKmh == const $CopyWithPlaceholder()
          ? _value.velocityKmh
          // ignore: cast_nullable_to_non_nullable
          : velocityKmh as num?,
      ipAddress: ipAddress == const $CopyWithPlaceholder()
          ? _value.ipAddress
          // ignore: cast_nullable_to_non_nullable
          : ipAddress as String?,
      userAgent: userAgent == const $CopyWithPlaceholder()
          ? _value.userAgent
          // ignore: cast_nullable_to_non_nullable
          : userAgent as String?,
      handledById: handledById == const $CopyWithPlaceholder()
          ? _value.handledById
          // ignore: cast_nullable_to_non_nullable
          : handledById as String?,
      resolution: resolution == const $CopyWithPlaceholder()
          ? _value.resolution
          // ignore: cast_nullable_to_non_nullable
          : resolution as String?,
      actionTaken: actionTaken == const $CopyWithPlaceholder()
          ? _value.actionTaken
          // ignore: cast_nullable_to_non_nullable
          : actionTaken as String?,
      detectedAt:
          detectedAt == const $CopyWithPlaceholder() || detectedAt == null
          ? _value.detectedAt
          // ignore: cast_nullable_to_non_nullable
          : detectedAt as DateTime,
      resolvedAt: resolvedAt == const $CopyWithPlaceholder()
          ? _value.resolvedAt
          // ignore: cast_nullable_to_non_nullable
          : resolvedAt as DateTime?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as FraudEventUser?,
      driver: driver == const $CopyWithPlaceholder()
          ? _value.driver
          // ignore: cast_nullable_to_non_nullable
          : driver as FraudEventDriver?,
      handledBy: handledBy == const $CopyWithPlaceholder()
          ? _value.handledBy
          // ignore: cast_nullable_to_non_nullable
          : handledBy as FraudEventHandledBy?,
    );
  }
}

extension $FraudEventCopyWith on FraudEvent {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudEvent.copyWith(...)` or `instanceOfFraudEvent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudEventCWProxy get copyWith => _$FraudEventCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudEvent _$FraudEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FraudEvent', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'eventType',
      'severity',
      'status',
      'userId',
      'driverId',
      'signals',
      'score',
      'location',
      'previousLocation',
      'distanceKm',
      'timeDeltaSeconds',
      'velocityKmh',
      'ipAddress',
      'userAgent',
      'handledById',
      'resolution',
      'actionTaken',
      'detectedAt',
      'resolvedAt',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = FraudEvent(
    id: $checkedConvert('id', (v) => v as String),
    eventType: $checkedConvert(
      'eventType',
      (v) => $enumDecode(_$FraudEventTypeEnumMap, v),
    ),
    severity: $checkedConvert(
      'severity',
      (v) => $enumDecode(_$FraudSeverityEnumMap, v),
    ),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$FraudStatusEnumMap, v),
    ),
    userId: $checkedConvert('userId', (v) => v as String?),
    driverId: $checkedConvert('driverId', (v) => v as String?),
    signals: $checkedConvert(
      'signals',
      (v) => (v as List<dynamic>)
          .map((e) => FraudSignal.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    score: $checkedConvert('score', (v) => v as num),
    location: $checkedConvert(
      'location',
      (v) => v == null ? null : Location.fromJson(v as Map<String, dynamic>),
    ),
    previousLocation: $checkedConvert(
      'previousLocation',
      (v) => v == null ? null : Location.fromJson(v as Map<String, dynamic>),
    ),
    distanceKm: $checkedConvert('distanceKm', (v) => v as num?),
    timeDeltaSeconds: $checkedConvert(
      'timeDeltaSeconds',
      (v) => (v as num?)?.toInt(),
    ),
    velocityKmh: $checkedConvert('velocityKmh', (v) => v as num?),
    ipAddress: $checkedConvert('ipAddress', (v) => v as String?),
    userAgent: $checkedConvert('userAgent', (v) => v as String?),
    handledById: $checkedConvert('handledById', (v) => v as String?),
    resolution: $checkedConvert('resolution', (v) => v as String?),
    actionTaken: $checkedConvert('actionTaken', (v) => v as String?),
    detectedAt: $checkedConvert(
      'detectedAt',
      (v) => DateTime.parse(v as String),
    ),
    resolvedAt: $checkedConvert(
      'resolvedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
    user: $checkedConvert(
      'user',
      (v) =>
          v == null ? null : FraudEventUser.fromJson(v as Map<String, dynamic>),
    ),
    driver: $checkedConvert(
      'driver',
      (v) => v == null
          ? null
          : FraudEventDriver.fromJson(v as Map<String, dynamic>),
    ),
    handledBy: $checkedConvert(
      'handledBy',
      (v) => v == null
          ? null
          : FraudEventHandledBy.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$FraudEventToJson(FraudEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventType': _$FraudEventTypeEnumMap[instance.eventType]!,
      'severity': _$FraudSeverityEnumMap[instance.severity]!,
      'status': _$FraudStatusEnumMap[instance.status]!,
      'userId': instance.userId,
      'driverId': instance.driverId,
      'signals': instance.signals.map((e) => e.toJson()).toList(),
      'score': instance.score,
      'location': instance.location?.toJson(),
      'previousLocation': instance.previousLocation?.toJson(),
      'distanceKm': instance.distanceKm,
      'timeDeltaSeconds': instance.timeDeltaSeconds,
      'velocityKmh': instance.velocityKmh,
      'ipAddress': instance.ipAddress,
      'userAgent': instance.userAgent,
      'handledById': instance.handledById,
      'resolution': instance.resolution,
      'actionTaken': instance.actionTaken,
      'detectedAt': instance.detectedAt.toIso8601String(),
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'user': ?instance.user?.toJson(),
      'driver': ?instance.driver?.toJson(),
      'handledBy': ?instance.handledBy?.toJson(),
    };

const _$FraudEventTypeEnumMap = {
  FraudEventType.GPS_SPOOF_VELOCITY: 'GPS_SPOOF_VELOCITY',
  FraudEventType.GPS_SPOOF_TELEPORT: 'GPS_SPOOF_TELEPORT',
  FraudEventType.GPS_SPOOF_MOCK_DETECTED: 'GPS_SPOOF_MOCK_DETECTED',
  FraudEventType.DUPLICATE_BANK_ACCOUNT: 'DUPLICATE_BANK_ACCOUNT',
  FraudEventType.DUPLICATE_IP_PATTERN: 'DUPLICATE_IP_PATTERN',
  FraudEventType.DUPLICATE_NAME_SIMILARITY: 'DUPLICATE_NAME_SIMILARITY',
  FraudEventType.SUSPICIOUS_REGISTRATION: 'SUSPICIOUS_REGISTRATION',
};

const _$FraudSeverityEnumMap = {
  FraudSeverity.LOW: 'LOW',
  FraudSeverity.MEDIUM: 'MEDIUM',
  FraudSeverity.HIGH: 'HIGH',
  FraudSeverity.CRITICAL: 'CRITICAL',
};

const _$FraudStatusEnumMap = {
  FraudStatus.PENDING: 'PENDING',
  FraudStatus.REVIEWING: 'REVIEWING',
  FraudStatus.CONFIRMED: 'CONFIRMED',
  FraudStatus.DISMISSED: 'DISMISSED',
};
