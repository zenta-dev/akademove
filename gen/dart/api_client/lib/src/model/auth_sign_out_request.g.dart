// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_sign_out_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSignOutRequestCWProxy {
  AuthSignOutRequest fcmToken(String? fcmToken);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthSignOutRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthSignOutRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthSignOutRequest call({String? fcmToken});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthSignOutRequest.copyWith(...)` or call `instanceOfAuthSignOutRequest.copyWith.fieldName(value)` for a single field.
class _$AuthSignOutRequestCWProxyImpl implements _$AuthSignOutRequestCWProxy {
  const _$AuthSignOutRequestCWProxyImpl(this._value);

  final AuthSignOutRequest _value;

  @override
  AuthSignOutRequest fcmToken(String? fcmToken) => call(fcmToken: fcmToken);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthSignOutRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthSignOutRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthSignOutRequest call({Object? fcmToken = const $CopyWithPlaceholder()}) {
    return AuthSignOutRequest(
      fcmToken: fcmToken == const $CopyWithPlaceholder()
          ? _value.fcmToken
          // ignore: cast_nullable_to_non_nullable
          : fcmToken as String?,
    );
  }
}

extension $AuthSignOutRequestCopyWith on AuthSignOutRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthSignOutRequest.copyWith(...)` or `instanceOfAuthSignOutRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthSignOutRequestCWProxy get copyWith =>
      _$AuthSignOutRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignOutRequest _$AuthSignOutRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuthSignOutRequest', json, ($checkedConvert) {
      final val = AuthSignOutRequest(
        fcmToken: $checkedConvert('fcmToken', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$AuthSignOutRequestToJson(AuthSignOutRequest instance) =>
    <String, dynamic>{'fcmToken': ?instance.fcmToken};
