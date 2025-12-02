//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'session.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class Session {
  /// Returns a new [Session] instance.
  const Session({
    required this.id,
    required this.expiresAt,
    required this.token,
    this.ipAddress,
    this.userAgent,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'expiresAt', required: true, includeIfNull: false)
  final DateTime expiresAt;

  @JsonKey(name: r'token', required: true, includeIfNull: false)
  final String token;

  @JsonKey(name: r'ipAddress', required: false, includeIfNull: false)
  final String? ipAddress;

  @JsonKey(name: r'userAgent', required: false, includeIfNull: false)
  final String? userAgent;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Session &&
          other.id == id &&
          other.expiresAt == expiresAt &&
          other.token == token &&
          other.ipAddress == ipAddress &&
          other.userAgent == userAgent &&
          other.userId == userId &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      expiresAt.hashCode +
      token.hashCode +
      ipAddress.hashCode +
      userAgent.hashCode +
      userId.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
