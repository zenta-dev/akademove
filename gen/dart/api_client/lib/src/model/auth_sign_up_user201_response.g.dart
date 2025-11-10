// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_sign_up_user201_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSignUpUser201ResponseCWProxy {
  AuthSignUpUser201Response message(String message);

  AuthSignUpUser201Response data(SignUpResponse data);

  AuthSignUpUser201Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignUpUser201Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignUpUser201Response(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignUpUser201Response call({
    String message,
    SignUpResponse data,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthSignUpUser201Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthSignUpUser201Response.copyWith.fieldName(...)`
class _$AuthSignUpUser201ResponseCWProxyImpl
    implements _$AuthSignUpUser201ResponseCWProxy {
  const _$AuthSignUpUser201ResponseCWProxyImpl(this._value);

  final AuthSignUpUser201Response _value;

  @override
  AuthSignUpUser201Response message(String message) => this(message: message);

  @override
  AuthSignUpUser201Response data(SignUpResponse data) => this(data: data);

  @override
  AuthSignUpUser201Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignUpUser201Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignUpUser201Response(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignUpUser201Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthSignUpUser201Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as SignUpResponse,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $AuthSignUpUser201ResponseCopyWith on AuthSignUpUser201Response {
  /// Returns a callable class that can be used as follows: `instanceOfAuthSignUpUser201Response.copyWith(...)` or like so:`instanceOfAuthSignUpUser201Response.copyWith.fieldName(...)`.
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
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$AuthSignUpUser201ResponseToJson(
  AuthSignUpUser201Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
