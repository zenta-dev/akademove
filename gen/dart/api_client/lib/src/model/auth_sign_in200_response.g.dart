// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_sign_in200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSignIn200ResponseCWProxy {
  AuthSignIn200Response message(String? message);

  AuthSignIn200Response data(SignInResponse data);

  AuthSignIn200Response pagination(PaginationResult? pagination);

  AuthSignIn200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthSignIn200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthSignIn200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthSignIn200Response call({
    String? message,
    SignInResponse data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthSignIn200Response.copyWith(...)` or call `instanceOfAuthSignIn200Response.copyWith.fieldName(value)` for a single field.
class _$AuthSignIn200ResponseCWProxyImpl
    implements _$AuthSignIn200ResponseCWProxy {
  const _$AuthSignIn200ResponseCWProxyImpl(this._value);

  final AuthSignIn200Response _value;

  @override
  AuthSignIn200Response message(String? message) => call(message: message);

  @override
  AuthSignIn200Response data(SignInResponse data) => call(data: data);

  @override
  AuthSignIn200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  AuthSignIn200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthSignIn200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthSignIn200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthSignIn200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthSignIn200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as SignInResponse,
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

extension $AuthSignIn200ResponseCopyWith on AuthSignIn200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthSignIn200Response.copyWith(...)` or `instanceOfAuthSignIn200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthSignIn200ResponseCWProxy get copyWith =>
      _$AuthSignIn200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignIn200Response _$AuthSignIn200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthSignIn200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = AuthSignIn200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => SignInResponse.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$AuthSignIn200ResponseToJson(
  AuthSignIn200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
