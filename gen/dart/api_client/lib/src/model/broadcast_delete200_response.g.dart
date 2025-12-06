// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_delete200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BroadcastDelete200ResponseCWProxy {
  BroadcastDelete200Response message(String message);

  BroadcastDelete200Response data(BroadcastDelete200ResponseData data);

  BroadcastDelete200Response pagination(PaginationResult? pagination);

  BroadcastDelete200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastDelete200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastDelete200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastDelete200Response call({
    String message,
    BroadcastDelete200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBroadcastDelete200Response.copyWith(...)` or call `instanceOfBroadcastDelete200Response.copyWith.fieldName(value)` for a single field.
class _$BroadcastDelete200ResponseCWProxyImpl
    implements _$BroadcastDelete200ResponseCWProxy {
  const _$BroadcastDelete200ResponseCWProxyImpl(this._value);

  final BroadcastDelete200Response _value;

  @override
  BroadcastDelete200Response message(String message) => call(message: message);

  @override
  BroadcastDelete200Response data(BroadcastDelete200ResponseData data) =>
      call(data: data);

  @override
  BroadcastDelete200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  BroadcastDelete200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastDelete200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastDelete200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastDelete200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BroadcastDelete200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as BroadcastDelete200ResponseData,
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

extension $BroadcastDelete200ResponseCopyWith on BroadcastDelete200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBroadcastDelete200Response.copyWith(...)` or `instanceOfBroadcastDelete200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BroadcastDelete200ResponseCWProxy get copyWith =>
      _$BroadcastDelete200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BroadcastDelete200Response _$BroadcastDelete200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BroadcastDelete200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BroadcastDelete200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => BroadcastDelete200ResponseData.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$BroadcastDelete200ResponseToJson(
  BroadcastDelete200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
