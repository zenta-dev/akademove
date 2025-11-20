// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_sign_up_user201_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSignUpUser201ResponseCWProxy {
  AuthSignUpUser201Response message(String message);

  AuthSignUpUser201Response data(SignUpResponse data);

  AuthSignUpUser201Response pagination(PaginationResult? pagination);

  AuthSignUpUser201Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthSignUpUser201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthSignUpUser201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthSignUpUser201Response call({
    String message,
    SignUpResponse data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthSignUpUser201Response.copyWith(...)` or call `instanceOfAuthSignUpUser201Response.copyWith.fieldName(value)` for a single field.
class _$AuthSignUpUser201ResponseCWProxyImpl
    implements _$AuthSignUpUser201ResponseCWProxy {
  const _$AuthSignUpUser201ResponseCWProxyImpl(this._value);

  final AuthSignUpUser201Response _value;

  @override
  AuthSignUpUser201Response message(String message) => call(message: message);

  @override
  AuthSignUpUser201Response data(SignUpResponse data) => call(data: data);

  @override
  AuthSignUpUser201Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  AuthSignUpUser201Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthSignUpUser201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthSignUpUser201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthSignUpUser201Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthSignUpUser201Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as SignUpResponse,
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

extension $AuthSignUpUser201ResponseCopyWith on AuthSignUpUser201Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthSignUpUser201Response.copyWith(...)` or `instanceOfAuthSignUpUser201Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthSignUpUser201ResponseCWProxy get copyWith =>
      _$AuthSignUpUser201ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignUpUser201Response _$AuthSignUpUser201ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthSignUpUser201Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = AuthSignUpUser201Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => SignUpResponse.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$AuthSignUpUser201ResponseToJson(
  AuthSignUpUser201Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
