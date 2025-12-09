//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/fraud_status.dart';
import 'package:api_client/src/model/location.dart';
import 'package:api_client/src/model/fraud_signal.dart';
import 'package:api_client/src/model/fraud_event_type.dart';
import 'package:api_client/src/model/fraud_severity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_fraud_event.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertFraudEvent {
  /// Returns a new [InsertFraudEvent] instance.
  const InsertFraudEvent({
    required this.eventType,
    required this.severity,
    required this.status,
    required this.userId,
    required this.driverId,
    required this.signals,
    required this.score,
    required this.location,
    required this.previousLocation,
    required this.distanceKm,
    required this.timeDeltaSeconds,
    required this.velocityKmh,
    required this.ipAddress,
    required this.userAgent,
    required this.handledById,
    required this.resolution,
    required this.actionTaken,
    required this.detectedAt,
    required this.resolvedAt,
  });
  @JsonKey(name: r'eventType', required: true, includeIfNull: false)
  final FraudEventType eventType;
  
  @JsonKey(name: r'severity', required: true, includeIfNull: false)
  final FraudSeverity severity;
  
  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final FraudStatus status;
  
  @JsonKey(name: r'userId', required: true, includeIfNull: true)
  final String? userId;
  
  @JsonKey(name: r'driverId', required: true, includeIfNull: true)
  final String? driverId;
  
  @JsonKey(name: r'signals', required: true, includeIfNull: false)
  final List<FraudSignal> signals;
  
          // minimum: 0
          // maximum: 100
  @JsonKey(name: r'score', required: true, includeIfNull: false)
  final num score;
  
  @JsonKey(name: r'location', required: true, includeIfNull: true)
  final Location? location;
  
  @JsonKey(name: r'previousLocation', required: true, includeIfNull: true)
  final Location? previousLocation;
  
  @JsonKey(name: r'distanceKm', required: true, includeIfNull: true)
  final num? distanceKm;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'timeDeltaSeconds', required: true, includeIfNull: true)
  final int? timeDeltaSeconds;
  
  @JsonKey(name: r'velocityKmh', required: true, includeIfNull: true)
  final num? velocityKmh;
  
  @JsonKey(name: r'ipAddress', required: true, includeIfNull: true)
  final String? ipAddress;
  
  @JsonKey(name: r'userAgent', required: true, includeIfNull: true)
  final String? userAgent;
  
  @JsonKey(name: r'handledById', required: true, includeIfNull: true)
  final String? handledById;
  
  @JsonKey(name: r'resolution', required: true, includeIfNull: true)
  final String? resolution;
  
  @JsonKey(name: r'actionTaken', required: true, includeIfNull: true)
  final String? actionTaken;
  
  @JsonKey(name: r'detectedAt', required: true, includeIfNull: false)
  final DateTime detectedAt;
  
  @JsonKey(name: r'resolvedAt', required: true, includeIfNull: true)
  final DateTime? resolvedAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is InsertFraudEvent &&
    other.eventType == eventType &&
    other.severity == severity &&
    other.status == status &&
    other.userId == userId &&
    other.driverId == driverId &&
    other.signals == signals &&
    other.score == score &&
    other.location == location &&
    other.previousLocation == previousLocation &&
    other.distanceKm == distanceKm &&
    other.timeDeltaSeconds == timeDeltaSeconds &&
    other.velocityKmh == velocityKmh &&
    other.ipAddress == ipAddress &&
    other.userAgent == userAgent &&
    other.handledById == handledById &&
    other.resolution == resolution &&
    other.actionTaken == actionTaken &&
    other.detectedAt == detectedAt &&
    other.resolvedAt == resolvedAt;

  @override
  int get hashCode =>
      eventType.hashCode +
      severity.hashCode +
      status.hashCode +
      (userId == null ? 0 : userId.hashCode) +
      (driverId == null ? 0 : driverId.hashCode) +
      signals.hashCode +
      score.hashCode +
      (location == null ? 0 : location.hashCode) +
      (previousLocation == null ? 0 : previousLocation.hashCode) +
      (distanceKm == null ? 0 : distanceKm.hashCode) +
      (timeDeltaSeconds == null ? 0 : timeDeltaSeconds.hashCode) +
      (velocityKmh == null ? 0 : velocityKmh.hashCode) +
      (ipAddress == null ? 0 : ipAddress.hashCode) +
      (userAgent == null ? 0 : userAgent.hashCode) +
      (handledById == null ? 0 : handledById.hashCode) +
      (resolution == null ? 0 : resolution.hashCode) +
      (actionTaken == null ? 0 : actionTaken.hashCode) +
      detectedAt.hashCode +
      (resolvedAt == null ? 0 : resolvedAt.hashCode);

  factory InsertFraudEvent.fromJson(Map<String, dynamic> json) => _$InsertFraudEventFromJson(json);

  Map<String, dynamic> toJson() => _$InsertFraudEventToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

