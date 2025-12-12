//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'banner_create_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BannerCreateRequest {
  /// Returns a new [BannerCreateRequest] instance.
  const BannerCreateRequest({
    required this.title,
    this.description,
    required this.imageUrl,
    required this.actionType,
    this.actionValue,
    required this.placement,
    required this.targetAudience,
    required this.isActive,
    this.priority = 0,
    this.startAt,
    this.endAt,
  });
  @JsonKey(name: r'title', required: true, includeIfNull: false)
  final String title;

  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;

  @JsonKey(name: r'imageUrl', required: true, includeIfNull: false)
  final String imageUrl;

  @JsonKey(name: r'actionType', required: true, includeIfNull: false)
  final BannerCreateRequestActionTypeEnum actionType;

  @JsonKey(name: r'actionValue', required: false, includeIfNull: false)
  final String? actionValue;

  @JsonKey(name: r'placement', required: true, includeIfNull: false)
  final BannerCreateRequestPlacementEnum placement;

  @JsonKey(name: r'targetAudience', required: true, includeIfNull: false)
  final BannerCreateRequestTargetAudienceEnum targetAudience;

  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(
    defaultValue: 0,
    name: r'priority',
    required: false,
    includeIfNull: false,
  )
  final int? priority;

  @JsonKey(name: r'startAt', required: false, includeIfNull: false)
  final DateTime? startAt;

  @JsonKey(name: r'endAt', required: false, includeIfNull: false)
  final DateTime? endAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BannerCreateRequest &&
          other.title == title &&
          other.description == description &&
          other.imageUrl == imageUrl &&
          other.actionType == actionType &&
          other.actionValue == actionValue &&
          other.placement == placement &&
          other.targetAudience == targetAudience &&
          other.isActive == isActive &&
          other.priority == priority &&
          other.startAt == startAt &&
          other.endAt == endAt;

  @override
  int get hashCode =>
      title.hashCode +
      (description == null ? 0 : description.hashCode) +
      imageUrl.hashCode +
      actionType.hashCode +
      (actionValue == null ? 0 : actionValue.hashCode) +
      placement.hashCode +
      targetAudience.hashCode +
      isActive.hashCode +
      priority.hashCode +
      (startAt == null ? 0 : startAt.hashCode) +
      (endAt == null ? 0 : endAt.hashCode);

  factory BannerCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$BannerCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BannerCreateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum BannerCreateRequestActionTypeEnum {
  @JsonValue(r'NONE')
  NONE(r'NONE'),
  @JsonValue(r'LINK')
  LINK(r'LINK'),
  @JsonValue(r'ROUTE')
  ROUTE(r'ROUTE');

  const BannerCreateRequestActionTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum BannerCreateRequestPlacementEnum {
  @JsonValue(r'USER_HOME')
  USER_HOME(r'USER_HOME'),
  @JsonValue(r'DRIVER_HOME')
  DRIVER_HOME(r'DRIVER_HOME'),
  @JsonValue(r'MERCHANT_HOME')
  MERCHANT_HOME(r'MERCHANT_HOME');

  const BannerCreateRequestPlacementEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum BannerCreateRequestTargetAudienceEnum {
  @JsonValue(r'ALL')
  ALL(r'ALL'),
  @JsonValue(r'USERS')
  USERS(r'USERS'),
  @JsonValue(r'DRIVERS')
  DRIVERS(r'DRIVERS'),
  @JsonValue(r'MERCHANTS')
  MERCHANTS(r'MERCHANTS');

  const BannerCreateRequestTargetAudienceEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
