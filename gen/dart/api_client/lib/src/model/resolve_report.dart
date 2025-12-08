//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'resolve_report.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ResolveReport {
  /// Returns a new [ResolveReport] instance.
  const ResolveReport({required this.resolution});
  @JsonKey(name: r'resolution', required: true, includeIfNull: false)
  final String resolution;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResolveReport && other.resolution == resolution;

  @override
  int get hashCode => resolution.hashCode;

  factory ResolveReport.fromJson(Map<String, dynamic> json) =>
      _$ResolveReportFromJson(json);

  Map<String, dynamic> toJson() => _$ResolveReportToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
