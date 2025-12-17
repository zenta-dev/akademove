//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/review.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'review_check_can_review200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReviewCheckCanReview200ResponseData {
  /// Returns a new [ReviewCheckCanReview200ResponseData] instance.
  const ReviewCheckCanReview200ResponseData({
    required this.canReview,
    required this.alreadyReviewed,
    required this.orderCompleted,
    required this.existingReview,
  });
  @JsonKey(name: r'canReview', required: true, includeIfNull: false)
  final bool canReview;

  @JsonKey(name: r'alreadyReviewed', required: true, includeIfNull: false)
  final bool alreadyReviewed;

  @JsonKey(name: r'orderCompleted', required: true, includeIfNull: false)
  final bool orderCompleted;

  @JsonKey(name: r'existingReview', required: true, includeIfNull: true)
  final Review? existingReview;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewCheckCanReview200ResponseData &&
          other.canReview == canReview &&
          other.alreadyReviewed == alreadyReviewed &&
          other.orderCompleted == orderCompleted &&
          other.existingReview == existingReview;

  @override
  int get hashCode =>
      canReview.hashCode +
      alreadyReviewed.hashCode +
      orderCompleted.hashCode +
      (existingReview == null ? 0 : existingReview.hashCode);

  factory ReviewCheckCanReview200ResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$ReviewCheckCanReview200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ReviewCheckCanReview200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
