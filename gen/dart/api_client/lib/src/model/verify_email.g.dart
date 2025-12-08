// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VerifyEmailCWProxy {
  VerifyEmail email(String email);

  VerifyEmail code(String code);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `VerifyEmail(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VerifyEmail(...).copyWith(id: 12, name: "My name")
  /// ```
  VerifyEmail call({String email, String code});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfVerifyEmail.copyWith(...)` or call `instanceOfVerifyEmail.copyWith.fieldName(value)` for a single field.
class _$VerifyEmailCWProxyImpl implements _$VerifyEmailCWProxy {
  const _$VerifyEmailCWProxyImpl(this._value);

  final VerifyEmail _value;

  @override
  VerifyEmail email(String email) => call(email: email);

  @override
  VerifyEmail code(String code) => call(code: code);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `VerifyEmail(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VerifyEmail(...).copyWith(id: 12, name: "My name")
  /// ```
  VerifyEmail call({
    Object? email = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
  }) {
    return VerifyEmail(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
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
      $checkKeys(json, requiredKeys: const ['email', 'code']);
      final val = VerifyEmail(
        email: $checkedConvert('email', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$VerifyEmailToJson(VerifyEmail instance) =>
    <String, dynamic>{'email': instance.email, 'code': instance.code};
