// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_save_token200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationSaveToken200ResponseCWProxy {
  NotificationSaveToken200Response message(String message);

  NotificationSaveToken200Response data(
    NotificationSaveToken200ResponseData data,
  );

  NotificationSaveToken200Response pagination(PaginationResult? pagination);

  NotificationSaveToken200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationSaveToken200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationSaveToken200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationSaveToken200Response call({
    String message,
    NotificationSaveToken200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationSaveToken200Response.copyWith(...)` or call `instanceOfNotificationSaveToken200Response.copyWith.fieldName(value)` for a single field.
class _$NotificationSaveToken200ResponseCWProxyImpl
    implements _$NotificationSaveToken200ResponseCWProxy {
  const _$NotificationSaveToken200ResponseCWProxyImpl(this._value);

  final NotificationSaveToken200Response _value;

  @override
  NotificationSaveToken200Response message(String message) =>
      call(message: message);

  @override
  NotificationSaveToken200Response data(
    NotificationSaveToken200ResponseData data,
  ) => call(data: data);

  @override
  NotificationSaveToken200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  NotificationSaveToken200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationSaveToken200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationSaveToken200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationSaveToken200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return NotificationSaveToken200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as NotificationSaveToken200ResponseData,
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

extension $NotificationSaveToken200ResponseCopyWith
    on NotificationSaveToken200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationSaveToken200Response.copyWith(...)` or `instanceOfNotificationSaveToken200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationSaveToken200ResponseCWProxy get copyWith =>
      _$NotificationSaveToken200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSaveToken200Response _$NotificationSaveToken200ResponseFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('NotificationSaveToken200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = NotificationSaveToken200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => NotificationSaveToken200ResponseData.fromJson(
            v as Map<String, dynamic>,
          ),
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

Map<String, dynamic> _$NotificationSaveToken200ResponseToJson(
  NotificationSaveToken200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
