//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'dismiss_report.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DismissReport {
  /// Returns a new [DismissReport] instance.
  const DismissReport({required this.reason});

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DismissReport && other.reason == reason;

  @override
  int get hashCode => reason.hashCode;

  factory DismissReport.fromJson(Map<String, dynamic> json) =>
      _$DismissReportFromJson(json);

  Map<String, dynamic> toJson() => _$DismissReportToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
