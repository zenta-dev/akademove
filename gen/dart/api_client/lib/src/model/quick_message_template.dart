//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'quick_message_template.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class QuickMessageTemplate {
  /// Returns a new [QuickMessageTemplate] instance.
  const QuickMessageTemplate({
    required this.id,
    required this.role,
    required this.message,
    required this.orderType,
     this.locale = 'en',
    required this.isActive,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final QuickMessageTemplateRoleEnum role;
  
  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;
  
  @JsonKey(name: r'orderType', required: true, includeIfNull: true)
  final QuickMessageTemplateOrderTypeEnum? orderType;
  
  @JsonKey(defaultValue: 'en',name: r'locale', required: false, includeIfNull: false)
  final String? locale;
  
  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'displayOrder', required: true, includeIfNull: false)
  final int displayOrder;
  
  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;
  
  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is QuickMessageTemplate &&
    other.id == id &&
    other.role == role &&
    other.message == message &&
    other.orderType == orderType &&
    other.locale == locale &&
    other.isActive == isActive &&
    other.displayOrder == displayOrder &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      role.hashCode +
      message.hashCode +
      (orderType == null ? 0 : orderType.hashCode) +
      locale.hashCode +
      isActive.hashCode +
      displayOrder.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory QuickMessageTemplate.fromJson(Map<String, dynamic> json) => _$QuickMessageTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$QuickMessageTemplateToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum QuickMessageTemplateRoleEnum {
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
  
  const QuickMessageTemplateRoleEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

enum QuickMessageTemplateOrderTypeEnum {
  @JsonValue(r'RIDE')
  RIDE(r'RIDE'),
  @JsonValue(r'DELIVERY')
  DELIVERY(r'DELIVERY'),
  @JsonValue(r'FOOD')
  FOOD(r'FOOD');
  
  const QuickMessageTemplateOrderTypeEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

