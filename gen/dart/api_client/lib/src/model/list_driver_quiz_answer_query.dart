//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_quiz_answer_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'list_driver_quiz_answer_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ListDriverQuizAnswerQuery {
  /// Returns a new [ListDriverQuizAnswerQuery] instance.
  const ListDriverQuizAnswerQuery({
     this.driverId,
     this.status,
     this.page,
     this.limit,
  });
  @JsonKey(name: r'driverId', required: false, includeIfNull: false)
  final String? driverId;
  
  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final DriverQuizAnswerStatus? status;
  
          // minimum: 1
          // maximum: 9007199254740991
  @JsonKey(name: r'page', required: false, includeIfNull: false)
  final int? page;
  
          // minimum: 1
          // maximum: 1000
  @JsonKey(name: r'limit', required: false, includeIfNull: false)
  final int? limit;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is ListDriverQuizAnswerQuery &&
    other.driverId == driverId &&
    other.status == status &&
    other.page == page &&
    other.limit == limit;

  @override
  int get hashCode =>
      driverId.hashCode +
      status.hashCode +
      page.hashCode +
      limit.hashCode;

  factory ListDriverQuizAnswerQuery.fromJson(Map<String, dynamic> json) => _$ListDriverQuizAnswerQueryFromJson(json);

  Map<String, dynamic> toJson() => _$ListDriverQuizAnswerQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

