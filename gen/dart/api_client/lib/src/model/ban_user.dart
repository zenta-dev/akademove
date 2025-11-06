//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'ban_user.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BanUser {
  /// Returns a new [BanUser] instance.
  const BanUser({required this.banReason, this.banExpiresIn});

  @JsonKey(name: r'banReason', required: true, includeIfNull: false)
  final String banReason;

  @JsonKey(name: r'banExpiresIn', required: false, includeIfNull: false)
  final num? banExpiresIn;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BanUser &&
          other.banReason == banReason &&
          other.banExpiresIn == banExpiresIn;

  @override
  int get hashCode => banReason.hashCode + banExpiresIn.hashCode;

  factory BanUser.fromJson(Map<String, dynamic> json) =>
      _$BanUserFromJson(json);

  Map<String, dynamic> toJson() => _$BanUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
