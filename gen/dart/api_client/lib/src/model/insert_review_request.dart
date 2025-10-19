//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_review_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertReviewRequest {
  /// Returns a new [InsertReviewRequest] instance.
  InsertReviewRequest({
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
  final InsertReviewRequestCategoryEnum category;

  @JsonKey(name: r'score', required: true, includeIfNull: false)
  final num score;

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
      other is InsertReviewRequest &&
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

  factory InsertReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$InsertReviewRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InsertReviewRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum InsertReviewRequestCategoryEnum {
  @JsonValue(r'cleanliness')
  cleanliness(r'cleanliness'),
  @JsonValue(r'courtesy')
  courtesy(r'courtesy'),
  @JsonValue(r'other')
  other(r'other');

  const InsertReviewRequestCategoryEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
