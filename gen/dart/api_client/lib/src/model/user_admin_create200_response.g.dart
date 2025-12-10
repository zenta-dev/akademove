// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_admin_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserAdminCreate200ResponseCWProxy {
  UserAdminCreate200Response message(String? message);

  UserAdminCreate200Response data(User data);

  UserAdminCreate200Response pagination(PaginationResult? pagination);

  UserAdminCreate200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserAdminCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserAdminCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  UserAdminCreate200Response call({
    String? message,
    User data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserAdminCreate200Response.copyWith(...)` or call `instanceOfUserAdminCreate200Response.copyWith.fieldName(value)` for a single field.
class _$UserAdminCreate200ResponseCWProxyImpl
    implements _$UserAdminCreate200ResponseCWProxy {
  const _$UserAdminCreate200ResponseCWProxyImpl(this._value);

  final UserAdminCreate200Response _value;

  @override
  UserAdminCreate200Response message(String? message) => call(message: message);

  @override
  UserAdminCreate200Response data(User data) => call(data: data);

  @override
  UserAdminCreate200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  UserAdminCreate200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserAdminCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserAdminCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  UserAdminCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return UserAdminCreate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as User,
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

extension $UserAdminCreate200ResponseCopyWith on UserAdminCreate200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserAdminCreate200Response.copyWith(...)` or `instanceOfUserAdminCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserAdminCreate200ResponseCWProxy get copyWith =>
      _$UserAdminCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAdminCreate200Response _$UserAdminCreate200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UserAdminCreate200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = UserAdminCreate200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => User.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$UserAdminCreate200ResponseToJson(
  UserAdminCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
