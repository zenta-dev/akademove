// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_lookup_by_phone200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserLookupByPhone200ResponseCWProxy {
  UserLookupByPhone200Response message(String message);

  UserLookupByPhone200Response data(UserLookupResult? data);

  UserLookupByPhone200Response pagination(PaginationResult? pagination);

  UserLookupByPhone200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserLookupByPhone200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserLookupByPhone200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  UserLookupByPhone200Response call({
    String message,
    UserLookupResult? data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserLookupByPhone200Response.copyWith(...)` or call `instanceOfUserLookupByPhone200Response.copyWith.fieldName(value)` for a single field.
class _$UserLookupByPhone200ResponseCWProxyImpl
    implements _$UserLookupByPhone200ResponseCWProxy {
  const _$UserLookupByPhone200ResponseCWProxyImpl(this._value);

  final UserLookupByPhone200Response _value;

  @override
  UserLookupByPhone200Response message(String message) =>
      call(message: message);

  @override
  UserLookupByPhone200Response data(UserLookupResult? data) => call(data: data);

  @override
  UserLookupByPhone200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  UserLookupByPhone200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserLookupByPhone200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserLookupByPhone200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  UserLookupByPhone200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return UserLookupByPhone200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as UserLookupResult?,
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

extension $UserLookupByPhone200ResponseCopyWith
    on UserLookupByPhone200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserLookupByPhone200Response.copyWith(...)` or `instanceOfUserLookupByPhone200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserLookupByPhone200ResponseCWProxy get copyWith =>
      _$UserLookupByPhone200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLookupByPhone200Response _$UserLookupByPhone200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UserLookupByPhone200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = UserLookupByPhone200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => v == null
          ? null
          : UserLookupResult.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$UserLookupByPhone200ResponseToJson(
  UserLookupByPhone200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data?.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
