//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'list_quick_message_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ListQuickMessageQuery {
  /// Returns a new [ListQuickMessageQuery] instance.
  const ListQuickMessageQuery({
     this.role,
     this.orderType,
     this.locale,
     this.isActive,
  });
  @JsonKey(name: r'role', required: false, includeIfNull: false)
  final ListQuickMessageQueryRoleEnum? role;
  
  @JsonKey(name: r'orderType', required: false, includeIfNull: false)
  final ListQuickMessageQueryOrderTypeEnum? orderType;
  
  @JsonKey(name: r'locale', required: false, includeIfNull: false)
  final String? locale;
  
  @JsonKey(name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is ListQuickMessageQuery &&
    other.role == role &&
    other.orderType == orderType &&
    other.locale == locale &&
    other.isActive == isActive;

  @override
  int get hashCode =>
      role.hashCode +
      orderType.hashCode +
      (locale == null ? 0 : locale.hashCode) +
      isActive.hashCode;

  factory ListQuickMessageQuery.fromJson(Map<String, dynamic> json) => _$ListQuickMessageQueryFromJson(json);

  Map<String, dynamic> toJson() => _$ListQuickMessageQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum ListQuickMessageQueryRoleEnum {
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
  
  const ListQuickMessageQueryRoleEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

enum ListQuickMessageQueryOrderTypeEnum {
  @JsonValue(r'RIDE')
  RIDE(r'RIDE'),
  @JsonValue(r'DELIVERY')
  DELIVERY(r'DELIVERY'),
  @JsonValue(r'FOOD')
  FOOD(r'FOOD');
  
  const ListQuickMessageQueryOrderTypeEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

