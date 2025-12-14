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
  const UpdateReview({this.categories, this.score, this.comment = ''});
  @JsonKey(name: r'categories', required: false, includeIfNull: false)
  final List<ReviewCategory>? categories;

  // minimum: 1
  // maximum: 5
  @JsonKey(name: r'score', required: false, includeIfNull: false)
  final int? score;

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
          other.categories == categories &&
          other.score == score &&
          other.comment == comment;

  @override
  int get hashCode => categories.hashCode + score.hashCode + comment.hashCode;

  factory UpdateReview.fromJson(Map<String, dynamic> json) =>
      _$UpdateReviewFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateReviewToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
