//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'banner_list_public200_response_data_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BannerListPublic200ResponseDataInner {
  /// Returns a new [BannerListPublic200ResponseDataInner] instance.
  const BannerListPublic200ResponseDataInner({
    required this.id,
    required this.title,
    this.description,
    required this.imageUrl,
    required this.actionType,
    this.actionValue,
    required this.placement,
    required this.targetAudience,
    required this.isActive,
    required this.priority,
    this.startAt,
    this.endAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: true)
  final String? id;

  @JsonKey(name: r'title', required: true, includeIfNull: true)
  final String? title;

  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;

  @JsonKey(name: r'imageUrl', required: true, includeIfNull: true)
  final String? imageUrl;

  @JsonKey(name: r'actionType', required: true, includeIfNull: false)
  final BannerListPublic200ResponseDataInnerActionTypeEnum actionType;

  @JsonKey(name: r'actionValue', required: false, includeIfNull: false)
  final String? actionValue;

  @JsonKey(name: r'placement', required: true, includeIfNull: false)
  final BannerListPublic200ResponseDataInnerPlacementEnum placement;

  @JsonKey(name: r'targetAudience', required: true, includeIfNull: false)
  final BannerListPublic200ResponseDataInnerTargetAudienceEnum targetAudience;

  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'priority', required: true, includeIfNull: false)
  final int priority;

  @JsonKey(name: r'startAt', required: false, includeIfNull: false)
  final DateTime? startAt;

  @JsonKey(name: r'endAt', required: false, includeIfNull: false)
  final DateTime? endAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BannerListPublic200ResponseDataInner &&
          other.id == id &&
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
      (id == null ? 0 : id.hashCode) +
      (title == null ? 0 : title.hashCode) +
      (description == null ? 0 : description.hashCode) +
      (imageUrl == null ? 0 : imageUrl.hashCode) +
      actionType.hashCode +
      (actionValue == null ? 0 : actionValue.hashCode) +
      placement.hashCode +
      targetAudience.hashCode +
      isActive.hashCode +
      priority.hashCode +
      (startAt == null ? 0 : startAt.hashCode) +
      (endAt == null ? 0 : endAt.hashCode);

  factory BannerListPublic200ResponseDataInner.fromJson(
    Map<String, dynamic> json,
  ) => _$BannerListPublic200ResponseDataInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$BannerListPublic200ResponseDataInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum BannerListPublic200ResponseDataInnerActionTypeEnum {
  @JsonValue(r'NONE')
  NONE(r'NONE'),
  @JsonValue(r'LINK')
  LINK(r'LINK'),
  @JsonValue(r'ROUTE')
  ROUTE(r'ROUTE');

  const BannerListPublic200ResponseDataInnerActionTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum BannerListPublic200ResponseDataInnerPlacementEnum {
  @JsonValue(r'USER_HOME')
  USER_HOME(r'USER_HOME'),
  @JsonValue(r'DRIVER_HOME')
  DRIVER_HOME(r'DRIVER_HOME'),
  @JsonValue(r'MERCHANT_HOME')
  MERCHANT_HOME(r'MERCHANT_HOME');

  const BannerListPublic200ResponseDataInnerPlacementEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum BannerListPublic200ResponseDataInnerTargetAudienceEnum {
  @JsonValue(r'ALL')
  ALL(r'ALL'),
  @JsonValue(r'USERS')
  USERS(r'USERS'),
  @JsonValue(r'DRIVERS')
  DRIVERS(r'DRIVERS'),
  @JsonValue(r'MERCHANTS')
  MERCHANTS(r'MERCHANTS');

  const BannerListPublic200ResponseDataInnerTargetAudienceEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
