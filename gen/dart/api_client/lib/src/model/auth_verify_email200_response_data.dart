//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_verify_email200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthVerifyEmail200ResponseData {
  /// Returns a new [AuthVerifyEmail200ResponseData] instance.
  const AuthVerifyEmail200ResponseData({
    required this.ok,
     this.token,
     this.user,
  });
  @JsonKey(name: r'ok', required: true, includeIfNull: false)
  final bool ok;
  
  @JsonKey(name: r'token', required: false, includeIfNull: false)
  final String? token;
  
  @JsonKey(name: r'user', required: false, includeIfNull: false)
  final User? user;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is AuthVerifyEmail200ResponseData &&
    other.ok == ok &&
    other.token == token &&
    other.user == user;

  @override
  int get hashCode =>
      ok.hashCode +
      token.hashCode +
      user.hashCode;

  factory AuthVerifyEmail200ResponseData.fromJson(Map<String, dynamic> json) => _$AuthVerifyEmail200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthVerifyEmail200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

