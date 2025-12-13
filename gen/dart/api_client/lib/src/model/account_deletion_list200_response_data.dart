//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/account_deletion.dart';
import 'package:api_client/src/model/account_deletion_list200_response_data_pagination.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'account_deletion_list200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AccountDeletionList200ResponseData {
  /// Returns a new [AccountDeletionList200ResponseData] instance.
  const AccountDeletionList200ResponseData({
    required this.rows,
     this.pagination,
  });
  @JsonKey(name: r'rows', required: true, includeIfNull: false)
  final List<AccountDeletion> rows;
  
  @JsonKey(name: r'pagination', required: false, includeIfNull: false)
  final AccountDeletionList200ResponseDataPagination? pagination;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountDeletionList200ResponseData &&
    other.rows == rows &&
    other.pagination == pagination;

  @override
  int get hashCode =>
      rows.hashCode +
      pagination.hashCode;

  factory AccountDeletionList200ResponseData.fromJson(Map<String, dynamic> json) => _$AccountDeletionList200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDeletionList200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

