//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_newsletter.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertNewsletter {
  /// Returns a new [InsertNewsletter] instance.
  const InsertNewsletter({
    required this.email,
     this.userId,
  });
  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;
  
  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is InsertNewsletter &&
    other.email == email &&
    other.userId == userId;

  @override
  int get hashCode =>
      email.hashCode +
      userId.hashCode;

  factory InsertNewsletter.fromJson(Map<String, dynamic> json) => _$InsertNewsletterFromJson(json);

  Map<String, dynamic> toJson() => _$InsertNewsletterToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

