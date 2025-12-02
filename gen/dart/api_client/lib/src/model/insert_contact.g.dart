// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_contact.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertContactCWProxy {
  InsertContact name(String name);

  InsertContact email(String email);

  InsertContact subject(String subject);

  InsertContact message(String message);

  InsertContact userId(String? userId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertContact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertContact(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertContact call({
    String name,
    String email,
    String subject,
    String message,
    String? userId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertContact.copyWith(...)` or call `instanceOfInsertContact.copyWith.fieldName(value)` for a single field.
class _$InsertContactCWProxyImpl implements _$InsertContactCWProxy {
  const _$InsertContactCWProxyImpl(this._value);

  final InsertContact _value;

  @override
  InsertContact name(String name) => call(name: name);

  @override
  InsertContact email(String email) => call(email: email);

  @override
  InsertContact subject(String subject) => call(subject: subject);

  @override
  InsertContact message(String message) => call(message: message);

  @override
  InsertContact userId(String? userId) => call(userId: userId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertContact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertContact(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertContact call({
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? subject = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return InsertContact(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      subject: subject == const $CopyWithPlaceholder() || subject == null
          ? _value.subject
          // ignore: cast_nullable_to_non_nullable
          : subject as String,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
    );
  }
}

extension $InsertContactCopyWith on InsertContact {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertContact.copyWith(...)` or `instanceOfInsertContact.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertContactCWProxy get copyWith => _$InsertContactCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertContact _$InsertContactFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertContact', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['name', 'email', 'subject', 'message'],
      );
      final val = InsertContact(
        name: $checkedConvert('name', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String),
        subject: $checkedConvert('subject', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
        userId: $checkedConvert('userId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$InsertContactToJson(InsertContact instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'subject': instance.subject,
      'message': instance.message,
      'userId': ?instance.userId,
    };
