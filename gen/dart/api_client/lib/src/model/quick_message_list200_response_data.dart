//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/quick_message_template.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'quick_message_list200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class QuickMessageList200ResponseData {
  /// Returns a new [QuickMessageList200ResponseData] instance.
  const QuickMessageList200ResponseData({required this.rows});
  @JsonKey(name: r'rows', required: true, includeIfNull: false)
  final List<QuickMessageTemplate> rows;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickMessageList200ResponseData && other.rows == rows;

  @override
  int get hashCode => rows.hashCode;

  factory QuickMessageList200ResponseData.fromJson(Map<String, dynamic> json) =>
      _$QuickMessageList200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$QuickMessageList200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
