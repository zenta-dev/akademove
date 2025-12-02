// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_user_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeUserCreate200ResponseCWProxy {
  BadgeUserCreate200Response message(String message);

  BadgeUserCreate200Response data(UserBadge data);

  BadgeUserCreate200Response pagination(PaginationResult? pagination);

  BadgeUserCreate200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeUserCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeUserCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BadgeUserCreate200Response call({String message, UserBadge data, PaginationResult? pagination, int? totalPages});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBadgeUserCreate200Response.copyWith(...)` or call `instanceOfBadgeUserCreate200Response.copyWith.fieldName(value)` for a single field.
class _$BadgeUserCreate200ResponseCWProxyImpl implements _$BadgeUserCreate200ResponseCWProxy {
  const _$BadgeUserCreate200ResponseCWProxyImpl(this._value);

  final BadgeUserCreate200Response _value;

  @override
  BadgeUserCreate200Response message(String message) => call(message: message);

  @override
  BadgeUserCreate200Response data(UserBadge data) => call(data: data);

  @override
  BadgeUserCreate200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  BadgeUserCreate200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeUserCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeUserCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BadgeUserCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BadgeUserCreate200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as UserBadge,
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

extension $BadgeUserCreate200ResponseCopyWith on BadgeUserCreate200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBadgeUserCreate200Response.copyWith(...)` or `instanceOfBadgeUserCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeUserCreate200ResponseCWProxy get copyWith => _$BadgeUserCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeUserCreate200Response _$BadgeUserCreate200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BadgeUserCreate200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = BadgeUserCreate200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert('data', (v) => UserBadge.fromJson(v as Map<String, dynamic>)),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$BadgeUserCreate200ResponseToJson(BadgeUserCreate200Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
