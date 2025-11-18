// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_result.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaginationResultCWProxy {
  PaginationResult totalPages(int? totalPages);

  PaginationResult nextCursor(String? nextCursor);

  PaginationResult hasMore(bool? hasMore);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginationResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginationResult(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginationResult call({int? totalPages, String? nextCursor, bool? hasMore});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaginationResult.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaginationResult.copyWith.fieldName(...)`
class _$PaginationResultCWProxyImpl implements _$PaginationResultCWProxy {
  const _$PaginationResultCWProxyImpl(this._value);

  final PaginationResult _value;

  @override
  PaginationResult totalPages(int? totalPages) => this(totalPages: totalPages);

  @override
  PaginationResult nextCursor(String? nextCursor) =>
      this(nextCursor: nextCursor);

  @override
  PaginationResult hasMore(bool? hasMore) => this(hasMore: hasMore);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginationResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginationResult(...).copyWith(id: 12, name: "My name")
  /// ````
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
  /// Returns a callable class that can be used as follows: `instanceOfPaginationResult.copyWith(...)` or like so:`instanceOfPaginationResult.copyWith.fieldName(...)`.
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

Map<String, dynamic> _$PaginationResultToJson(PaginationResult instance) =>
    <String, dynamic>{
      'totalPages': ?instance.totalPages,
      'nextCursor': ?instance.nextCursor,
      'hasMore': ?instance.hasMore,
    };
