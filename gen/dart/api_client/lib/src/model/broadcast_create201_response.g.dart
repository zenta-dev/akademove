// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_create201_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BroadcastCreate201ResponseCWProxy {
  BroadcastCreate201Response message(String message);

  BroadcastCreate201Response data(BroadcastCreate201ResponseData data);

  BroadcastCreate201Response pagination(PaginationResult? pagination);

  BroadcastCreate201Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastCreate201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastCreate201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastCreate201Response call({
    String message,
    BroadcastCreate201ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBroadcastCreate201Response.copyWith(...)` or call `instanceOfBroadcastCreate201Response.copyWith.fieldName(value)` for a single field.
class _$BroadcastCreate201ResponseCWProxyImpl
    implements _$BroadcastCreate201ResponseCWProxy {
  const _$BroadcastCreate201ResponseCWProxyImpl(this._value);

  final BroadcastCreate201Response _value;

  @override
  BroadcastCreate201Response message(String message) => call(message: message);

  @override
  BroadcastCreate201Response data(BroadcastCreate201ResponseData data) =>
      call(data: data);

  @override
  BroadcastCreate201Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  BroadcastCreate201Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastCreate201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastCreate201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastCreate201Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BroadcastCreate201Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as BroadcastCreate201ResponseData,
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

extension $BroadcastCreate201ResponseCopyWith on BroadcastCreate201Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBroadcastCreate201Response.copyWith(...)` or `instanceOfBroadcastCreate201Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BroadcastCreate201ResponseCWProxy get copyWith =>
      _$BroadcastCreate201ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BroadcastCreate201Response _$BroadcastCreate201ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BroadcastCreate201Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BroadcastCreate201Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => BroadcastCreate201ResponseData.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$BroadcastCreate201ResponseToJson(
  BroadcastCreate201Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
