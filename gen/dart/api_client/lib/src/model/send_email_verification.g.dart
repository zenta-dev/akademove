// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_email_verification.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SendEmailVerificationCWProxy {
  SendEmailVerification email(String email);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SendEmailVerification(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SendEmailVerification(...).copyWith(id: 12, name: "My name")
  /// ```
  SendEmailVerification call({String email});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSendEmailVerification.copyWith(...)` or call `instanceOfSendEmailVerification.copyWith.fieldName(value)` for a single field.
class _$SendEmailVerificationCWProxyImpl
    implements _$SendEmailVerificationCWProxy {
  const _$SendEmailVerificationCWProxyImpl(this._value);

  final SendEmailVerification _value;

  @override
  SendEmailVerification email(String email) => call(email: email);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SendEmailVerification(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SendEmailVerification(...).copyWith(id: 12, name: "My name")
  /// ```
  SendEmailVerification call({Object? email = const $CopyWithPlaceholder()}) {
    return SendEmailVerification(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
    );
  }
}

extension $SendEmailVerificationCopyWith on SendEmailVerification {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSendEmailVerification.copyWith(...)` or `instanceOfSendEmailVerification.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SendEmailVerificationCWProxy get copyWith =>
      _$SendEmailVerificationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendEmailVerification _$SendEmailVerificationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('SendEmailVerification', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['email']);
  final val = SendEmailVerification(
    email: $checkedConvert('email', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$SendEmailVerificationToJson(
  SendEmailVerification instance,
) => <String, dynamic>{'email': instance.email};
