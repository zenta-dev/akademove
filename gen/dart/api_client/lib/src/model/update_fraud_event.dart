//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/fraud_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_fraud_event.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateFraudEvent {
  /// Returns a new [UpdateFraudEvent] instance.
  const UpdateFraudEvent({this.status, this.resolution, this.actionTaken});
  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final FraudStatus? status;

  @JsonKey(name: r'resolution', required: false, includeIfNull: false)
  final String? resolution;

  @JsonKey(name: r'actionTaken', required: false, includeIfNull: false)
  final String? actionTaken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateFraudEvent &&
          other.status == status &&
          other.resolution == resolution &&
          other.actionTaken == actionTaken;

  @override
  int get hashCode =>
      status.hashCode +
      (resolution == null ? 0 : resolution.hashCode) +
      (actionTaken == null ? 0 : actionTaken.hashCode);

  factory UpdateFraudEvent.fromJson(Map<String, dynamic> json) =>
      _$UpdateFraudEventFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateFraudEventToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
