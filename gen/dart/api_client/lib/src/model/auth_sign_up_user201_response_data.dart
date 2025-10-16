//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_sign_up_user201_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthSignUpUser201ResponseData {
  /// Returns a new [AuthSignUpUser201ResponseData] instance.
  AuthSignUpUser201ResponseData({required this.user});

  @JsonKey(name: r'user', required: true, includeIfNull: false)
  final User user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthSignUpUser201ResponseData && other.user == user;

  @override
  int get hashCode => user.hashCode;

  factory AuthSignUpUser201ResponseData.fromJson(Map<String, dynamic> json) =>
      _$AuthSignUpUser201ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSignUpUser201ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
