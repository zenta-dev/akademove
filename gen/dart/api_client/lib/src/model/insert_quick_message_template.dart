//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_quick_message_template.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertQuickMessageTemplate {
  /// Returns a new [InsertQuickMessageTemplate] instance.
  const InsertQuickMessageTemplate({
    required this.role,
    required this.message,
    required this.orderType,
    this.locale = 'en',
    required this.isActive,
    required this.displayOrder,
  });

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final InsertQuickMessageTemplateRoleEnum role;

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'orderType', required: true, includeIfNull: true)
  final InsertQuickMessageTemplateOrderTypeEnum? orderType;

  @JsonKey(
    defaultValue: 'en',
    name: r'locale',
    required: false,
    includeIfNull: false,
  )
  final String? locale;

  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'displayOrder', required: true, includeIfNull: false)
  final int displayOrder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsertQuickMessageTemplate &&
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

  factory InsertQuickMessageTemplate.fromJson(Map<String, dynamic> json) =>
      _$InsertQuickMessageTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$InsertQuickMessageTemplateToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum InsertQuickMessageTemplateRoleEnum {
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

  const InsertQuickMessageTemplateRoleEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum InsertQuickMessageTemplateOrderTypeEnum {
  @JsonValue(r'RIDE')
  RIDE(r'RIDE'),
  @JsonValue(r'DELIVERY')
  DELIVERY(r'DELIVERY'),
  @JsonValue(r'FOOD')
  FOOD(r'FOOD');

  const InsertQuickMessageTemplateOrderTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
