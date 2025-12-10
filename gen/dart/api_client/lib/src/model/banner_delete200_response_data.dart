//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'banner_delete200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BannerDelete200ResponseData {
  /// Returns a new [BannerDelete200ResponseData] instance.
  const BannerDelete200ResponseData({required this.ok});
  @JsonKey(name: r'ok', required: true, includeIfNull: false)
  final bool ok;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BannerDelete200ResponseData && other.ok == ok;

  @override
  int get hashCode => ok.hashCode;

  factory BannerDelete200ResponseData.fromJson(Map<String, dynamic> json) =>
      _$BannerDelete200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$BannerDelete200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
