//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user_badge_metadata.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserBadgeMetadata {
  /// Returns a new [UserBadgeMetadata] instance.
  const UserBadgeMetadata({
    this.ordersCompleted,
    this.finalRating,
    this.streakDays,
  });

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'ordersCompleted', required: false, includeIfNull: false)
  final int? ordersCompleted;

  // minimum: 0
  // maximum: 5
  @JsonKey(name: r'finalRating', required: false, includeIfNull: false)
  final num? finalRating;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'streakDays', required: false, includeIfNull: false)
  final int? streakDays;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBadgeMetadata &&
          other.ordersCompleted == ordersCompleted &&
          other.finalRating == finalRating &&
          other.streakDays == streakDays;

  @override
  int get hashCode =>
      ordersCompleted.hashCode + finalRating.hashCode + streakDays.hashCode;

  factory UserBadgeMetadata.fromJson(Map<String, dynamic> json) =>
      _$UserBadgeMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$UserBadgeMetadataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
