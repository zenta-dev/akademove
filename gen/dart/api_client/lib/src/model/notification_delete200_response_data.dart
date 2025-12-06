//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'notification_delete200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class NotificationDelete200ResponseData {
  /// Returns a new [NotificationDelete200ResponseData] instance.
  const NotificationDelete200ResponseData({required this.ok});

  @JsonKey(name: r'ok', required: true, includeIfNull: false)
  final bool ok;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationDelete200ResponseData && other.ok == ok;

  @override
  int get hashCode => ok.hashCode;

  factory NotificationDelete200ResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$NotificationDelete200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$NotificationDelete200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
