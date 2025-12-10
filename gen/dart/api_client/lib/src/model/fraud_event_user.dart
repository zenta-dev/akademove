//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'fraud_event_user.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FraudEventUser {
  /// Returns a new [FraudEventUser] instance.
  const FraudEventUser({
    required this.id,
    required this.name,
    required this.email,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FraudEventUser &&
          other.id == id &&
          other.name == name &&
          other.email == email;

  @override
  int get hashCode => id.hashCode + name.hashCode + email.hashCode;

  factory FraudEventUser.fromJson(Map<String, dynamic> json) =>
      _$FraudEventUserFromJson(json);

  Map<String, dynamic> toJson() => _$FraudEventUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
