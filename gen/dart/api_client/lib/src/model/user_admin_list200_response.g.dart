// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_admin_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserAdminList200ResponseCWProxy {
  UserAdminList200Response message(String? message);

  UserAdminList200Response data(List<User> data);

  UserAdminList200Response pagination(PaginationResult? pagination);

  UserAdminList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserAdminList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserAdminList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  UserAdminList200Response call({
    String? message,
    List<User> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserAdminList200Response.copyWith(...)` or call `instanceOfUserAdminList200Response.copyWith.fieldName(value)` for a single field.
class _$UserAdminList200ResponseCWProxyImpl
    implements _$UserAdminList200ResponseCWProxy {
  const _$UserAdminList200ResponseCWProxyImpl(this._value);

  final UserAdminList200Response _value;

  @override
  UserAdminList200Response message(String? message) => call(message: message);

  @override
  UserAdminList200Response data(List<User> data) => call(data: data);

  @override
  UserAdminList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  UserAdminList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserAdminList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserAdminList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  UserAdminList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return UserAdminList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<User>,
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

extension $UserAdminList200ResponseCopyWith on UserAdminList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserAdminList200Response.copyWith(...)` or `instanceOfUserAdminList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserAdminList200ResponseCWProxy get copyWith =>
      _$UserAdminList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAdminList200Response _$UserAdminList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UserAdminList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = UserAdminList200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$UserAdminList200ResponseToJson(
  UserAdminList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
