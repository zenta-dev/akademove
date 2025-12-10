// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ContactList200ResponseCWProxy {
  ContactList200Response message(String message);

  ContactList200Response data(ContactList200ResponseData data);

  ContactList200Response pagination(PaginationResult? pagination);

  ContactList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactList200Response call({
    String message,
    ContactList200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfContactList200Response.copyWith(...)` or call `instanceOfContactList200Response.copyWith.fieldName(value)` for a single field.
class _$ContactList200ResponseCWProxyImpl
    implements _$ContactList200ResponseCWProxy {
  const _$ContactList200ResponseCWProxyImpl(this._value);

  final ContactList200Response _value;

  @override
  ContactList200Response message(String message) => call(message: message);

  @override
  ContactList200Response data(ContactList200ResponseData data) =>
      call(data: data);

  @override
  ContactList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  ContactList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ContactList200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ContactList200ResponseData,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as PaginationResult?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $ContactList200ResponseCopyWith on ContactList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfContactList200Response.copyWith(...)` or `instanceOfContactList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ContactList200ResponseCWProxy get copyWith =>
      _$ContactList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactList200Response _$ContactList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ContactList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ContactList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => ContactList200ResponseData.fromJson(v as Map<String, dynamic>),
    ),
    pagination: $checkedConvert(
      'pagination',
      (v) => v == null
          ? null
          : PaginationResult.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$ContactList200ResponseToJson(
  ContactList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
