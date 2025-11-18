// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_admin_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserAdminCreate200ResponseCWProxy {
  UserAdminCreate200Response message(String message);

  UserAdminCreate200Response data(User data);

  UserAdminCreate200Response pagination(PaginationResult? pagination);

  UserAdminCreate200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserAdminCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserAdminCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  UserAdminCreate200Response call({
    String message,
    User data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserAdminCreate200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserAdminCreate200Response.copyWith.fieldName(...)`
class _$UserAdminCreate200ResponseCWProxyImpl
    implements _$UserAdminCreate200ResponseCWProxy {
  const _$UserAdminCreate200ResponseCWProxyImpl(this._value);

  final UserAdminCreate200Response _value;

  @override
  UserAdminCreate200Response message(String message) => this(message: message);

  @override
  UserAdminCreate200Response data(User data) => this(data: data);

  @override
  UserAdminCreate200Response pagination(PaginationResult? pagination) =>
      this(pagination: pagination);

  @override
  UserAdminCreate200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserAdminCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserAdminCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
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
          : message as String,
      data: data == const $CopyWithPlaceholder()
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
  /// Returns a callable class that can be used as follows: `instanceOfUserAdminCreate200Response.copyWith(...)` or like so:`instanceOfUserAdminCreate200Response.copyWith.fieldName(...)`.
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
    message: $checkedConvert('message', (v) => v as String),
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
