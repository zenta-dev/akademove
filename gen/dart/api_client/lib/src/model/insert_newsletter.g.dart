// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_newsletter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertNewsletterCWProxy {
  InsertNewsletter email(String email);

  InsertNewsletter userId(String? userId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertNewsletter(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertNewsletter(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertNewsletter call({String email, String? userId});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertNewsletter.copyWith(...)` or call `instanceOfInsertNewsletter.copyWith.fieldName(value)` for a single field.
class _$InsertNewsletterCWProxyImpl implements _$InsertNewsletterCWProxy {
  const _$InsertNewsletterCWProxyImpl(this._value);

  final InsertNewsletter _value;

  @override
  InsertNewsletter email(String email) => call(email: email);

  @override
  InsertNewsletter userId(String? userId) => call(userId: userId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertNewsletter(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertNewsletter(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertNewsletter call({
    Object? email = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return InsertNewsletter(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
    );
  }
}

extension $InsertNewsletterCopyWith on InsertNewsletter {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertNewsletter.copyWith(...)` or `instanceOfInsertNewsletter.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertNewsletterCWProxy get copyWith => _$InsertNewsletterCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertNewsletter _$InsertNewsletterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertNewsletter', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['email']);
      final val = InsertNewsletter(
        email: $checkedConvert('email', (v) => v as String),
        userId: $checkedConvert('userId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$InsertNewsletterToJson(InsertNewsletter instance) =>
    <String, dynamic>{'email': instance.email, 'userId': ?instance.userId};
