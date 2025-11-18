// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_sign_out200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSignOut200ResponseCWProxy {
  AuthSignOut200Response message(String message);

  AuthSignOut200Response data(Object? data);

  AuthSignOut200Response pagination(PaginationResult? pagination);

  AuthSignOut200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignOut200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignOut200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignOut200Response call({
    String message,
    Object? data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthSignOut200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthSignOut200Response.copyWith.fieldName(...)`
class _$AuthSignOut200ResponseCWProxyImpl
    implements _$AuthSignOut200ResponseCWProxy {
  const _$AuthSignOut200ResponseCWProxyImpl(this._value);

  final AuthSignOut200Response _value;

  @override
  AuthSignOut200Response message(String message) => this(message: message);

  @override
  AuthSignOut200Response data(Object? data) => this(data: data);

  @override
  AuthSignOut200Response pagination(PaginationResult? pagination) =>
      this(pagination: pagination);

  @override
  AuthSignOut200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignOut200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignOut200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignOut200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthSignOut200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Object?,
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

extension $AuthSignOut200ResponseCopyWith on AuthSignOut200Response {
  /// Returns a callable class that can be used as follows: `instanceOfAuthSignOut200Response.copyWith(...)` or like so:`instanceOfAuthSignOut200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthSignOut200ResponseCWProxy get copyWith =>
      _$AuthSignOut200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignOut200Response _$AuthSignOut200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthSignOut200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = AuthSignOut200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert('data', (v) => v),
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

Map<String, dynamic> _$AuthSignOut200ResponseToJson(
  AuthSignOut200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data,
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
