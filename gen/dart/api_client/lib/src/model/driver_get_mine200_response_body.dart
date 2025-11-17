//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_get_mine200_response_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverGetMine200ResponseBody {
  /// Returns a new [DriverGetMine200ResponseBody] instance.
  const DriverGetMine200ResponseBody({
    required this.message,
    required this.data,
    this.totalPages,
  });

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final Driver data;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final int? totalPages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverGetMine200ResponseBody &&
          other.message == message &&
          other.data == data &&
          other.totalPages == totalPages;

  @override
  int get hashCode => message.hashCode + data.hashCode + totalPages.hashCode;

  factory DriverGetMine200ResponseBody.fromJson(Map<String, dynamic> json) =>
      _$DriverGetMine200ResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DriverGetMine200ResponseBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
