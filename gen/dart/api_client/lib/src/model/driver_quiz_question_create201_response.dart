//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/pagination_result.dart';
import 'package:api_client/src/model/driver_quiz_question.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_quiz_question_create201_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverQuizQuestionCreate201Response {
  /// Returns a new [DriverQuizQuestionCreate201Response] instance.
  const DriverQuizQuestionCreate201Response({
    required this.message,
    required this.data,
     this.pagination,
     this.totalPages,
  });
  @JsonKey(name: r'message', required: true, includeIfNull: true)
  final String? message;
  
  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final DriverQuizQuestion data;
  
  @JsonKey(name: r'pagination', required: false, includeIfNull: false)
  final PaginationResult? pagination;
  
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final int? totalPages;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DriverQuizQuestionCreate201Response &&
    other.message == message &&
    other.data == data &&
    other.pagination == pagination &&
    other.totalPages == totalPages;

  @override
  int get hashCode =>
      (message == null ? 0 : message.hashCode) +
      data.hashCode +
      pagination.hashCode +
      totalPages.hashCode;

  factory DriverQuizQuestionCreate201Response.fromJson(Map<String, dynamic> json) => _$DriverQuizQuestionCreate201ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DriverQuizQuestionCreate201ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

