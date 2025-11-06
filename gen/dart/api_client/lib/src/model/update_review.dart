//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/review_category.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_review.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateReview {
  /// Returns a new [UpdateReview] instance.
  const UpdateReview({
    this.orderId,
    this.fromUserId,
    this.toUserId,
    this.category,
    this.score,
    this.comment = '',
  });

  @JsonKey(name: r'orderId', required: false, includeIfNull: false)
  final String? orderId;

  @JsonKey(name: r'fromUserId', required: false, includeIfNull: false)
  final String? fromUserId;

  @JsonKey(name: r'toUserId', required: false, includeIfNull: false)
  final String? toUserId;

  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final ReviewCategory? category;

  @JsonKey(name: r'score', required: false, includeIfNull: false)
  final num? score;

  @JsonKey(
    defaultValue: '',
    name: r'comment',
    required: false,
    includeIfNull: false,
  )
  final String? comment;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateReview &&
          other.orderId == orderId &&
          other.fromUserId == fromUserId &&
          other.toUserId == toUserId &&
          other.category == category &&
          other.score == score &&
          other.comment == comment;

  @override
  int get hashCode =>
      orderId.hashCode +
      fromUserId.hashCode +
      toUserId.hashCode +
      category.hashCode +
      score.hashCode +
      comment.hashCode;

  factory UpdateReview.fromJson(Map<String, dynamic> json) =>
      _$UpdateReviewFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateReviewToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
