// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_get_mine200_response_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantGetMine200ResponseBodyCWProxy {
  MerchantGetMine200ResponseBody message(String message);

  MerchantGetMine200ResponseBody data(Merchant data);

  MerchantGetMine200ResponseBody totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MerchantGetMine200ResponseBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MerchantGetMine200ResponseBody(...).copyWith(id: 12, name: "My name")
  /// ````
  MerchantGetMine200ResponseBody call({
    String message,
    Merchant data,
    num? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMerchantGetMine200ResponseBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMerchantGetMine200ResponseBody.copyWith.fieldName(...)`
class _$MerchantGetMine200ResponseBodyCWProxyImpl
    implements _$MerchantGetMine200ResponseBodyCWProxy {
  const _$MerchantGetMine200ResponseBodyCWProxyImpl(this._value);

  final MerchantGetMine200ResponseBody _value;

  @override
  MerchantGetMine200ResponseBody message(String message) =>
      this(message: message);

  @override
  MerchantGetMine200ResponseBody data(Merchant data) => this(data: data);

  @override
  MerchantGetMine200ResponseBody totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MerchantGetMine200ResponseBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MerchantGetMine200ResponseBody(...).copyWith(id: 12, name: "My name")
  /// ````
  MerchantGetMine200ResponseBody call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantGetMine200ResponseBody(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Merchant,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $MerchantGetMine200ResponseBodyCopyWith
    on MerchantGetMine200ResponseBody {
  /// Returns a callable class that can be used as follows: `instanceOfMerchantGetMine200ResponseBody.copyWith(...)` or like so:`instanceOfMerchantGetMine200ResponseBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantGetMine200ResponseBodyCWProxy get copyWith =>
      _$MerchantGetMine200ResponseBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantGetMine200ResponseBody _$MerchantGetMine200ResponseBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantGetMine200ResponseBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = MerchantGetMine200ResponseBody(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Merchant.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$MerchantGetMine200ResponseBodyToJson(
  MerchantGetMine200ResponseBody instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
