//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_quiz_question_category.dart';
import 'package:api_client/src/model/driver_quiz_question_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'list_driver_quiz_question_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ListDriverQuizQuestionQuery {
  /// Returns a new [ListDriverQuizQuestionQuery] instance.
  const ListDriverQuizQuestionQuery({
    this.category,
    this.type,
    this.isActive,
    this.page,
    this.limit,
  });
  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final DriverQuizQuestionCategory? category;

  @JsonKey(name: r'type', required: false, includeIfNull: false)
  final DriverQuizQuestionType? type;

  @JsonKey(name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;

  // minimum: 1
  // maximum: 9007199254740991
  @JsonKey(name: r'page', required: false, includeIfNull: false)
  final int? page;

  // minimum: 1
  // maximum: 1000
  @JsonKey(name: r'limit', required: false, includeIfNull: false)
  final int? limit;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListDriverQuizQuestionQuery &&
          other.category == category &&
          other.type == type &&
          other.isActive == isActive &&
          other.page == page &&
          other.limit == limit;

  @override
  int get hashCode =>
      category.hashCode +
      type.hashCode +
      isActive.hashCode +
      page.hashCode +
      limit.hashCode;

  factory ListDriverQuizQuestionQuery.fromJson(Map<String, dynamic> json) =>
      _$ListDriverQuizQuestionQueryFromJson(json);

  Map<String, dynamic> toJson() => _$ListDriverQuizQuestionQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
