// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VerifyEmailCWProxy {
  VerifyEmail token(String token);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `VerifyEmail(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VerifyEmail(...).copyWith(id: 12, name: "My name")
  /// ```
  VerifyEmail call({String token});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfVerifyEmail.copyWith(...)` or call `instanceOfVerifyEmail.copyWith.fieldName(value)` for a single field.
class _$VerifyEmailCWProxyImpl implements _$VerifyEmailCWProxy {
  const _$VerifyEmailCWProxyImpl(this._value);

  final VerifyEmail _value;

  @override
  VerifyEmail token(String token) => call(token: token);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `VerifyEmail(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VerifyEmail(...).copyWith(id: 12, name: "My name")
  /// ```
  VerifyEmail call({Object? token = const $CopyWithPlaceholder()}) {
    return VerifyEmail(
      token: token == const $CopyWithPlaceholder() || token == null
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
    );
  }
}

extension $VerifyEmailCopyWith on VerifyEmail {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfVerifyEmail.copyWith(...)` or `instanceOfVerifyEmail.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VerifyEmailCWProxy get copyWith => _$VerifyEmailCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmail _$VerifyEmailFromJson(Map<String, dynamic> json) =>
    $checkedCreate('VerifyEmail', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['token']);
      final val = VerifyEmail(
        token: $checkedConvert('token', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$VerifyEmailToJson(VerifyEmail instance) =>
    <String, dynamic>{'token': instance.token};
