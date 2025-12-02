//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'notification_save_token200_response_data.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class NotificationSaveToken200ResponseData {
  /// Returns a new [NotificationSaveToken200ResponseData] instance.
  const NotificationSaveToken200ResponseData({required this.ok});

  @JsonKey(name: r'ok', required: true, includeIfNull: false)
  final bool ok;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NotificationSaveToken200ResponseData && other.ok == ok;

  @override
  int get hashCode => ok.hashCode;

  factory NotificationSaveToken200ResponseData.fromJson(Map<String, dynamic> json) =>
      _$NotificationSaveToken200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSaveToken200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
