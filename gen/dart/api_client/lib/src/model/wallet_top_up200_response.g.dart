// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_top_up200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletTopUp200ResponseCWProxy {
  WalletTopUp200Response message(String? message);

  WalletTopUp200Response data(Payment data);

  WalletTopUp200Response pagination(PaginationResult? pagination);

  WalletTopUp200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletTopUp200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletTopUp200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletTopUp200Response call({
    String? message,
    Payment data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWalletTopUp200Response.copyWith(...)` or call `instanceOfWalletTopUp200Response.copyWith.fieldName(value)` for a single field.
class _$WalletTopUp200ResponseCWProxyImpl
    implements _$WalletTopUp200ResponseCWProxy {
  const _$WalletTopUp200ResponseCWProxyImpl(this._value);

  final WalletTopUp200Response _value;

  @override
  WalletTopUp200Response message(String? message) => call(message: message);

  @override
  WalletTopUp200Response data(Payment data) => call(data: data);

  @override
  WalletTopUp200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  WalletTopUp200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletTopUp200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletTopUp200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletTopUp200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return WalletTopUp200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Payment,
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

extension $WalletTopUp200ResponseCopyWith on WalletTopUp200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWalletTopUp200Response.copyWith(...)` or `instanceOfWalletTopUp200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletTopUp200ResponseCWProxy get copyWith =>
      _$WalletTopUp200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletTopUp200Response _$WalletTopUp200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WalletTopUp200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = WalletTopUp200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => Payment.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$WalletTopUp200ResponseToJson(
  WalletTopUp200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
