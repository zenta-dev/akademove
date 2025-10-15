// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantList200ResponseCWProxy {
  MerchantList200Response message(String message);

  MerchantList200Response data(List<Merchant> data);

  MerchantList200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MerchantList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MerchantList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  MerchantList200Response call({
    String message,
    List<Merchant> data,
    num? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMerchantList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMerchantList200Response.copyWith.fieldName(...)`
class _$MerchantList200ResponseCWProxyImpl
    implements _$MerchantList200ResponseCWProxy {
  const _$MerchantList200ResponseCWProxyImpl(this._value);

  final MerchantList200Response _value;

  @override
  MerchantList200Response message(String message) => this(message: message);

  @override
  MerchantList200Response data(List<Merchant> data) => this(data: data);

  @override
  MerchantList200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MerchantList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MerchantList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  MerchantList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantList200Response(
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
          : totalPages as num?,
    );
  }
}

extension $MerchantList200ResponseCopyWith on MerchantList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfMerchantList200Response.copyWith(...)` or like so:`instanceOfMerchantList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantList200ResponseCWProxy get copyWith =>
      _$MerchantList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantList200Response _$MerchantList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = MerchantList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Merchant.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$MerchantList200ResponseToJson(
  MerchantList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalPages': ?instance.totalPages,
};
