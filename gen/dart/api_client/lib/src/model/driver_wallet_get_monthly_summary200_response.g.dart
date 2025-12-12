// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_wallet_get_monthly_summary200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverWalletGetMonthlySummary200ResponseCWProxy {
  DriverWalletGetMonthlySummary200Response message(String message);

  DriverWalletGetMonthlySummary200Response data(
    WalletMonthlySummaryResponse data,
  );

  DriverWalletGetMonthlySummary200Response pagination(
    PaginationResult? pagination,
  );

  DriverWalletGetMonthlySummary200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletGetMonthlySummary200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletGetMonthlySummary200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletGetMonthlySummary200Response call({
    String message,
    WalletMonthlySummaryResponse data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverWalletGetMonthlySummary200Response.copyWith(...)` or call `instanceOfDriverWalletGetMonthlySummary200Response.copyWith.fieldName(value)` for a single field.
class _$DriverWalletGetMonthlySummary200ResponseCWProxyImpl
    implements _$DriverWalletGetMonthlySummary200ResponseCWProxy {
  const _$DriverWalletGetMonthlySummary200ResponseCWProxyImpl(this._value);

  final DriverWalletGetMonthlySummary200Response _value;

  @override
  DriverWalletGetMonthlySummary200Response message(String message) =>
      call(message: message);

  @override
  DriverWalletGetMonthlySummary200Response data(
    WalletMonthlySummaryResponse data,
  ) => call(data: data);

  @override
  DriverWalletGetMonthlySummary200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  DriverWalletGetMonthlySummary200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletGetMonthlySummary200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletGetMonthlySummary200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletGetMonthlySummary200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverWalletGetMonthlySummary200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
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

extension $DriverWalletGetMonthlySummary200ResponseCopyWith
    on DriverWalletGetMonthlySummary200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverWalletGetMonthlySummary200Response.copyWith(...)` or `instanceOfDriverWalletGetMonthlySummary200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverWalletGetMonthlySummary200ResponseCWProxy get copyWith =>
      _$DriverWalletGetMonthlySummary200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverWalletGetMonthlySummary200Response
_$DriverWalletGetMonthlySummary200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverWalletGetMonthlySummary200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = DriverWalletGetMonthlySummary200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) =>
              WalletMonthlySummaryResponse.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$DriverWalletGetMonthlySummary200ResponseToJson(
  DriverWalletGetMonthlySummary200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
