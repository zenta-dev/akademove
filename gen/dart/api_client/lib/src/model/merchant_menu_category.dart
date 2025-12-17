//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_menu_category.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantMenuCategory {
  /// Returns a new [MerchantMenuCategory] instance.
  const MerchantMenuCategory({
    required this.id,
    required this.merchantId,
    required this.name,
    this.description,
    this.sortOrder = 0,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'merchantId', required: true, includeIfNull: false)
  final String merchantId;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(
    defaultValue: 0,
    name: r'sortOrder',
    required: false,
    includeIfNull: false,
  )
  final int? sortOrder;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantMenuCategory &&
          other.id == id &&
          other.merchantId == merchantId &&
          other.name == name &&
          other.description == description &&
          other.sortOrder == sortOrder &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      merchantId.hashCode +
      name.hashCode +
      description.hashCode +
      sortOrder.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory MerchantMenuCategory.fromJson(Map<String, dynamic> json) =>
      _$MerchantMenuCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantMenuCategoryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
