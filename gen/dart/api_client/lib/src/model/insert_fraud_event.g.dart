// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_fraud_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertFraudEventCWProxy {
  InsertFraudEvent eventType(FraudEventType eventType);

  InsertFraudEvent severity(FraudSeverity severity);

  InsertFraudEvent status(FraudStatus status);

  InsertFraudEvent userId(String? userId);

  InsertFraudEvent driverId(String? driverId);

  InsertFraudEvent signals(List<FraudSignal> signals);

  InsertFraudEvent score(num score);

  InsertFraudEvent location(Location? location);

  InsertFraudEvent previousLocation(Location? previousLocation);

  InsertFraudEvent distanceKm(num? distanceKm);

  InsertFraudEvent timeDeltaSeconds(int? timeDeltaSeconds);

  InsertFraudEvent velocityKmh(num? velocityKmh);

  InsertFraudEvent ipAddress(String? ipAddress);

  InsertFraudEvent userAgent(String? userAgent);

  InsertFraudEvent handledById(String? handledById);

  InsertFraudEvent resolution(String? resolution);

  InsertFraudEvent actionTaken(String? actionTaken);

  InsertFraudEvent detectedAt(DateTime detectedAt);

  InsertFraudEvent resolvedAt(DateTime? resolvedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertFraudEvent(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertFraudEvent(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertFraudEvent call({
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
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertFraudEvent.copyWith(...)` or call `instanceOfInsertFraudEvent.copyWith.fieldName(value)` for a single field.
class _$InsertFraudEventCWProxyImpl implements _$InsertFraudEventCWProxy {
  const _$InsertFraudEventCWProxyImpl(this._value);

  final InsertFraudEvent _value;

  @override
  InsertFraudEvent eventType(FraudEventType eventType) =>
      call(eventType: eventType);

  @override
  InsertFraudEvent severity(FraudSeverity severity) => call(severity: severity);

  @override
  InsertFraudEvent status(FraudStatus status) => call(status: status);

  @override
  InsertFraudEvent userId(String? userId) => call(userId: userId);

  @override
  InsertFraudEvent driverId(String? driverId) => call(driverId: driverId);

  @override
  InsertFraudEvent signals(List<FraudSignal> signals) => call(signals: signals);

  @override
  InsertFraudEvent score(num score) => call(score: score);

  @override
  InsertFraudEvent location(Location? location) => call(location: location);

  @override
  InsertFraudEvent previousLocation(Location? previousLocation) =>
      call(previousLocation: previousLocation);

  @override
  InsertFraudEvent distanceKm(num? distanceKm) => call(distanceKm: distanceKm);

  @override
  InsertFraudEvent timeDeltaSeconds(int? timeDeltaSeconds) =>
      call(timeDeltaSeconds: timeDeltaSeconds);

  @override
  InsertFraudEvent velocityKmh(num? velocityKmh) =>
      call(velocityKmh: velocityKmh);

  @override
  InsertFraudEvent ipAddress(String? ipAddress) => call(ipAddress: ipAddress);

  @override
  InsertFraudEvent userAgent(String? userAgent) => call(userAgent: userAgent);

  @override
  InsertFraudEvent handledById(String? handledById) =>
      call(handledById: handledById);

  @override
  InsertFraudEvent resolution(String? resolution) =>
      call(resolution: resolution);

  @override
  InsertFraudEvent actionTaken(String? actionTaken) =>
      call(actionTaken: actionTaken);

  @override
  InsertFraudEvent detectedAt(DateTime detectedAt) =>
      call(detectedAt: detectedAt);

  @override
  InsertFraudEvent resolvedAt(DateTime? resolvedAt) =>
      call(resolvedAt: resolvedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertFraudEvent(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertFraudEvent(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertFraudEvent call({
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
  }) {
    return InsertFraudEvent(
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
    );
  }
}

extension $InsertFraudEventCopyWith on InsertFraudEvent {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertFraudEvent.copyWith(...)` or `instanceOfInsertFraudEvent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertFraudEventCWProxy get copyWith => _$InsertFraudEventCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertFraudEvent _$InsertFraudEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertFraudEvent', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
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
        ],
      );
      final val = InsertFraudEvent(
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
          (v) =>
              v == null ? null : Location.fromJson(v as Map<String, dynamic>),
        ),
        previousLocation: $checkedConvert(
          'previousLocation',
          (v) =>
              v == null ? null : Location.fromJson(v as Map<String, dynamic>),
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
      );
      return val;
    });

Map<String, dynamic> _$InsertFraudEventToJson(InsertFraudEvent instance) =>
    <String, dynamic>{
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
