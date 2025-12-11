//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user_lookup_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserLookupQuery {
  /// Returns a new [UserLookupQuery] instance.
  const UserLookupQuery({
    required this.phone,
  });
  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final String phone;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UserLookupQuery &&
    other.phone == phone;

  @override
  int get hashCode =>
      phone.hashCode;

  factory UserLookupQuery.fromJson(Map<String, dynamic> json) => _$UserLookupQueryFromJson(json);

  Map<String, dynamic> toJson() => _$UserLookupQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

