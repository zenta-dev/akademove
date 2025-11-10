//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_sign_out200_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthSignOut200Response {
  /// Returns a new [AuthSignOut200Response] instance.
  const AuthSignOut200Response({
    required this.message,
    required this.data,
    this.totalPages,
  });

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final Object? data;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final int? totalPages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthSignOut200Response &&
          other.message == message &&
          other.data == data &&
          other.totalPages == totalPages;

  @override
  int get hashCode =>
      message.hashCode +
      (data == null ? 0 : data.hashCode) +
      totalPages.hashCode;

  factory AuthSignOut200Response.fromJson(Map<String, dynamic> json) =>
      _$AuthSignOut200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSignOut200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
