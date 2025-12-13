// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_ticket_assigned_to.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportTicketAssignedToCWProxy {
  SupportTicketAssignedTo name(String name);

  SupportTicketAssignedTo image(String? image);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportTicketAssignedTo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportTicketAssignedTo(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportTicketAssignedTo call({String name, String? image});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportTicketAssignedTo.copyWith(...)` or call `instanceOfSupportTicketAssignedTo.copyWith.fieldName(value)` for a single field.
class _$SupportTicketAssignedToCWProxyImpl
    implements _$SupportTicketAssignedToCWProxy {
  const _$SupportTicketAssignedToCWProxyImpl(this._value);

  final SupportTicketAssignedTo _value;

  @override
  SupportTicketAssignedTo name(String name) => call(name: name);

  @override
  SupportTicketAssignedTo image(String? image) => call(image: image);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportTicketAssignedTo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportTicketAssignedTo(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportTicketAssignedTo call({
    Object? name = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
  }) {
    return SupportTicketAssignedTo(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
    );
  }
}

extension $SupportTicketAssignedToCopyWith on SupportTicketAssignedTo {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportTicketAssignedTo.copyWith(...)` or `instanceOfSupportTicketAssignedTo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportTicketAssignedToCWProxy get copyWith =>
      _$SupportTicketAssignedToCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportTicketAssignedTo _$SupportTicketAssignedToFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('SupportTicketAssignedTo', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['name']);
  final val = SupportTicketAssignedTo(
    name: $checkedConvert('name', (v) => v as String),
    image: $checkedConvert('image', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$SupportTicketAssignedToToJson(
  SupportTicketAssignedTo instance,
) => <String, dynamic>{'name': instance.name, 'image': ?instance.image};
