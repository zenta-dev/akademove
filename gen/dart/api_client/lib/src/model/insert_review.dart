//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/review_category.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_review.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertReview {
  /// Returns a new [InsertReview] instance.
  const InsertReview({
    required this.orderId,
    required this.fromUserId,
    required this.toUserId,
    required this.category,
    required this.score,
     this.comment = '',
  });

  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;
  
  @JsonKey(name: r'fromUserId', required: true, includeIfNull: false)
  final String fromUserId;
  
  @JsonKey(name: r'toUserId', required: true, includeIfNull: false)
  final String toUserId;
  
  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final ReviewCategory category;
  
  @JsonKey(name: r'score', required: true, includeIfNull: false)
  final num score;
  
  @JsonKey(defaultValue: '',name: r'comment', required: false, includeIfNull: false)
  final String? comment;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is InsertReview &&
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

  factory InsertReview.fromJson(Map<String, dynamic> json) => _$InsertReviewFromJson(json);

  Map<String, dynamic> toJson() => _$InsertReviewToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

