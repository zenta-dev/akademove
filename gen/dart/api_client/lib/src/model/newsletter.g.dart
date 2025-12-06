// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsletter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NewsletterCWProxy {
  Newsletter id(String id);

  Newsletter email(String email);

  Newsletter status(NewsletterStatus status);

  Newsletter userId(String? userId);

  Newsletter createdAt(DateTime createdAt);

  Newsletter updatedAt(DateTime updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Newsletter(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Newsletter(...).copyWith(id: 12, name: "My name")
  /// ```
  Newsletter call({
    String id,
    String email,
    NewsletterStatus status,
    String? userId,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNewsletter.copyWith(...)` or call `instanceOfNewsletter.copyWith.fieldName(value)` for a single field.
class _$NewsletterCWProxyImpl implements _$NewsletterCWProxy {
  const _$NewsletterCWProxyImpl(this._value);

  final Newsletter _value;

  @override
  Newsletter id(String id) => call(id: id);

  @override
  Newsletter email(String email) => call(email: email);

  @override
  Newsletter status(NewsletterStatus status) => call(status: status);

  @override
  Newsletter userId(String? userId) => call(userId: userId);

  @override
  Newsletter createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  Newsletter updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Newsletter(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Newsletter(...).copyWith(id: 12, name: "My name")
  /// ```
  Newsletter call({
    Object? id = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Newsletter(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as NewsletterStatus,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $NewsletterCopyWith on Newsletter {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNewsletter.copyWith(...)` or `instanceOfNewsletter.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NewsletterCWProxy get copyWith => _$NewsletterCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Newsletter _$NewsletterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Newsletter', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'email', 'status', 'createdAt', 'updatedAt'],
  );
  final val = Newsletter(
    id: $checkedConvert('id', (v) => v as String),
    email: $checkedConvert('email', (v) => v as String),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$NewsletterStatusEnumMap, v),
    ),
    userId: $checkedConvert('userId', (v) => v as String?),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$NewsletterToJson(Newsletter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'status': _$NewsletterStatusEnumMap[instance.status]!,
      'userId': ?instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$NewsletterStatusEnumMap = {
  NewsletterStatus.ACTIVE: 'ACTIVE',
  NewsletterStatus.UNSUBSCRIBED: 'UNSUBSCRIBED',
};
