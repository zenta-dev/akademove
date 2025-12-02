//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_best_sellers200_response_data_inner_merchant.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantBestSellers200ResponseDataInnerMerchant {
  /// Returns a new [MerchantBestSellers200ResponseDataInnerMerchant] instance.
  const MerchantBestSellers200ResponseDataInnerMerchant({
    required this.id,
    required this.name,
    this.image,
    required this.rating,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'image', required: false, includeIfNull: false)
  final String? image;

  @JsonKey(name: r'rating', required: true, includeIfNull: false)
  final num rating;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantBestSellers200ResponseDataInnerMerchant &&
          other.id == id &&
          other.name == name &&
          other.image == image &&
          other.rating == rating;

  @override
  int get hashCode =>
      id.hashCode + name.hashCode + image.hashCode + rating.hashCode;

  factory MerchantBestSellers200ResponseDataInnerMerchant.fromJson(
    Map<String, dynamic> json,
  ) => _$MerchantBestSellers200ResponseDataInnerMerchantFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MerchantBestSellers200ResponseDataInnerMerchantToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
