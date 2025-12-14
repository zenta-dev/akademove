//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_sign_out_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthSignOutRequest {
  /// Returns a new [AuthSignOutRequest] instance.
  const AuthSignOutRequest({this.fcmToken});

  /// FCM token to remove for this session/device
  @JsonKey(name: r'fcmToken', required: false, includeIfNull: false)
  final String? fcmToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthSignOutRequest && other.fcmToken == fcmToken;

  @override
  int get hashCode => fcmToken.hashCode;

  factory AuthSignOutRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthSignOutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSignOutRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
