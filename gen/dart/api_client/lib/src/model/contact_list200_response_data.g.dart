// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_list200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ContactList200ResponseDataCWProxy {
  ContactList200ResponseData rows(List<Contact> rows);

  ContactList200ResponseData pagination(
    ContactList200ResponseDataPagination? pagination,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactList200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactList200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactList200ResponseData call({
    List<Contact> rows,
    ContactList200ResponseDataPagination? pagination,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfContactList200ResponseData.copyWith(...)` or call `instanceOfContactList200ResponseData.copyWith.fieldName(value)` for a single field.
class _$ContactList200ResponseDataCWProxyImpl
    implements _$ContactList200ResponseDataCWProxy {
  const _$ContactList200ResponseDataCWProxyImpl(this._value);

  final ContactList200ResponseData _value;

  @override
  ContactList200ResponseData rows(List<Contact> rows) => call(rows: rows);

  @override
  ContactList200ResponseData pagination(
    ContactList200ResponseDataPagination? pagination,
  ) => call(pagination: pagination);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactList200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactList200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactList200ResponseData call({
    Object? rows = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
  }) {
    return ContactList200ResponseData(
      rows: rows == const $CopyWithPlaceholder() || rows == null
          ? _value.rows
          // ignore: cast_nullable_to_non_nullable
          : rows as List<Contact>,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as ContactList200ResponseDataPagination?,
    );
  }
}

extension $ContactList200ResponseDataCopyWith on ContactList200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfContactList200ResponseData.copyWith(...)` or `instanceOfContactList200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ContactList200ResponseDataCWProxy get copyWith =>
      _$ContactList200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactList200ResponseData _$ContactList200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ContactList200ResponseData', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['rows']);
  final val = ContactList200ResponseData(
    rows: $checkedConvert(
      'rows',
      (v) => (v as List<dynamic>)
          .map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    pagination: $checkedConvert(
      'pagination',
      (v) => v == null
          ? null
          : ContactList200ResponseDataPagination.fromJson(
              v as Map<String, dynamic>,
            ),
    ),
  );
  return val;
});

Map<String, dynamic> _$ContactList200ResponseDataToJson(
  ContactList200ResponseData instance,
) => <String, dynamic>{
  'rows': instance.rows.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
};
