//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/review_category.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'review.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Review {
  /// Returns a new [Review] instance.
  const Review({
    required this.id,
    required this.orderId,
    required this.fromUserId,
    required this.toUserId,
    required this.categories,
    required this.score,
    this.comment = '',
    required this.createdAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'fromUserId', required: true, includeIfNull: false)
  final String fromUserId;

  @JsonKey(name: r'toUserId', required: true, includeIfNull: false)
  final String toUserId;

  @JsonKey(name: r'categories', required: true, includeIfNull: false)
  final List<ReviewCategory> categories;

  // minimum: 1
  // maximum: 5
  @JsonKey(name: r'score', required: true, includeIfNull: false)
  final int score;

  @JsonKey(
    defaultValue: '',
    name: r'comment',
    required: false,
    includeIfNull: false,
  )
  final String? comment;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Review &&
          other.id == id &&
          other.orderId == orderId &&
          other.fromUserId == fromUserId &&
          other.toUserId == toUserId &&
          other.categories == categories &&
          other.score == score &&
          other.comment == comment &&
          other.createdAt == createdAt;

  @override
  int get hashCode =>
      id.hashCode +
      orderId.hashCode +
      fromUserId.hashCode +
      toUserId.hashCode +
      categories.hashCode +
      score.hashCode +
      comment.hashCode +
      createdAt.hashCode;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
