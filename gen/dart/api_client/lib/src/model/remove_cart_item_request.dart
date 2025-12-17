//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'remove_cart_item_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RemoveCartItemRequest {
  /// Returns a new [RemoveCartItemRequest] instance.
  const RemoveCartItemRequest({required this.menuId});
  @JsonKey(name: r'menuId', required: true, includeIfNull: false)
  final String menuId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemoveCartItemRequest && other.menuId == menuId;

  @override
  int get hashCode => menuId.hashCode;

  factory RemoveCartItemRequest.fromJson(Map<String, dynamic> json) =>
      _$RemoveCartItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveCartItemRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
