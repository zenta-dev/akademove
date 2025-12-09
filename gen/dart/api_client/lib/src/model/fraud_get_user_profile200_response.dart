//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user_fraud_profile.dart';
import 'package:api_client/src/model/pagination_result.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'fraud_get_user_profile200_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FraudGetUserProfile200Response {
  /// Returns a new [FraudGetUserProfile200Response] instance.
  const FraudGetUserProfile200Response({
    required this.message,
    required this.data,
     this.pagination,
     this.totalPages,
  });
  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;
  
  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final UserFraudProfile? data;
  
  @JsonKey(name: r'pagination', required: false, includeIfNull: false)
  final PaginationResult? pagination;
  
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final int? totalPages;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is FraudGetUserProfile200Response &&
    other.message == message &&
    other.data == data &&
    other.pagination == pagination &&
    other.totalPages == totalPages;

  @override
  int get hashCode =>
      message.hashCode +
      (data == null ? 0 : data.hashCode) +
      pagination.hashCode +
      totalPages.hashCode;

  factory FraudGetUserProfile200Response.fromJson(Map<String, dynamic> json) => _$FraudGetUserProfile200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FraudGetUserProfile200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

