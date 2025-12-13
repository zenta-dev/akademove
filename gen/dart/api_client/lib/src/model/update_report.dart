//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/report_status.dart';
import 'package:api_client/src/model/report_category.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_report.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateReport {
  /// Returns a new [UpdateReport] instance.
  const UpdateReport({
    this.orderId,
    this.reporterId,
    this.targetUserId,
    this.category,
    this.description,
    this.evidenceUrl,
    this.status,
    this.handledById,
    this.resolution,
  });
  @JsonKey(name: r'orderId', required: false, includeIfNull: false)
  final String? orderId;

  @JsonKey(name: r'reporterId', required: false, includeIfNull: false)
  final String? reporterId;

  @JsonKey(name: r'targetUserId', required: false, includeIfNull: false)
  final String? targetUserId;

  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final ReportCategory? category;

  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;

  @JsonKey(name: r'evidenceUrl', required: false, includeIfNull: false)
  final String? evidenceUrl;

  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final ReportStatus? status;

  @JsonKey(name: r'handledById', required: false, includeIfNull: false)
  final String? handledById;

  @JsonKey(name: r'resolution', required: false, includeIfNull: false)
  final String? resolution;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateReport &&
          other.orderId == orderId &&
          other.reporterId == reporterId &&
          other.targetUserId == targetUserId &&
          other.category == category &&
          other.description == description &&
          other.evidenceUrl == evidenceUrl &&
          other.status == status &&
          other.handledById == handledById &&
          other.resolution == resolution;

  @override
  int get hashCode =>
      orderId.hashCode +
      reporterId.hashCode +
      targetUserId.hashCode +
      category.hashCode +
      description.hashCode +
      evidenceUrl.hashCode +
      status.hashCode +
      handledById.hashCode +
      resolution.hashCode;

  factory UpdateReport.fromJson(Map<String, dynamic> json) =>
      _$UpdateReportFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateReportToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
