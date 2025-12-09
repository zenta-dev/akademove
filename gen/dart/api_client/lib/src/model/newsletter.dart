//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/newsletter_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'newsletter.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Newsletter {
  /// Returns a new [Newsletter] instance.
  const Newsletter({
    required this.id,
    required this.email,
    required this.status,
     this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;
  
  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final NewsletterStatus status;
  
  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;
  
  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;
  
  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is Newsletter &&
    other.id == id &&
    other.email == email &&
    other.status == status &&
    other.userId == userId &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      email.hashCode +
      status.hashCode +
      userId.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory Newsletter.fromJson(Map<String, dynamic> json) => _$NewsletterFromJson(json);

  Map<String, dynamic> toJson() => _$NewsletterToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

