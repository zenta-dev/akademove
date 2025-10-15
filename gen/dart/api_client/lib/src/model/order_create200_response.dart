//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_create200_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderCreate200Response {
  /// Returns a new [OrderCreate200Response] instance.
  OrderCreate200Response({
    required this.message,

    required this.data,

    this.totalPages,
  });

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final Order data;

  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final num? totalPages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderCreate200Response &&
          other.message == message &&
          other.data == data &&
          other.totalPages == totalPages;

  @override
  int get hashCode => message.hashCode + data.hashCode + totalPages.hashCode;

  factory OrderCreate200Response.fromJson(Map<String, dynamic> json) =>
      _$OrderCreate200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreate200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
