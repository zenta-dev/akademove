//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'badge_evaluation_job_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BadgeEvaluationJobPayload {
  /// Returns a new [BadgeEvaluationJobPayload] instance.
  const BadgeEvaluationJobPayload({
    required this.driverId,
    required this.userId,
    required this.orderId,
    required this.orderType,
  });
  @JsonKey(name: r'driverId', required: true, includeIfNull: false)
  final String driverId;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'orderType', required: true, includeIfNull: false)
  final BadgeEvaluationJobPayloadOrderTypeEnum orderType;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeEvaluationJobPayload &&
          other.driverId == driverId &&
          other.userId == userId &&
          other.orderId == orderId &&
          other.orderType == orderType;

  @override
  int get hashCode =>
      driverId.hashCode +
      userId.hashCode +
      orderId.hashCode +
      orderType.hashCode;

  factory BadgeEvaluationJobPayload.fromJson(Map<String, dynamic> json) =>
      _$BadgeEvaluationJobPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeEvaluationJobPayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum BadgeEvaluationJobPayloadOrderTypeEnum {
  @JsonValue(r'RIDE')
  RIDE(r'RIDE'),
  @JsonValue(r'DELIVERY')
  DELIVERY(r'DELIVERY'),
  @JsonValue(r'FOOD')
  FOOD(r'FOOD');

  const BadgeEvaluationJobPayloadOrderTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
