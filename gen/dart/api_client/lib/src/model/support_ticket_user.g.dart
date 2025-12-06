// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_ticket_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportTicketUserCWProxy {
  SupportTicketUser name(String name);

  SupportTicketUser image(String? image);

  SupportTicketUser email(String email);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportTicketUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportTicketUser(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportTicketUser call({String name, String? image, String email});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportTicketUser.copyWith(...)` or call `instanceOfSupportTicketUser.copyWith.fieldName(value)` for a single field.
class _$SupportTicketUserCWProxyImpl implements _$SupportTicketUserCWProxy {
  const _$SupportTicketUserCWProxyImpl(this._value);

  final SupportTicketUser _value;

  @override
  SupportTicketUser name(String name) => call(name: name);

  @override
  SupportTicketUser image(String? image) => call(image: image);

  @override
  SupportTicketUser email(String email) => call(email: email);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportTicketUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportTicketUser(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportTicketUser call({
    Object? name = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return SupportTicketUser(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
    );
  }
}

extension $SupportTicketUserCopyWith on SupportTicketUser {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportTicketUser.copyWith(...)` or `instanceOfSupportTicketUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportTicketUserCWProxy get copyWith =>
      _$SupportTicketUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportTicketUser _$SupportTicketUserFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SupportTicketUser', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['name', 'email']);
      final val = SupportTicketUser(
        name: $checkedConvert('name', (v) => v as String),
        image: $checkedConvert('image', (v) => v as String?),
        email: $checkedConvert('email', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$SupportTicketUserToJson(SupportTicketUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': ?instance.image,
      'email': instance.email,
    };
