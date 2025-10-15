//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'review_update_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReviewUpdateRequest {
  /// Returns a new [ReviewUpdateRequest] instance.
  ReviewUpdateRequest({
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
  final ReviewUpdateRequestCategoryEnum? category;

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
      other is ReviewUpdateRequest &&
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

  factory ReviewUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ReviewUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewUpdateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ReviewUpdateRequestCategoryEnum {
  @JsonValue(r'cleanliness')
  cleanliness(r'cleanliness'),
  @JsonValue(r'courtesy')
  courtesy(r'courtesy'),
  @JsonValue(r'other')
  other(r'other');

  const ReviewUpdateRequestCategoryEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
