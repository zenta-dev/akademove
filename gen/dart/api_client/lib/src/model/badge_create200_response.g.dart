// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeCreate200ResponseCWProxy {
  BadgeCreate200Response message(String message);

  BadgeCreate200Response data(Badge data);

  BadgeCreate200Response pagination(PaginationResult? pagination);

  BadgeCreate200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BadgeCreate200Response call({String message, Badge data, PaginationResult? pagination, int? totalPages});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBadgeCreate200Response.copyWith(...)` or call `instanceOfBadgeCreate200Response.copyWith.fieldName(value)` for a single field.
class _$BadgeCreate200ResponseCWProxyImpl implements _$BadgeCreate200ResponseCWProxy {
  const _$BadgeCreate200ResponseCWProxyImpl(this._value);

  final BadgeCreate200Response _value;

  @override
  BadgeCreate200Response message(String message) => call(message: message);

  @override
  BadgeCreate200Response data(Badge data) => call(data: data);

  @override
  BadgeCreate200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  BadgeCreate200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BadgeCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BadgeCreate200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Badge,
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

extension $BadgeCreate200ResponseCopyWith on BadgeCreate200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBadgeCreate200Response.copyWith(...)` or `instanceOfBadgeCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeCreate200ResponseCWProxy get copyWith => _$BadgeCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeCreate200Response _$BadgeCreate200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BadgeCreate200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = BadgeCreate200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert('data', (v) => Badge.fromJson(v as Map<String, dynamic>)),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$BadgeCreate200ResponseToJson(BadgeCreate200Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
