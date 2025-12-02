// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_list200_response_data_pagination.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ContactList200ResponseDataPaginationCWProxy {
  ContactList200ResponseDataPagination totalPages(int totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactList200ResponseDataPagination(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactList200ResponseDataPagination(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactList200ResponseDataPagination call({int totalPages});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfContactList200ResponseDataPagination.copyWith(...)` or call `instanceOfContactList200ResponseDataPagination.copyWith.fieldName(value)` for a single field.
class _$ContactList200ResponseDataPaginationCWProxyImpl
    implements _$ContactList200ResponseDataPaginationCWProxy {
  const _$ContactList200ResponseDataPaginationCWProxyImpl(this._value);

  final ContactList200ResponseDataPagination _value;

  @override
  ContactList200ResponseDataPagination totalPages(int totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactList200ResponseDataPagination(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactList200ResponseDataPagination(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactList200ResponseDataPagination call({
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ContactList200ResponseDataPagination(
      totalPages:
          totalPages == const $CopyWithPlaceholder() || totalPages == null
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int,
    );
  }
}

extension $ContactList200ResponseDataPaginationCopyWith
    on ContactList200ResponseDataPagination {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfContactList200ResponseDataPagination.copyWith(...)` or `instanceOfContactList200ResponseDataPagination.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ContactList200ResponseDataPaginationCWProxy get copyWith =>
      _$ContactList200ResponseDataPaginationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactList200ResponseDataPagination
_$ContactList200ResponseDataPaginationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ContactList200ResponseDataPagination', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['totalPages']);
      final val = ContactList200ResponseDataPagination(
        totalPages: $checkedConvert('totalPages', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$ContactList200ResponseDataPaginationToJson(
  ContactList200ResponseDataPagination instance,
) => <String, dynamic>{'totalPages': instance.totalPages};
