//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'badge_create_request_criteria.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BadgeCreateRequestCriteria {
  /// Returns a new [BadgeCreateRequestCriteria] instance.
  const BadgeCreateRequestCriteria({
    this.minOrders,
    this.minRating,
    this.minOnTimeRate,
    this.minStreak,
    this.minEarnings,
  });

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'minOrders', required: false, includeIfNull: false)
  final int? minOrders;

  // minimum: 0
  // maximum: 5
  @JsonKey(name: r'minRating', required: false, includeIfNull: false)
  final num? minRating;

  // minimum: 0
  // maximum: 1
  @JsonKey(name: r'minOnTimeRate', required: false, includeIfNull: false)
  final num? minOnTimeRate;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'minStreak', required: false, includeIfNull: false)
  final int? minStreak;

  // minimum: 0
  @JsonKey(name: r'minEarnings', required: false, includeIfNull: false)
  final num? minEarnings;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeCreateRequestCriteria &&
          other.minOrders == minOrders &&
          other.minRating == minRating &&
          other.minOnTimeRate == minOnTimeRate &&
          other.minStreak == minStreak &&
          other.minEarnings == minEarnings;

  @override
  int get hashCode =>
      minOrders.hashCode +
      minRating.hashCode +
      minOnTimeRate.hashCode +
      minStreak.hashCode +
      minEarnings.hashCode;

  factory BadgeCreateRequestCriteria.fromJson(Map<String, dynamic> json) =>
      _$BadgeCreateRequestCriteriaFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeCreateRequestCriteriaToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
