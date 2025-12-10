// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_list_events200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudListEvents200ResponseCWProxy {
  FraudListEvents200Response message(String message);

  FraudListEvents200Response data(List<FraudEvent> data);

  FraudListEvents200Response pagination(PaginationResult? pagination);

  FraudListEvents200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudListEvents200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudListEvents200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudListEvents200Response call({
    String message,
    List<FraudEvent> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudListEvents200Response.copyWith(...)` or call `instanceOfFraudListEvents200Response.copyWith.fieldName(value)` for a single field.
class _$FraudListEvents200ResponseCWProxyImpl
    implements _$FraudListEvents200ResponseCWProxy {
  const _$FraudListEvents200ResponseCWProxyImpl(this._value);

  final FraudListEvents200Response _value;

  @override
  FraudListEvents200Response message(String message) => call(message: message);

  @override
  FraudListEvents200Response data(List<FraudEvent> data) => call(data: data);

  @override
  FraudListEvents200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  FraudListEvents200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudListEvents200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudListEvents200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudListEvents200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return FraudListEvents200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<FraudEvent>,
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

extension $FraudListEvents200ResponseCopyWith on FraudListEvents200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudListEvents200Response.copyWith(...)` or `instanceOfFraudListEvents200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudListEvents200ResponseCWProxy get copyWith =>
      _$FraudListEvents200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudListEvents200Response _$FraudListEvents200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FraudListEvents200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = FraudListEvents200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => FraudEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
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

Map<String, dynamic> _$FraudListEvents200ResponseToJson(
  FraudListEvents200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
