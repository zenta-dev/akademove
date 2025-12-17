//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_cart_item_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateCartItemRequest {
  /// Returns a new [UpdateCartItemRequest] instance.
  const UpdateCartItemRequest({required this.menuId, required this.delta});
  @JsonKey(name: r'menuId', required: true, includeIfNull: false)
  final String menuId;

  // minimum: -99
  // maximum: 99
  @JsonKey(name: r'delta', required: true, includeIfNull: false)
  final int delta;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateCartItemRequest &&
          other.menuId == menuId &&
          other.delta == delta;

  @override
  int get hashCode => menuId.hashCode + delta.hashCode;

  factory UpdateCartItemRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCartItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCartItemRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
