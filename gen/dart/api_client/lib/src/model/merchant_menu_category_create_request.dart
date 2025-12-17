//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_menu_category_create_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantMenuCategoryCreateRequest {
  /// Returns a new [MerchantMenuCategoryCreateRequest] instance.
  const MerchantMenuCategoryCreateRequest({
    required this.name,
    this.description,
    this.sortOrder = 0,
  });
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantMenuCategoryCreateRequest &&
          other.name == name &&
          other.description == description &&
          other.sortOrder == sortOrder;

  @override
  int get hashCode => name.hashCode + description.hashCode + sortOrder.hashCode;

  factory MerchantMenuCategoryCreateRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$MerchantMenuCategoryCreateRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MerchantMenuCategoryCreateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
