// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_session_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GetSessionResponseCWProxy {
  GetSessionResponse token(String? token);

  GetSessionResponse user(User user);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `GetSessionResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GetSessionResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  GetSessionResponse call({String? token, User user});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGetSessionResponse.copyWith(...)` or call `instanceOfGetSessionResponse.copyWith.fieldName(value)` for a single field.
class _$GetSessionResponseCWProxyImpl implements _$GetSessionResponseCWProxy {
  const _$GetSessionResponseCWProxyImpl(this._value);

  final GetSessionResponse _value;

  @override
  GetSessionResponse token(String? token) => call(token: token);

  @override
  GetSessionResponse user(User user) => call(user: user);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `GetSessionResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GetSessionResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  GetSessionResponse call({
    Object? token = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return GetSessionResponse(
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String?,
      user: user == const $CopyWithPlaceholder() || user == null
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User,
    );
  }
}

extension $GetSessionResponseCopyWith on GetSessionResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGetSessionResponse.copyWith(...)` or `instanceOfGetSessionResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GetSessionResponseCWProxy get copyWith =>
      _$GetSessionResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSessionResponse _$GetSessionResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GetSessionResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['user']);
      final val = GetSessionResponse(
        token: $checkedConvert('token', (v) => v as String?),
        user: $checkedConvert(
          'user',
          (v) => User.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$GetSessionResponseToJson(GetSessionResponse instance) =>
    <String, dynamic>{'token': ?instance.token, 'user': instance.user.toJson()};
