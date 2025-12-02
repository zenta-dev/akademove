// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_result.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaginationResultCWProxy {
  PaginationResult totalPages(int? totalPages);

  PaginationResult nextCursor(String? nextCursor);

  PaginationResult hasMore(bool? hasMore);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaginationResult(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaginationResult(...).copyWith(id: 12, name: "My name")
  /// ```
  PaginationResult call({int? totalPages, String? nextCursor, bool? hasMore});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPaginationResult.copyWith(...)` or call `instanceOfPaginationResult.copyWith.fieldName(value)` for a single field.
class _$PaginationResultCWProxyImpl implements _$PaginationResultCWProxy {
  const _$PaginationResultCWProxyImpl(this._value);

  final PaginationResult _value;

  @override
  PaginationResult totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  PaginationResult nextCursor(String? nextCursor) => call(nextCursor: nextCursor);

  @override
  PaginationResult hasMore(bool? hasMore) => call(hasMore: hasMore);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaginationResult(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaginationResult(...).copyWith(id: 12, name: "My name")
  /// ```
  PaginationResult call({
    Object? totalPages = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
    Object? hasMore = const $CopyWithPlaceholder(),
  }) {
    return PaginationResult(
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as String?,
      hasMore: hasMore == const $CopyWithPlaceholder()
          ? _value.hasMore
          // ignore: cast_nullable_to_non_nullable
          : hasMore as bool?,
    );
  }
}

extension $PaginationResultCopyWith on PaginationResult {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPaginationResult.copyWith(...)` or `instanceOfPaginationResult.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaginationResultCWProxy get copyWith => _$PaginationResultCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationResult _$PaginationResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PaginationResult', json, ($checkedConvert) {
      final val = PaginationResult(
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
        hasMore: $checkedConvert('hasMore', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$PaginationResultToJson(PaginationResult instance) => <String, dynamic>{
  'totalPages': ?instance.totalPages,
  'nextCursor': ?instance.nextCursor,
  'hasMore': ?instance.hasMore,
};
