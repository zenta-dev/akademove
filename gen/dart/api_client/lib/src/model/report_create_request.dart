//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'report_create_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReportCreateRequest {
  /// Returns a new [ReportCreateRequest] instance.
  ReportCreateRequest({
    this.orderId,

    required this.reporterId,

    required this.targetUserId,

    required this.category,

    required this.description,

    this.evidenceUrl,

    required this.status,

    this.handledById,

    this.resolution,
  });

  @JsonKey(name: r'orderId', required: false, includeIfNull: false)
  final String? orderId;

  @JsonKey(name: r'reporterId', required: true, includeIfNull: false)
  final String reporterId;

  @JsonKey(name: r'targetUserId', required: true, includeIfNull: false)
  final String targetUserId;

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final ReportCreateRequestCategoryEnum category;

  @JsonKey(name: r'description', required: true, includeIfNull: false)
  final String description;

  @JsonKey(name: r'evidenceUrl', required: false, includeIfNull: false)
  final String? evidenceUrl;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final ReportCreateRequestStatusEnum status;

  @JsonKey(name: r'handledById', required: false, includeIfNull: false)
  final String? handledById;

  @JsonKey(name: r'resolution', required: false, includeIfNull: false)
  final String? resolution;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportCreateRequest &&
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

  factory ReportCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$ReportCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReportCreateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ReportCreateRequestCategoryEnum {
  @JsonValue(r'behavior')
  behavior(r'behavior'),
  @JsonValue(r'safety')
  safety(r'safety'),
  @JsonValue(r'fraud')
  fraud(r'fraud'),
  @JsonValue(r'other')
  other(r'other');

  const ReportCreateRequestCategoryEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum ReportCreateRequestStatusEnum {
  @JsonValue(r'pending')
  pending(r'pending'),
  @JsonValue(r'investigating')
  investigating(r'investigating'),
  @JsonValue(r'resolved')
  resolved(r'resolved'),
  @JsonValue(r'dismissed')
  dismissed(r'dismissed');

  const ReportCreateRequestStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
