// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ContactCWProxy {
  Contact id(String id);

  Contact name(String name);

  Contact email(String email);

  Contact subject(String subject);

  Contact message(String message);

  Contact status(ContactStatus status);

  Contact userId(String? userId);

  Contact respondedById(String? respondedById);

  Contact response(String? response);

  Contact createdAt(DateTime createdAt);

  Contact updatedAt(DateTime updatedAt);

  Contact respondedAt(DateTime? respondedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Contact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Contact(...).copyWith(id: 12, name: "My name")
  /// ```
  Contact call({
    String id,
    String name,
    String email,
    String subject,
    String message,
    ContactStatus status,
    String? userId,
    String? respondedById,
    String? response,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? respondedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfContact.copyWith(...)` or call `instanceOfContact.copyWith.fieldName(value)` for a single field.
class _$ContactCWProxyImpl implements _$ContactCWProxy {
  const _$ContactCWProxyImpl(this._value);

  final Contact _value;

  @override
  Contact id(String id) => call(id: id);

  @override
  Contact name(String name) => call(name: name);

  @override
  Contact email(String email) => call(email: email);

  @override
  Contact subject(String subject) => call(subject: subject);

  @override
  Contact message(String message) => call(message: message);

  @override
  Contact status(ContactStatus status) => call(status: status);

  @override
  Contact userId(String? userId) => call(userId: userId);

  @override
  Contact respondedById(String? respondedById) =>
      call(respondedById: respondedById);

  @override
  Contact response(String? response) => call(response: response);

  @override
  Contact createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  Contact updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  Contact respondedAt(DateTime? respondedAt) => call(respondedAt: respondedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Contact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Contact(...).copyWith(id: 12, name: "My name")
  /// ```
  Contact call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? subject = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? respondedById = const $CopyWithPlaceholder(),
    Object? response = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? respondedAt = const $CopyWithPlaceholder(),
  }) {
    return Contact(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as ContactStatus,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      respondedById: respondedById == const $CopyWithPlaceholder()
          ? _value.respondedById
          // ignore: cast_nullable_to_non_nullable
          : respondedById as String?,
      response: response == const $CopyWithPlaceholder()
          ? _value.response
          // ignore: cast_nullable_to_non_nullable
          : response as String?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
      respondedAt: respondedAt == const $CopyWithPlaceholder()
          ? _value.respondedAt
          // ignore: cast_nullable_to_non_nullable
          : respondedAt as DateTime?,
    );
  }
}

extension $ContactCopyWith on Contact {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfContact.copyWith(...)` or `instanceOfContact.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ContactCWProxy get copyWith => _$ContactCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Contact', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'email',
      'subject',
      'message',
      'status',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = Contact(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    email: $checkedConvert('email', (v) => v as String),
    subject: $checkedConvert('subject', (v) => v as String),
    message: $checkedConvert('message', (v) => v as String),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$ContactStatusEnumMap, v),
    ),
    userId: $checkedConvert('userId', (v) => v as String?),
    respondedById: $checkedConvert('respondedById', (v) => v as String?),
    response: $checkedConvert('response', (v) => v as String?),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
    respondedAt: $checkedConvert(
      'respondedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'subject': instance.subject,
  'message': instance.message,
  'status': _$ContactStatusEnumMap[instance.status]!,
  'userId': ?instance.userId,
  'respondedById': ?instance.respondedById,
  'response': ?instance.response,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'respondedAt': ?instance.respondedAt?.toIso8601String(),
};

const _$ContactStatusEnumMap = {
  ContactStatus.PENDING: 'PENDING',
  ContactStatus.REVIEWING: 'REVIEWING',
  ContactStatus.RESOLVED: 'RESOLVED',
  ContactStatus.CLOSED: 'CLOSED',
};
