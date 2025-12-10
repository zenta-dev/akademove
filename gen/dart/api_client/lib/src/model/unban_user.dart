//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'unban_user.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UnbanUser {
  /// Returns a new [UnbanUser] instance.
  const UnbanUser({
    required this.id,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UnbanUser &&
    other.id == id;

  @override
  int get hashCode =>
      id.hashCode;

  factory UnbanUser.fromJson(Map<String, dynamic> json) => _$UnbanUserFromJson(json);

  Map<String, dynamic> toJson() => _$UnbanUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

