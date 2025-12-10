// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_get_event200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudGetEvent200ResponseCWProxy {
  FraudGetEvent200Response message(String? message);

  FraudGetEvent200Response data(FraudEvent data);

  FraudGetEvent200Response pagination(PaginationResult? pagination);

  FraudGetEvent200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudGetEvent200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudGetEvent200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudGetEvent200Response call({
    String? message,
    FraudEvent data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudGetEvent200Response.copyWith(...)` or call `instanceOfFraudGetEvent200Response.copyWith.fieldName(value)` for a single field.
class _$FraudGetEvent200ResponseCWProxyImpl
    implements _$FraudGetEvent200ResponseCWProxy {
  const _$FraudGetEvent200ResponseCWProxyImpl(this._value);

  final FraudGetEvent200Response _value;

  @override
  FraudGetEvent200Response message(String? message) => call(message: message);

  @override
  FraudGetEvent200Response data(FraudEvent data) => call(data: data);

  @override
  FraudGetEvent200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  FraudGetEvent200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudGetEvent200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudGetEvent200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudGetEvent200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return FraudGetEvent200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as FraudEvent,
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

extension $FraudGetEvent200ResponseCopyWith on FraudGetEvent200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudGetEvent200Response.copyWith(...)` or `instanceOfFraudGetEvent200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudGetEvent200ResponseCWProxy get copyWith =>
      _$FraudGetEvent200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudGetEvent200Response _$FraudGetEvent200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FraudGetEvent200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = FraudGetEvent200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => FraudEvent.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$FraudGetEvent200ResponseToJson(
  FraudGetEvent200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
