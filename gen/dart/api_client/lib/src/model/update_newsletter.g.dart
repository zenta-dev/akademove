// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_newsletter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateNewsletterCWProxy {
  UpdateNewsletter email(String? email);

  UpdateNewsletter status(NewsletterStatus? status);

  UpdateNewsletter userId(String? userId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateNewsletter(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateNewsletter(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateNewsletter call({
    String? email,
    NewsletterStatus? status,
    String? userId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateNewsletter.copyWith(...)` or call `instanceOfUpdateNewsletter.copyWith.fieldName(value)` for a single field.
class _$UpdateNewsletterCWProxyImpl implements _$UpdateNewsletterCWProxy {
  const _$UpdateNewsletterCWProxyImpl(this._value);

  final UpdateNewsletter _value;

  @override
  UpdateNewsletter email(String? email) => call(email: email);

  @override
  UpdateNewsletter status(NewsletterStatus? status) => call(status: status);

  @override
  UpdateNewsletter userId(String? userId) => call(userId: userId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateNewsletter(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateNewsletter(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateNewsletter call({
    Object? email = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return UpdateNewsletter(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as NewsletterStatus?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
    );
  }
}

extension $UpdateNewsletterCopyWith on UpdateNewsletter {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateNewsletter.copyWith(...)` or `instanceOfUpdateNewsletter.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateNewsletterCWProxy get copyWith => _$UpdateNewsletterCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateNewsletter _$UpdateNewsletterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateNewsletter', json, ($checkedConvert) {
      final val = UpdateNewsletter(
        email: $checkedConvert('email', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecodeNullable(_$NewsletterStatusEnumMap, v),
        ),
        userId: $checkedConvert('userId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$UpdateNewsletterToJson(UpdateNewsletter instance) =>
    <String, dynamic>{
      'email': ?instance.email,
      'status': ?_$NewsletterStatusEnumMap[instance.status],
      'userId': ?instance.userId,
    };

const _$NewsletterStatusEnumMap = {
  NewsletterStatus.ACTIVE: 'ACTIVE',
  NewsletterStatus.UNSUBSCRIBED: 'UNSUBSCRIBED',
};
