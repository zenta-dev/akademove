//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'account_deletion_delete200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AccountDeletionDelete200ResponseData {
  /// Returns a new [AccountDeletionDelete200ResponseData] instance.
  const AccountDeletionDelete200ResponseData({required this.success});
  @JsonKey(name: r'success', required: true, includeIfNull: false)
  final bool success;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountDeletionDelete200ResponseData && other.success == success;

  @override
  int get hashCode => success.hashCode;

  factory AccountDeletionDelete200ResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$AccountDeletionDelete200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AccountDeletionDelete200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
