//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'notification_save_token_request.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class NotificationSaveTokenRequest {
  /// Returns a new [NotificationSaveTokenRequest] instance.
  const NotificationSaveTokenRequest({required this.token});

  @JsonKey(name: r'token', required: true, includeIfNull: false)
  final String token;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NotificationSaveTokenRequest && other.token == token;

  @override
  int get hashCode => token.hashCode;

  factory NotificationSaveTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationSaveTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSaveTokenRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
