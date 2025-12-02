//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'pagination_result.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class PaginationResult {
  /// Returns a new [PaginationResult] instance.
  const PaginationResult({this.totalPages, this.nextCursor, this.hasMore});

  /// offset
  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final int? totalPages;

  /// cursor
  @JsonKey(name: r'nextCursor', required: false, includeIfNull: false)
  final String? nextCursor;

  /// cursor
  @JsonKey(name: r'hasMore', required: false, includeIfNull: false)
  final bool? hasMore;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaginationResult &&
          other.totalPages == totalPages &&
          other.nextCursor == nextCursor &&
          other.hasMore == hasMore;

  @override
  int get hashCode => totalPages.hashCode + nextCursor.hashCode + hasMore.hashCode;

  factory PaginationResult.fromJson(Map<String, dynamic> json) => _$PaginationResultFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
