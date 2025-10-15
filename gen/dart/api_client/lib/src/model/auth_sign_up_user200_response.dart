//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/auth_sign_up_user200_response_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_sign_up_user200_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthSignUpUser200Response {
  /// Returns a new [AuthSignUpUser200Response] instance.
  AuthSignUpUser200Response({
    required this.message,

    required this.data,

    this.totalPages,
  });

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final AuthSignUpUser200ResponseData data;

  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final num? totalPages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthSignUpUser200Response &&
          other.message == message &&
          other.data == data &&
          other.totalPages == totalPages;

  @override
  int get hashCode => message.hashCode + data.hashCode + totalPages.hashCode;

  factory AuthSignUpUser200Response.fromJson(Map<String, dynamic> json) =>
      _$AuthSignUpUser200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSignUpUser200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
