//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/report_status.dart';
import 'package:api_client/src/model/report_category.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'report.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class Report {
  /// Returns a new [Report] instance.
  const Report({
    required this.id,
    this.orderId,
    required this.reporterId,
    required this.targetUserId,
    required this.category,
    required this.description,
    this.evidenceUrl,
    required this.status,
    this.handledById,
    this.resolution,
    required this.reportedAt,
    this.resolvedAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'orderId', required: false, includeIfNull: false)
  final String? orderId;

  @JsonKey(name: r'reporterId', required: true, includeIfNull: false)
  final String reporterId;

  @JsonKey(name: r'targetUserId', required: true, includeIfNull: false)
  final String targetUserId;

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final ReportCategory category;

  @JsonKey(name: r'description', required: true, includeIfNull: false)
  final String description;

  @JsonKey(name: r'evidenceUrl', required: false, includeIfNull: false)
  final String? evidenceUrl;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final ReportStatus status;

  @JsonKey(name: r'handledById', required: false, includeIfNull: false)
  final String? handledById;

  @JsonKey(name: r'resolution', required: false, includeIfNull: false)
  final String? resolution;

  @JsonKey(name: r'reportedAt', required: true, includeIfNull: false)
  final DateTime reportedAt;

  @JsonKey(name: r'resolvedAt', required: false, includeIfNull: false)
  final DateTime? resolvedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Report &&
          other.id == id &&
          other.orderId == orderId &&
          other.reporterId == reporterId &&
          other.targetUserId == targetUserId &&
          other.category == category &&
          other.description == description &&
          other.evidenceUrl == evidenceUrl &&
          other.status == status &&
          other.handledById == handledById &&
          other.resolution == resolution &&
          other.reportedAt == reportedAt &&
          other.resolvedAt == resolvedAt;

  @override
  int get hashCode =>
      id.hashCode +
      orderId.hashCode +
      reporterId.hashCode +
      targetUserId.hashCode +
      category.hashCode +
      description.hashCode +
      evidenceUrl.hashCode +
      status.hashCode +
      handledById.hashCode +
      resolution.hashCode +
      reportedAt.hashCode +
      resolvedAt.hashCode;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
