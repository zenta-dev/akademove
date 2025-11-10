// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantMenuList200ResponseCWProxy {
  MerchantMenuList200Response message(String message);

  MerchantMenuList200Response data(List<MerchantMenu> data);

  MerchantMenuList200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MerchantMenuList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MerchantMenuList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  MerchantMenuList200Response call({
    String message,
    List<MerchantMenu> data,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMerchantMenuList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMerchantMenuList200Response.copyWith.fieldName(...)`
class _$MerchantMenuList200ResponseCWProxyImpl
    implements _$MerchantMenuList200ResponseCWProxy {
  const _$MerchantMenuList200ResponseCWProxyImpl(this._value);

  final MerchantMenuList200Response _value;

  @override
  MerchantMenuList200Response message(String message) => this(message: message);

  @override
  MerchantMenuList200Response data(List<MerchantMenu> data) => this(data: data);

  @override
  MerchantMenuList200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MerchantMenuList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MerchantMenuList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  MerchantMenuList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantMenuList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<MerchantMenu>,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $MerchantMenuList200ResponseCopyWith on MerchantMenuList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfMerchantMenuList200Response.copyWith(...)` or like so:`instanceOfMerchantMenuList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantMenuList200ResponseCWProxy get copyWith =>
      _$MerchantMenuList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantMenuList200Response _$MerchantMenuList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantMenuList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = MerchantMenuList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => MerchantMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$MerchantMenuList200ResponseToJson(
  MerchantMenuList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalPages': ?instance.totalPages,
};
