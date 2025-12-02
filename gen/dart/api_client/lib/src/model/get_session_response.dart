//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'get_session_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GetSessionResponse {
  /// Returns a new [GetSessionResponse] instance.
  const GetSessionResponse({
     this.token,
    required this.user,
  });

  @JsonKey(name: r'token', required: false, includeIfNull: false)
  final String? token;
  
  @JsonKey(name: r'user', required: true, includeIfNull: false)
  final User user;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is GetSessionResponse &&
    other.token == token &&
    other.user == user;

  @override
  int get hashCode =>
      token.hashCode +
      user.hashCode;

  factory GetSessionResponse.fromJson(Map<String, dynamic> json) => _$GetSessionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetSessionResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

