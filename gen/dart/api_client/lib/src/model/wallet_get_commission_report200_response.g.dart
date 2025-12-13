// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_get_commission_report200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletGetCommissionReport200ResponseCWProxy {
  WalletGetCommissionReport200Response message(String message);

  WalletGetCommissionReport200Response data(CommissionReportResponse data);

  WalletGetCommissionReport200Response pagination(PaginationResult? pagination);

  WalletGetCommissionReport200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletGetCommissionReport200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletGetCommissionReport200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletGetCommissionReport200Response call({
    String message,
    CommissionReportResponse data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWalletGetCommissionReport200Response.copyWith(...)` or call `instanceOfWalletGetCommissionReport200Response.copyWith.fieldName(value)` for a single field.
class _$WalletGetCommissionReport200ResponseCWProxyImpl
    implements _$WalletGetCommissionReport200ResponseCWProxy {
  const _$WalletGetCommissionReport200ResponseCWProxyImpl(this._value);

  final WalletGetCommissionReport200Response _value;

  @override
  WalletGetCommissionReport200Response message(String message) =>
      call(message: message);

  @override
  WalletGetCommissionReport200Response data(CommissionReportResponse data) =>
      call(data: data);

  @override
  WalletGetCommissionReport200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  WalletGetCommissionReport200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletGetCommissionReport200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletGetCommissionReport200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletGetCommissionReport200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return WalletGetCommissionReport200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as CommissionReportResponse,
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

extension $WalletGetCommissionReport200ResponseCopyWith
    on WalletGetCommissionReport200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWalletGetCommissionReport200Response.copyWith(...)` or `instanceOfWalletGetCommissionReport200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletGetCommissionReport200ResponseCWProxy get copyWith =>
      _$WalletGetCommissionReport200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletGetCommissionReport200Response
_$WalletGetCommissionReport200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WalletGetCommissionReport200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = WalletGetCommissionReport200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => CommissionReportResponse.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$WalletGetCommissionReport200ResponseToJson(
  WalletGetCommissionReport200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
