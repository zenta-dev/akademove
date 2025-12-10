// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_stats200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BroadcastStats200ResponseCWProxy {
  BroadcastStats200Response message(String? message);

  BroadcastStats200Response data(BroadcastStats200ResponseData data);

  BroadcastStats200Response pagination(PaginationResult? pagination);

  BroadcastStats200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastStats200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastStats200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastStats200Response call({
    String? message,
    BroadcastStats200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBroadcastStats200Response.copyWith(...)` or call `instanceOfBroadcastStats200Response.copyWith.fieldName(value)` for a single field.
class _$BroadcastStats200ResponseCWProxyImpl
    implements _$BroadcastStats200ResponseCWProxy {
  const _$BroadcastStats200ResponseCWProxyImpl(this._value);

  final BroadcastStats200Response _value;

  @override
  BroadcastStats200Response message(String? message) => call(message: message);

  @override
  BroadcastStats200Response data(BroadcastStats200ResponseData data) =>
      call(data: data);

  @override
  BroadcastStats200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  BroadcastStats200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastStats200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastStats200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastStats200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BroadcastStats200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as BroadcastStats200ResponseData,
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

extension $BroadcastStats200ResponseCopyWith on BroadcastStats200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBroadcastStats200Response.copyWith(...)` or `instanceOfBroadcastStats200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BroadcastStats200ResponseCWProxy get copyWith =>
      _$BroadcastStats200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BroadcastStats200Response _$BroadcastStats200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BroadcastStats200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BroadcastStats200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => BroadcastStats200ResponseData.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$BroadcastStats200ResponseToJson(
  BroadcastStats200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
