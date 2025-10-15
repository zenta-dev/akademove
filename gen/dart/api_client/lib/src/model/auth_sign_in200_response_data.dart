//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_sign_in200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthSignIn200ResponseData {
  /// Returns a new [AuthSignIn200ResponseData] instance.
  AuthSignIn200ResponseData({required this.token, required this.user});

  @JsonKey(name: r'token', required: true, includeIfNull: false)
  final String token;

  @JsonKey(name: r'user', required: true, includeIfNull: false)
  final User user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthSignIn200ResponseData &&
          other.token == token &&
          other.user == user;

  @override
  int get hashCode => token.hashCode + user.hashCode;

  factory AuthSignIn200ResponseData.fromJson(Map<String, dynamic> json) =>
      _$AuthSignIn200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSignIn200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
