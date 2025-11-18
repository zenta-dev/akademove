// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_get_monthly_summary200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletGetMonthlySummary200ResponseCWProxy {
  WalletGetMonthlySummary200Response message(String message);

  WalletGetMonthlySummary200Response data(WalletMonthlySummaryResponse data);

  WalletGetMonthlySummary200Response pagination(PaginationResult? pagination);

  WalletGetMonthlySummary200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletGetMonthlySummary200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletGetMonthlySummary200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletGetMonthlySummary200Response call({
    String message,
    WalletMonthlySummaryResponse data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWalletGetMonthlySummary200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWalletGetMonthlySummary200Response.copyWith.fieldName(...)`
class _$WalletGetMonthlySummary200ResponseCWProxyImpl
    implements _$WalletGetMonthlySummary200ResponseCWProxy {
  const _$WalletGetMonthlySummary200ResponseCWProxyImpl(this._value);

  final WalletGetMonthlySummary200Response _value;

  @override
  WalletGetMonthlySummary200Response message(String message) =>
      this(message: message);

  @override
  WalletGetMonthlySummary200Response data(WalletMonthlySummaryResponse data) =>
      this(data: data);

  @override
  WalletGetMonthlySummary200Response pagination(PaginationResult? pagination) =>
      this(pagination: pagination);

  @override
  WalletGetMonthlySummary200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletGetMonthlySummary200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletGetMonthlySummary200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletGetMonthlySummary200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return WalletGetMonthlySummary200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as WalletMonthlySummaryResponse,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as PaginationResult?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $WalletGetMonthlySummary200ResponseCopyWith
    on WalletGetMonthlySummary200Response {
  /// Returns a callable class that can be used as follows: `instanceOfWalletGetMonthlySummary200Response.copyWith(...)` or like so:`instanceOfWalletGetMonthlySummary200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletGetMonthlySummary200ResponseCWProxy get copyWith =>
      _$WalletGetMonthlySummary200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletGetMonthlySummary200Response _$WalletGetMonthlySummary200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WalletGetMonthlySummary200Response', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = WalletGetMonthlySummary200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => WalletMonthlySummaryResponse.fromJson(v as Map<String, dynamic>),
    ),
    pagination: $checkedConvert(
      'pagination',
      (v) => v == null
          ? null
          : PaginationResult.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$WalletGetMonthlySummary200ResponseToJson(
  WalletGetMonthlySummary200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
