//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'start_investigation.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StartInvestigation {
  /// Returns a new [StartInvestigation] instance.
  const StartInvestigation({required this.notes});

  @JsonKey(name: r'notes', required: true, includeIfNull: false)
  final String notes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StartInvestigation && other.notes == notes;

  @override
  int get hashCode => notes.hashCode;

  factory StartInvestigation.fromJson(Map<String, dynamic> json) =>
      _$StartInvestigationFromJson(json);

  Map<String, dynamic> toJson() => _$StartInvestigationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
