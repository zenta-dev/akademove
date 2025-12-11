//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'banner_list200_response_data_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BannerList200ResponseDataInner {
  /// Returns a new [BannerList200ResponseDataInner] instance.
  const BannerList200ResponseDataInner({
    required this.id,
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
    required this.createdById,
     this.updatedById,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @JsonKey(name: r'title', required: true, includeIfNull: false)
  final String title;
  
  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;
  
  @JsonKey(name: r'imageUrl', required: true, includeIfNull: false)
  final String imageUrl;
  
  @JsonKey(name: r'actionType', required: true, includeIfNull: false)
  final BannerList200ResponseDataInnerActionTypeEnum actionType;
  
  @JsonKey(name: r'actionValue', required: false, includeIfNull: false)
  final String? actionValue;
  
  @JsonKey(name: r'placement', required: true, includeIfNull: false)
  final BannerList200ResponseDataInnerPlacementEnum placement;
  
  @JsonKey(name: r'targetAudience', required: true, includeIfNull: false)
  final BannerList200ResponseDataInnerTargetAudienceEnum targetAudience;
  
  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;
  
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(defaultValue: 0,name: r'priority', required: false, includeIfNull: false)
  final int? priority;
  
  @JsonKey(name: r'startAt', required: false, includeIfNull: false)
  final DateTime? startAt;
  
  @JsonKey(name: r'endAt', required: false, includeIfNull: false)
  final DateTime? endAt;
  
  @JsonKey(name: r'createdById', required: true, includeIfNull: false)
  final String createdById;
  
  @JsonKey(name: r'updatedById', required: false, includeIfNull: false)
  final String? updatedById;
  
  @JsonKey(name: r'createdAt', required: true, includeIfNull: true)
  final DateTime? createdAt;
  
  @JsonKey(name: r'updatedAt', required: true, includeIfNull: true)
  final DateTime? updatedAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is BannerList200ResponseDataInner &&
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
    other.endAt == endAt &&
    other.createdById == createdById &&
    other.updatedById == updatedById &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
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
      (endAt == null ? 0 : endAt.hashCode) +
      createdById.hashCode +
      (updatedById == null ? 0 : updatedById.hashCode) +
      (createdAt == null ? 0 : createdAt.hashCode) +
      (updatedAt == null ? 0 : updatedAt.hashCode);

  factory BannerList200ResponseDataInner.fromJson(Map<String, dynamic> json) => _$BannerList200ResponseDataInnerFromJson(json);

  Map<String, dynamic> toJson() => _$BannerList200ResponseDataInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum BannerList200ResponseDataInnerActionTypeEnum {
  @JsonValue(r'NONE')
  NONE(r'NONE'),
  @JsonValue(r'LINK')
  LINK(r'LINK'),
  @JsonValue(r'ROUTE')
  ROUTE(r'ROUTE');
  
  const BannerList200ResponseDataInnerActionTypeEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

enum BannerList200ResponseDataInnerPlacementEnum {
  @JsonValue(r'USER_HOME')
  USER_HOME(r'USER_HOME'),
  @JsonValue(r'DRIVER_HOME')
  DRIVER_HOME(r'DRIVER_HOME'),
  @JsonValue(r'MERCHANT_HOME')
  MERCHANT_HOME(r'MERCHANT_HOME');
  
  const BannerList200ResponseDataInnerPlacementEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

enum BannerList200ResponseDataInnerTargetAudienceEnum {
  @JsonValue(r'ALL')
  ALL(r'ALL'),
  @JsonValue(r'USERS')
  USERS(r'USERS'),
  @JsonValue(r'DRIVERS')
  DRIVERS(r'DRIVERS'),
  @JsonValue(r'MERCHANTS')
  MERCHANTS(r'MERCHANTS');
  
  const BannerList200ResponseDataInnerTargetAudienceEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

