//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/wallet_monthly_summary_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'wallet_get_monthly_summary200_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WalletGetMonthlySummary200Response {
  /// Returns a new [WalletGetMonthlySummary200Response] instance.
  const WalletGetMonthlySummary200Response({
    required this.message,
    required this.data,
    this.totalPages,
  });

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final WalletMonthlySummaryResponse data;

  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final num? totalPages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletGetMonthlySummary200Response &&
          other.message == message &&
          other.data == data &&
          other.totalPages == totalPages;

  @override
  int get hashCode => message.hashCode + data.hashCode + totalPages.hashCode;

  factory WalletGetMonthlySummary200Response.fromJson(
    Map<String, dynamic> json,
  ) => _$WalletGetMonthlySummary200ResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$WalletGetMonthlySummary200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
