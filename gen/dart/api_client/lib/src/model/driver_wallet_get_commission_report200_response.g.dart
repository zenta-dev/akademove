// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_wallet_get_commission_report200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverWalletGetCommissionReport200ResponseCWProxy {
  DriverWalletGetCommissionReport200Response message(String message);

  DriverWalletGetCommissionReport200Response data(
    CommissionReportResponse data,
  );

  DriverWalletGetCommissionReport200Response pagination(
    PaginationResult? pagination,
  );

  DriverWalletGetCommissionReport200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletGetCommissionReport200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletGetCommissionReport200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletGetCommissionReport200Response call({
    String message,
    CommissionReportResponse data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverWalletGetCommissionReport200Response.copyWith(...)` or call `instanceOfDriverWalletGetCommissionReport200Response.copyWith.fieldName(value)` for a single field.
class _$DriverWalletGetCommissionReport200ResponseCWProxyImpl
    implements _$DriverWalletGetCommissionReport200ResponseCWProxy {
  const _$DriverWalletGetCommissionReport200ResponseCWProxyImpl(this._value);

  final DriverWalletGetCommissionReport200Response _value;

  @override
  DriverWalletGetCommissionReport200Response message(String message) =>
      call(message: message);

  @override
  DriverWalletGetCommissionReport200Response data(
    CommissionReportResponse data,
  ) => call(data: data);

  @override
  DriverWalletGetCommissionReport200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  DriverWalletGetCommissionReport200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletGetCommissionReport200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletGetCommissionReport200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletGetCommissionReport200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverWalletGetCommissionReport200Response(
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

extension $DriverWalletGetCommissionReport200ResponseCopyWith
    on DriverWalletGetCommissionReport200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverWalletGetCommissionReport200Response.copyWith(...)` or `instanceOfDriverWalletGetCommissionReport200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverWalletGetCommissionReport200ResponseCWProxy get copyWith =>
      _$DriverWalletGetCommissionReport200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverWalletGetCommissionReport200Response
_$DriverWalletGetCommissionReport200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverWalletGetCommissionReport200Response', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverWalletGetCommissionReport200Response(
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

Map<String, dynamic> _$DriverWalletGetCommissionReport200ResponseToJson(
  DriverWalletGetCommissionReport200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
