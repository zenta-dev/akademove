//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'approve_driver.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ApproveDriver {
  /// Returns a new [ApproveDriver] instance.
  const ApproveDriver({required this.id});

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ApproveDriver && other.id == id;

  @override
  int get hashCode => id.hashCode;

  factory ApproveDriver.fromJson(Map<String, dynamic> json) =>
      _$ApproveDriverFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveDriverToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
