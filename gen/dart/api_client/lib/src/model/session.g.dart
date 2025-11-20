// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SessionCWProxy {
  Session id(String id);

  Session expiresAt(DateTime expiresAt);

  Session token(String token);

  Session ipAddress(String? ipAddress);

  Session userAgent(String? userAgent);

  Session userId(String userId);

  Session createdAt(DateTime createdAt);

  Session updatedAt(DateTime updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Session(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Session(...).copyWith(id: 12, name: "My name")
  /// ```
  Session call({
    String id,
    DateTime expiresAt,
    String token,
    String? ipAddress,
    String? userAgent,
    String userId,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSession.copyWith(...)` or call `instanceOfSession.copyWith.fieldName(value)` for a single field.
class _$SessionCWProxyImpl implements _$SessionCWProxy {
  const _$SessionCWProxyImpl(this._value);

  final Session _value;

  @override
  Session id(String id) => call(id: id);

  @override
  Session expiresAt(DateTime expiresAt) => call(expiresAt: expiresAt);

  @override
  Session token(String token) => call(token: token);

  @override
  Session ipAddress(String? ipAddress) => call(ipAddress: ipAddress);

  @override
  Session userAgent(String? userAgent) => call(userAgent: userAgent);

  @override
  Session userId(String userId) => call(userId: userId);

  @override
  Session createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  Session updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Session(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Session(...).copyWith(id: 12, name: "My name")
  /// ```
  Session call({
    Object? id = const $CopyWithPlaceholder(),
    Object? expiresAt = const $CopyWithPlaceholder(),
    Object? token = const $CopyWithPlaceholder(),
    Object? ipAddress = const $CopyWithPlaceholder(),
    Object? userAgent = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Session(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      expiresAt: expiresAt == const $CopyWithPlaceholder() || expiresAt == null
          ? _value.expiresAt
          // ignore: cast_nullable_to_non_nullable
          : expiresAt as DateTime,
      token: token == const $CopyWithPlaceholder() || token == null
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
      ipAddress: ipAddress == const $CopyWithPlaceholder()
          ? _value.ipAddress
          // ignore: cast_nullable_to_non_nullable
          : ipAddress as String?,
      userAgent: userAgent == const $CopyWithPlaceholder()
          ? _value.userAgent
          // ignore: cast_nullable_to_non_nullable
          : userAgent as String?,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
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

extension $SessionCopyWith on Session {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSession.copyWith(...)` or `instanceOfSession.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SessionCWProxy get copyWith => _$SessionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Session', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'expiresAt',
      'token',
      'userId',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = Session(
    id: $checkedConvert('id', (v) => v as String),
    expiresAt: $checkedConvert('expiresAt', (v) => DateTime.parse(v as String)),
    token: $checkedConvert('token', (v) => v as String),
    ipAddress: $checkedConvert('ipAddress', (v) => v as String?),
    userAgent: $checkedConvert('userAgent', (v) => v as String?),
    userId: $checkedConvert('userId', (v) => v as String),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
  'id': instance.id,
  'expiresAt': instance.expiresAt.toIso8601String(),
  'token': instance.token,
  'ipAddress': ?instance.ipAddress,
  'userAgent': ?instance.userAgent,
  'userId': instance.userId,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
