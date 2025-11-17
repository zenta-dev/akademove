//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/sign_up_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_sign_up_user201_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthSignUpUser201Response {
  /// Returns a new [AuthSignUpUser201Response] instance.
  const AuthSignUpUser201Response({
    required this.message,
    required this.data,
    this.totalPages,
  });

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final SignUpResponse data;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final int? totalPages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthSignUpUser201Response &&
          other.message == message &&
          other.data == data &&
          other.totalPages == totalPages;

  @override
  int get hashCode => message.hashCode + data.hashCode + totalPages.hashCode;

  factory AuthSignUpUser201Response.fromJson(Map<String, dynamic> json) =>
      _$AuthSignUpUser201ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSignUpUser201ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
