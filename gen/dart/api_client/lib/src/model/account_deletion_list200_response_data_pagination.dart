//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'account_deletion_list200_response_data_pagination.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AccountDeletionList200ResponseDataPagination {
  /// Returns a new [AccountDeletionList200ResponseDataPagination] instance.
  const AccountDeletionList200ResponseDataPagination({
    required this.totalPages,
  });
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(name: r'totalPages', required: true, includeIfNull: false)
  final int totalPages;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountDeletionList200ResponseDataPagination &&
    other.totalPages == totalPages;

  @override
  int get hashCode =>
      totalPages.hashCode;

  factory AccountDeletionList200ResponseDataPagination.fromJson(Map<String, dynamic> json) => _$AccountDeletionList200ResponseDataPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDeletionList200ResponseDataPaginationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

