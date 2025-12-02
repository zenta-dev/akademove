// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_contact.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateContactCWProxy {
  UpdateContact name(String? name);

  UpdateContact email(String? email);

  UpdateContact subject(String? subject);

  UpdateContact message(String? message);

  UpdateContact status(ContactStatus? status);

  UpdateContact userId(String? userId);

  UpdateContact respondedById(String? respondedById);

  UpdateContact response(String? response);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateContact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateContact(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateContact call({
    String? name,
    String? email,
    String? subject,
    String? message,
    ContactStatus? status,
    String? userId,
    String? respondedById,
    String? response,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateContact.copyWith(...)` or call `instanceOfUpdateContact.copyWith.fieldName(value)` for a single field.
class _$UpdateContactCWProxyImpl implements _$UpdateContactCWProxy {
  const _$UpdateContactCWProxyImpl(this._value);

  final UpdateContact _value;

  @override
  UpdateContact name(String? name) => call(name: name);

  @override
  UpdateContact email(String? email) => call(email: email);

  @override
  UpdateContact subject(String? subject) => call(subject: subject);

  @override
  UpdateContact message(String? message) => call(message: message);

  @override
  UpdateContact status(ContactStatus? status) => call(status: status);

  @override
  UpdateContact userId(String? userId) => call(userId: userId);

  @override
  UpdateContact respondedById(String? respondedById) => call(respondedById: respondedById);

  @override
  UpdateContact response(String? response) => call(response: response);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateContact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateContact(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateContact call({
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? subject = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? respondedById = const $CopyWithPlaceholder(),
    Object? response = const $CopyWithPlaceholder(),
  }) {
    return UpdateContact(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      subject: subject == const $CopyWithPlaceholder()
          ? _value.subject
          // ignore: cast_nullable_to_non_nullable
          : subject as String?,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as ContactStatus?,
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
    );
  }
}

extension $UpdateContactCopyWith on UpdateContact {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateContact.copyWith(...)` or `instanceOfUpdateContact.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateContactCWProxy get copyWith => _$UpdateContactCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateContact _$UpdateContactFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateContact', json, ($checkedConvert) {
      final val = UpdateContact(
        name: $checkedConvert('name', (v) => v as String?),
        email: $checkedConvert('email', (v) => v as String?),
        subject: $checkedConvert('subject', (v) => v as String?),
        message: $checkedConvert('message', (v) => v as String?),
        status: $checkedConvert('status', (v) => $enumDecodeNullable(_$ContactStatusEnumMap, v)),
        userId: $checkedConvert('userId', (v) => v as String?),
        respondedById: $checkedConvert('respondedById', (v) => v as String?),
        response: $checkedConvert('response', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$UpdateContactToJson(UpdateContact instance) => <String, dynamic>{
  'name': ?instance.name,
  'email': ?instance.email,
  'subject': ?instance.subject,
  'message': ?instance.message,
  'status': ?_$ContactStatusEnumMap[instance.status],
  'userId': ?instance.userId,
  'respondedById': ?instance.respondedById,
  'response': ?instance.response,
};

const _$ContactStatusEnumMap = {
  ContactStatus.PENDING: 'PENDING',
  ContactStatus.REVIEWING: 'REVIEWING',
  ContactStatus.RESOLVED: 'RESOLVED',
  ContactStatus.CLOSED: 'CLOSED',
};
