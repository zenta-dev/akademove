//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/auth_sign_up_user201_response_data.dart';
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
  AuthSignUpUser201Response({
    required this.message,

    required this.data,

    this.totalPages,
  });

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final AuthSignUpUser201ResponseData data;

  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final num? totalPages;

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
