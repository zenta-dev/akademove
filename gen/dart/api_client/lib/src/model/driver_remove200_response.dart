//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_remove200_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverRemove200Response {
  /// Returns a new [DriverRemove200Response] instance.
  const DriverRemove200Response({
    required this.message,
    required this.data,
    this.totalPages,
  });

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final Object? data;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final int? totalPages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverRemove200Response &&
          other.message == message &&
          other.data == data &&
          other.totalPages == totalPages;

  @override
  int get hashCode =>
      message.hashCode +
      (data == null ? 0 : data.hashCode) +
      totalPages.hashCode;

  factory DriverRemove200Response.fromJson(Map<String, dynamic> json) =>
      _$DriverRemove200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DriverRemove200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
