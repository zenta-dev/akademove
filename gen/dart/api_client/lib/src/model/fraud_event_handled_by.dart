//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'fraud_event_handled_by.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FraudEventHandledBy {
  /// Returns a new [FraudEventHandledBy] instance.
  const FraudEventHandledBy({required this.id, required this.name});
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FraudEventHandledBy && other.id == id && other.name == name;

  @override
  int get hashCode => id.hashCode + name.hashCode;

  factory FraudEventHandledBy.fromJson(Map<String, dynamic> json) =>
      _$FraudEventHandledByFromJson(json);

  Map<String, dynamic> toJson() => _$FraudEventHandledByToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
