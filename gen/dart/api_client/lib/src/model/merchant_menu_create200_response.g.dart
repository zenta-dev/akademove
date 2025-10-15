// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantMenuCreate200ResponseCWProxy {
  MerchantMenuCreate200Response message(String message);

  MerchantMenuCreate200Response data(MerchantMenu data);

  MerchantMenuCreate200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MerchantMenuCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MerchantMenuCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  MerchantMenuCreate200Response call({
    String message,
    MerchantMenu data,
    num? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMerchantMenuCreate200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMerchantMenuCreate200Response.copyWith.fieldName(...)`
class _$MerchantMenuCreate200ResponseCWProxyImpl
    implements _$MerchantMenuCreate200ResponseCWProxy {
  const _$MerchantMenuCreate200ResponseCWProxyImpl(this._value);

  final MerchantMenuCreate200Response _value;

  @override
  MerchantMenuCreate200Response message(String message) =>
      this(message: message);

  @override
  MerchantMenuCreate200Response data(MerchantMenu data) => this(data: data);

  @override
  MerchantMenuCreate200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MerchantMenuCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MerchantMenuCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  MerchantMenuCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantMenuCreate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as MerchantMenu,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $MerchantMenuCreate200ResponseCopyWith
    on MerchantMenuCreate200Response {
  /// Returns a callable class that can be used as follows: `instanceOfMerchantMenuCreate200Response.copyWith(...)` or like so:`instanceOfMerchantMenuCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantMenuCreate200ResponseCWProxy get copyWith =>
      _$MerchantMenuCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantMenuCreate200Response _$MerchantMenuCreate200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantMenuCreate200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = MerchantMenuCreate200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => MerchantMenu.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$MerchantMenuCreate200ResponseToJson(
  MerchantMenuCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
