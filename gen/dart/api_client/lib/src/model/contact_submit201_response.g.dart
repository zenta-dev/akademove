// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_submit201_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ContactSubmit201ResponseCWProxy {
  ContactSubmit201Response message(String message);

  ContactSubmit201Response data(Contact data);

  ContactSubmit201Response pagination(PaginationResult? pagination);

  ContactSubmit201Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactSubmit201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactSubmit201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactSubmit201Response call({String message, Contact data, PaginationResult? pagination, int? totalPages});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfContactSubmit201Response.copyWith(...)` or call `instanceOfContactSubmit201Response.copyWith.fieldName(value)` for a single field.
class _$ContactSubmit201ResponseCWProxyImpl implements _$ContactSubmit201ResponseCWProxy {
  const _$ContactSubmit201ResponseCWProxyImpl(this._value);

  final ContactSubmit201Response _value;

  @override
  ContactSubmit201Response message(String message) => call(message: message);

  @override
  ContactSubmit201Response data(Contact data) => call(data: data);

  @override
  ContactSubmit201Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  ContactSubmit201Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactSubmit201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactSubmit201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactSubmit201Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ContactSubmit201Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Contact,
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

extension $ContactSubmit201ResponseCopyWith on ContactSubmit201Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfContactSubmit201Response.copyWith(...)` or `instanceOfContactSubmit201Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ContactSubmit201ResponseCWProxy get copyWith => _$ContactSubmit201ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactSubmit201Response _$ContactSubmit201ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ContactSubmit201Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = ContactSubmit201Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert('data', (v) => Contact.fromJson(v as Map<String, dynamic>)),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$ContactSubmit201ResponseToJson(ContactSubmit201Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
