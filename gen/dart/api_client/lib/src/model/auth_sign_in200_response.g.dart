// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_sign_in200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSignIn200ResponseCWProxy {
  AuthSignIn200Response message(String message);

  AuthSignIn200Response data(SignInResBody data);

  AuthSignIn200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignIn200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignIn200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignIn200Response call({
    String message,
    SignInResBody data,
    num? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthSignIn200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthSignIn200Response.copyWith.fieldName(...)`
class _$AuthSignIn200ResponseCWProxyImpl
    implements _$AuthSignIn200ResponseCWProxy {
  const _$AuthSignIn200ResponseCWProxyImpl(this._value);

  final AuthSignIn200Response _value;

  @override
  AuthSignIn200Response message(String message) => this(message: message);

  @override
  AuthSignIn200Response data(SignInResBody data) => this(data: data);

  @override
  AuthSignIn200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignIn200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignIn200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignIn200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthSignIn200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as SignInResBody,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $AuthSignIn200ResponseCopyWith on AuthSignIn200Response {
  /// Returns a callable class that can be used as follows: `instanceOfAuthSignIn200Response.copyWith(...)` or like so:`instanceOfAuthSignIn200Response.copyWith.fieldName(...)`.
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
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => SignInResBody.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$AuthSignIn200ResponseToJson(
  AuthSignIn200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
