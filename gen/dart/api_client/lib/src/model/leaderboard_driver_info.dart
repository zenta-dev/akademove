//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'leaderboard_driver_info.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeaderboardDriverInfo {
  /// Returns a new [LeaderboardDriverInfo] instance.
  const LeaderboardDriverInfo({
    required this.id,
    required this.name,
    this.image,
    required this.rating,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'image', required: false, includeIfNull: false)
  final String? image;

  // minimum: 0
  // maximum: 5
  @JsonKey(name: r'rating', required: true, includeIfNull: false)
  final num rating;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaderboardDriverInfo &&
          other.id == id &&
          other.name == name &&
          other.image == image &&
          other.rating == rating;

  @override
  int get hashCode =>
      id.hashCode + name.hashCode + image.hashCode + rating.hashCode;

  factory LeaderboardDriverInfo.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardDriverInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardDriverInfoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
