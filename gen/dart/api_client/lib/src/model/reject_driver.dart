//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'reject_driver.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RejectDriver {
  /// Returns a new [RejectDriver] instance.
  const RejectDriver({required this.id, required this.reason});
  @JsonKey(name: r'id', required: true, includeIfNull: true)
  final String? id;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RejectDriver && other.id == id && other.reason == reason;

  @override
  int get hashCode => (id == null ? 0 : id.hashCode) + reason.hashCode;

  factory RejectDriver.fromJson(Map<String, dynamic> json) =>
      _$RejectDriverFromJson(json);

  Map<String, dynamic> toJson() => _$RejectDriverToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
