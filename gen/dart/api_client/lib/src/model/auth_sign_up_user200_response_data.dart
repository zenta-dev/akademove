//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_sign_up_user200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthSignUpUser200ResponseData {
  /// Returns a new [AuthSignUpUser200ResponseData] instance.
  AuthSignUpUser200ResponseData({required this.user});

  @JsonKey(name: r'user', required: true, includeIfNull: false)
  final User user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthSignUpUser200ResponseData && other.user == user;

  @override
  int get hashCode => user.hashCode;

  factory AuthSignUpUser200ResponseData.fromJson(Map<String, dynamic> json) =>
      _$AuthSignUpUser200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSignUpUser200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
