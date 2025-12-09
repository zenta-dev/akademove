//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'review_fraud_event.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReviewFraudEvent {
  /// Returns a new [ReviewFraudEvent] instance.
  const ReviewFraudEvent({
    required this.status,
    this.resolution,
    this.actionTaken,
  });
  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final ReviewFraudEventStatusEnum status;

  @JsonKey(name: r'resolution', required: false, includeIfNull: false)
  final String? resolution;

  @JsonKey(name: r'actionTaken', required: false, includeIfNull: false)
  final String? actionTaken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewFraudEvent &&
          other.status == status &&
          other.resolution == resolution &&
          other.actionTaken == actionTaken;

  @override
  int get hashCode =>
      status.hashCode + resolution.hashCode + actionTaken.hashCode;

  factory ReviewFraudEvent.fromJson(Map<String, dynamic> json) =>
      _$ReviewFraudEventFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewFraudEventToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ReviewFraudEventStatusEnum {
  @JsonValue(r'REVIEWING')
  REVIEWING(r'REVIEWING'),
  @JsonValue(r'CONFIRMED')
  CONFIRMED(r'CONFIRMED'),
  @JsonValue(r'DISMISSED')
  DISMISSED(r'DISMISSED');

  const ReviewFraudEventStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
