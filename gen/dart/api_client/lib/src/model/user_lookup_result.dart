//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user_lookup_result_phone.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user_lookup_result.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserLookupResult {
  /// Returns a new [UserLookupResult] instance.
  const UserLookupResult({
    required this.id,
    required this.name,
    this.phone,
    this.image,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'phone', required: false, includeIfNull: false)
  final UserLookupResultPhone? phone;

  @JsonKey(name: r'image', required: false, includeIfNull: false)
  final String? image;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLookupResult &&
          other.id == id &&
          other.name == name &&
          other.phone == phone &&
          other.image == image;

  @override
  int get hashCode =>
      id.hashCode +
      name.hashCode +
      phone.hashCode +
      (image == null ? 0 : image.hashCode);

  factory UserLookupResult.fromJson(Map<String, dynamic> json) =>
      _$UserLookupResultFromJson(json);

  Map<String, dynamic> toJson() => _$UserLookupResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
