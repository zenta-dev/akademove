// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_get_stats200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudGetStats200ResponseCWProxy {
  FraudGetStats200Response message(String? message);

  FraudGetStats200Response data(FraudStats data);

  FraudGetStats200Response pagination(PaginationResult? pagination);

  FraudGetStats200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudGetStats200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudGetStats200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudGetStats200Response call({
    String? message,
    FraudStats data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudGetStats200Response.copyWith(...)` or call `instanceOfFraudGetStats200Response.copyWith.fieldName(value)` for a single field.
class _$FraudGetStats200ResponseCWProxyImpl
    implements _$FraudGetStats200ResponseCWProxy {
  const _$FraudGetStats200ResponseCWProxyImpl(this._value);

  final FraudGetStats200Response _value;

  @override
  FraudGetStats200Response message(String? message) => call(message: message);

  @override
  FraudGetStats200Response data(FraudStats data) => call(data: data);

  @override
  FraudGetStats200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  FraudGetStats200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudGetStats200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudGetStats200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudGetStats200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return FraudGetStats200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as FraudStats,
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

extension $FraudGetStats200ResponseCopyWith on FraudGetStats200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudGetStats200Response.copyWith(...)` or `instanceOfFraudGetStats200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudGetStats200ResponseCWProxy get copyWith =>
      _$FraudGetStats200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudGetStats200Response _$FraudGetStats200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FraudGetStats200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = FraudGetStats200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => FraudStats.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$FraudGetStats200ResponseToJson(
  FraudGetStats200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
