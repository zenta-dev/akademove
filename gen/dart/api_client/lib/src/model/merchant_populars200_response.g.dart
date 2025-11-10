// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_populars200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantPopulars200ResponseCWProxy {
  MerchantPopulars200Response message(String message);

  MerchantPopulars200Response data(List<Merchant> data);

  MerchantPopulars200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MerchantPopulars200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MerchantPopulars200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  MerchantPopulars200Response call({
    String message,
    List<Merchant> data,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMerchantPopulars200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMerchantPopulars200Response.copyWith.fieldName(...)`
class _$MerchantPopulars200ResponseCWProxyImpl
    implements _$MerchantPopulars200ResponseCWProxy {
  const _$MerchantPopulars200ResponseCWProxyImpl(this._value);

  final MerchantPopulars200Response _value;

  @override
  MerchantPopulars200Response message(String message) => this(message: message);

  @override
  MerchantPopulars200Response data(List<Merchant> data) => this(data: data);

  @override
  MerchantPopulars200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MerchantPopulars200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MerchantPopulars200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  MerchantPopulars200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantPopulars200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Merchant>,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $MerchantPopulars200ResponseCopyWith on MerchantPopulars200Response {
  /// Returns a callable class that can be used as follows: `instanceOfMerchantPopulars200Response.copyWith(...)` or like so:`instanceOfMerchantPopulars200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantPopulars200ResponseCWProxy get copyWith =>
      _$MerchantPopulars200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantPopulars200Response _$MerchantPopulars200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantPopulars200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = MerchantPopulars200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Merchant.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$MerchantPopulars200ResponseToJson(
  MerchantPopulars200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalPages': ?instance.totalPages,
};
