//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/newsletter_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_newsletter.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateNewsletter {
  /// Returns a new [UpdateNewsletter] instance.
  const UpdateNewsletter({
     this.email,
     this.status,
     this.userId,
  });
  @JsonKey(name: r'email', required: false, includeIfNull: false)
  final String? email;
  
  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final NewsletterStatus? status;
  
  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateNewsletter &&
    other.email == email &&
    other.status == status &&
    other.userId == userId;

  @override
  int get hashCode =>
      email.hashCode +
      status.hashCode +
      userId.hashCode;

  factory UpdateNewsletter.fromJson(Map<String, dynamic> json) => _$UpdateNewsletterFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateNewsletterToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

