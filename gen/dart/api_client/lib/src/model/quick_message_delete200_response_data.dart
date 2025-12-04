//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'quick_message_delete200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class QuickMessageDelete200ResponseData {
  /// Returns a new [QuickMessageDelete200ResponseData] instance.
  const QuickMessageDelete200ResponseData({required this.success});

  @JsonKey(name: r'success', required: true, includeIfNull: false)
  final bool success;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickMessageDelete200ResponseData && other.success == success;

  @override
  int get hashCode => success.hashCode;

  factory QuickMessageDelete200ResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$QuickMessageDelete200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$QuickMessageDelete200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
