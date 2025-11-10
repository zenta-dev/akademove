//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_get200_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderGet200Response {
  /// Returns a new [OrderGet200Response] instance.
  const OrderGet200Response({
    required this.message,
    required this.data,
    this.totalPages,
  });

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final Order data;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final int? totalPages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderGet200Response &&
          other.message == message &&
          other.data == data &&
          other.totalPages == totalPages;

  @override
  int get hashCode => message.hashCode + data.hashCode + totalPages.hashCode;

  factory OrderGet200Response.fromJson(Map<String, dynamic> json) =>
      _$OrderGet200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderGet200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
