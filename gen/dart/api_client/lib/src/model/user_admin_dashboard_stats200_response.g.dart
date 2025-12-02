// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_admin_dashboard_stats200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserAdminDashboardStats200ResponseCWProxy {
  UserAdminDashboardStats200Response message(String message);

  UserAdminDashboardStats200Response data(DashboardStats data);

  UserAdminDashboardStats200Response pagination(PaginationResult? pagination);

  UserAdminDashboardStats200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserAdminDashboardStats200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserAdminDashboardStats200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  UserAdminDashboardStats200Response call({
    String message,
    DashboardStats data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserAdminDashboardStats200Response.copyWith(...)` or call `instanceOfUserAdminDashboardStats200Response.copyWith.fieldName(value)` for a single field.
class _$UserAdminDashboardStats200ResponseCWProxyImpl
    implements _$UserAdminDashboardStats200ResponseCWProxy {
  const _$UserAdminDashboardStats200ResponseCWProxyImpl(this._value);

  final UserAdminDashboardStats200Response _value;

  @override
  UserAdminDashboardStats200Response message(String message) =>
      call(message: message);

  @override
  UserAdminDashboardStats200Response data(DashboardStats data) =>
      call(data: data);

  @override
  UserAdminDashboardStats200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  UserAdminDashboardStats200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserAdminDashboardStats200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserAdminDashboardStats200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  UserAdminDashboardStats200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return UserAdminDashboardStats200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as DashboardStats,
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

extension $UserAdminDashboardStats200ResponseCopyWith
    on UserAdminDashboardStats200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserAdminDashboardStats200Response.copyWith(...)` or `instanceOfUserAdminDashboardStats200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserAdminDashboardStats200ResponseCWProxy get copyWith =>
      _$UserAdminDashboardStats200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAdminDashboardStats200Response _$UserAdminDashboardStats200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UserAdminDashboardStats200Response', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = UserAdminDashboardStats200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => DashboardStats.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$UserAdminDashboardStats200ResponseToJson(
  UserAdminDashboardStats200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
