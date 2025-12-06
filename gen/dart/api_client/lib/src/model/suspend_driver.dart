//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'suspend_driver.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SuspendDriver {
  /// Returns a new [SuspendDriver] instance.
  const SuspendDriver({
    required this.id,
    required this.reason,
    this.suspendUntil,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'suspendUntil', required: false, includeIfNull: false)
  final DateTime? suspendUntil;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuspendDriver &&
          other.id == id &&
          other.reason == reason &&
          other.suspendUntil == suspendUntil;

  @override
  int get hashCode => id.hashCode + reason.hashCode + suspendUntil.hashCode;

  factory SuspendDriver.fromJson(Map<String, dynamic> json) =>
      _$SuspendDriverFromJson(json);

  Map<String, dynamic> toJson() => _$SuspendDriverToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
