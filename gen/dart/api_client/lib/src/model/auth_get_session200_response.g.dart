// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_get_session200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthGetSession200ResponseCWProxy {
  AuthGetSession200Response message(String message);

  AuthGetSession200Response data(GetSessionResponse? data);

  AuthGetSession200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthGetSession200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthGetSession200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthGetSession200Response call({
    String message,
    GetSessionResponse? data,
    num? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthGetSession200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthGetSession200Response.copyWith.fieldName(...)`
class _$AuthGetSession200ResponseCWProxyImpl
    implements _$AuthGetSession200ResponseCWProxy {
  const _$AuthGetSession200ResponseCWProxyImpl(this._value);

  final AuthGetSession200Response _value;

  @override
  AuthGetSession200Response message(String message) => this(message: message);

  @override
  AuthGetSession200Response data(GetSessionResponse? data) => this(data: data);

  @override
  AuthGetSession200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthGetSession200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthGetSession200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthGetSession200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthGetSession200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as GetSessionResponse?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $AuthGetSession200ResponseCopyWith on AuthGetSession200Response {
  /// Returns a callable class that can be used as follows: `instanceOfAuthGetSession200Response.copyWith(...)` or like so:`instanceOfAuthGetSession200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthGetSession200ResponseCWProxy get copyWith =>
      _$AuthGetSession200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthGetSession200Response _$AuthGetSession200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthGetSession200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = AuthGetSession200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => v == null
          ? null
          : GetSessionResponse.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$AuthGetSession200ResponseToJson(
  AuthGetSession200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data?.toJson(),
  'totalPages': ?instance.totalPages,
};
