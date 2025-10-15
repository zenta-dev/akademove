// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_sign_up_user200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSignUpUser200ResponseCWProxy {
  AuthSignUpUser200Response message(String message);

  AuthSignUpUser200Response data(AuthSignUpUser200ResponseData data);

  AuthSignUpUser200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignUpUser200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignUpUser200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignUpUser200Response call({
    String message,
    AuthSignUpUser200ResponseData data,
    num? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthSignUpUser200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthSignUpUser200Response.copyWith.fieldName(...)`
class _$AuthSignUpUser200ResponseCWProxyImpl
    implements _$AuthSignUpUser200ResponseCWProxy {
  const _$AuthSignUpUser200ResponseCWProxyImpl(this._value);

  final AuthSignUpUser200Response _value;

  @override
  AuthSignUpUser200Response message(String message) => this(message: message);

  @override
  AuthSignUpUser200Response data(AuthSignUpUser200ResponseData data) =>
      this(data: data);

  @override
  AuthSignUpUser200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignUpUser200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignUpUser200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignUpUser200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthSignUpUser200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as AuthSignUpUser200ResponseData,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $AuthSignUpUser200ResponseCopyWith on AuthSignUpUser200Response {
  /// Returns a callable class that can be used as follows: `instanceOfAuthSignUpUser200Response.copyWith(...)` or like so:`instanceOfAuthSignUpUser200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthSignUpUser200ResponseCWProxy get copyWith =>
      _$AuthSignUpUser200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignUpUser200Response _$AuthSignUpUser200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthSignUpUser200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = AuthSignUpUser200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => AuthSignUpUser200ResponseData.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$AuthSignUpUser200ResponseToJson(
  AuthSignUpUser200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
