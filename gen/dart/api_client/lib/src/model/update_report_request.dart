//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_report_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateReportRequest {
  /// Returns a new [UpdateReportRequest] instance.
  UpdateReportRequest({
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
  final UpdateReportRequestCategoryEnum? category;

  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;

  @JsonKey(name: r'evidenceUrl', required: false, includeIfNull: false)
  final String? evidenceUrl;

  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final UpdateReportRequestStatusEnum? status;

  @JsonKey(name: r'handledById', required: false, includeIfNull: false)
  final String? handledById;

  @JsonKey(name: r'resolution', required: false, includeIfNull: false)
  final String? resolution;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateReportRequest &&
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

  factory UpdateReportRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateReportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateReportRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum UpdateReportRequestCategoryEnum {
  @JsonValue(r'behavior')
  behavior(r'behavior'),
  @JsonValue(r'safety')
  safety(r'safety'),
  @JsonValue(r'fraud')
  fraud(r'fraud'),
  @JsonValue(r'other')
  other(r'other');

  const UpdateReportRequestCategoryEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum UpdateReportRequestStatusEnum {
  @JsonValue(r'pending')
  pending(r'pending'),
  @JsonValue(r'investigating')
  investigating(r'investigating'),
  @JsonValue(r'resolved')
  resolved(r'resolved'),
  @JsonValue(r'dismissed')
  dismissed(r'dismissed');

  const UpdateReportRequestStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
