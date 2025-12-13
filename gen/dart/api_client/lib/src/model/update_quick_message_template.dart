//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_quick_message_template.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateQuickMessageTemplate {
  /// Returns a new [UpdateQuickMessageTemplate] instance.
  const UpdateQuickMessageTemplate({
     this.role,
     this.message,
     this.orderType,
     this.locale = 'en',
     this.isActive,
     this.displayOrder,
  });
  @JsonKey(name: r'role', required: false, includeIfNull: false)
  final UpdateQuickMessageTemplateRoleEnum? role;
  
  @JsonKey(name: r'message', required: false, includeIfNull: false)
  final String? message;
  
  @JsonKey(name: r'orderType', required: false, includeIfNull: false)
  final UpdateQuickMessageTemplateOrderTypeEnum? orderType;
  
  @JsonKey(defaultValue: 'en',name: r'locale', required: false, includeIfNull: false)
  final String? locale;
  
  @JsonKey(name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'displayOrder', required: false, includeIfNull: false)
  final int? displayOrder;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateQuickMessageTemplate &&
    other.role == role &&
    other.message == message &&
    other.orderType == orderType &&
    other.locale == locale &&
    other.isActive == isActive &&
    other.displayOrder == displayOrder;

  @override
  int get hashCode =>
      role.hashCode +
      message.hashCode +
      (orderType == null ? 0 : orderType.hashCode) +
      locale.hashCode +
      isActive.hashCode +
      displayOrder.hashCode;

  factory UpdateQuickMessageTemplate.fromJson(Map<String, dynamic> json) => _$UpdateQuickMessageTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateQuickMessageTemplateToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum UpdateQuickMessageTemplateRoleEnum {
  @JsonValue(r'ADMIN')
  ADMIN(r'ADMIN'),
  @JsonValue(r'OPERATOR')
  OPERATOR(r'OPERATOR'),
  @JsonValue(r'MERCHANT')
  MERCHANT(r'MERCHANT'),
  @JsonValue(r'DRIVER')
  DRIVER(r'DRIVER'),
  @JsonValue(r'USER')
  USER(r'USER');
  
  const UpdateQuickMessageTemplateRoleEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

enum UpdateQuickMessageTemplateOrderTypeEnum {
  @JsonValue(r'RIDE')
  RIDE(r'RIDE'),
  @JsonValue(r'DELIVERY')
  DELIVERY(r'DELIVERY'),
  @JsonValue(r'FOOD')
  FOOD(r'FOOD');
  
  const UpdateQuickMessageTemplateOrderTypeEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

