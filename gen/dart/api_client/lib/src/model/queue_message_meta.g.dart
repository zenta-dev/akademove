// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_message_meta.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$QueueMessageMetaCWProxy {
  QueueMessageMeta messageId(String? messageId);

  QueueMessageMeta idempotencyKey(String? idempotencyKey);

  QueueMessageMeta createdAt(DateTime? createdAt);

  QueueMessageMeta retryCount(int? retryCount);

  QueueMessageMeta orderId(String? orderId);

  QueueMessageMeta userId(String? userId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QueueMessageMeta(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QueueMessageMeta(...).copyWith(id: 12, name: "My name")
  /// ```
  QueueMessageMeta call({
    String? messageId,
    String? idempotencyKey,
    DateTime? createdAt,
    int? retryCount,
    String? orderId,
    String? userId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfQueueMessageMeta.copyWith(...)` or call `instanceOfQueueMessageMeta.copyWith.fieldName(value)` for a single field.
class _$QueueMessageMetaCWProxyImpl implements _$QueueMessageMetaCWProxy {
  const _$QueueMessageMetaCWProxyImpl(this._value);

  final QueueMessageMeta _value;

  @override
  QueueMessageMeta messageId(String? messageId) => call(messageId: messageId);

  @override
  QueueMessageMeta idempotencyKey(String? idempotencyKey) =>
      call(idempotencyKey: idempotencyKey);

  @override
  QueueMessageMeta createdAt(DateTime? createdAt) => call(createdAt: createdAt);

  @override
  QueueMessageMeta retryCount(int? retryCount) => call(retryCount: retryCount);

  @override
  QueueMessageMeta orderId(String? orderId) => call(orderId: orderId);

  @override
  QueueMessageMeta userId(String? userId) => call(userId: userId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QueueMessageMeta(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QueueMessageMeta(...).copyWith(id: 12, name: "My name")
  /// ```
  QueueMessageMeta call({
    Object? messageId = const $CopyWithPlaceholder(),
    Object? idempotencyKey = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? retryCount = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return QueueMessageMeta(
      messageId: messageId == const $CopyWithPlaceholder()
          ? _value.messageId
          // ignore: cast_nullable_to_non_nullable
          : messageId as String?,
      idempotencyKey: idempotencyKey == const $CopyWithPlaceholder()
          ? _value.idempotencyKey
          // ignore: cast_nullable_to_non_nullable
          : idempotencyKey as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      retryCount: retryCount == const $CopyWithPlaceholder()
          ? _value.retryCount
          // ignore: cast_nullable_to_non_nullable
          : retryCount as int?,
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
    );
  }
}

extension $QueueMessageMetaCopyWith on QueueMessageMeta {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfQueueMessageMeta.copyWith(...)` or `instanceOfQueueMessageMeta.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$QueueMessageMetaCWProxy get copyWith => _$QueueMessageMetaCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueueMessageMeta _$QueueMessageMetaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('QueueMessageMeta', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['messageId', 'idempotencyKey', 'createdAt'],
      );
      final val = QueueMessageMeta(
        messageId: $checkedConvert('messageId', (v) => v as String?),
        idempotencyKey: $checkedConvert('idempotencyKey', (v) => v as String?),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        retryCount: $checkedConvert(
          'retryCount',
          (v) => (v as num?)?.toInt() ?? 0,
        ),
        orderId: $checkedConvert('orderId', (v) => v as String?),
        userId: $checkedConvert('userId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$QueueMessageMetaToJson(QueueMessageMeta instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'idempotencyKey': instance.idempotencyKey,
      'createdAt': instance.createdAt?.toIso8601String(),
      'retryCount': ?instance.retryCount,
      'orderId': ?instance.orderId,
      'userId': ?instance.userId,
    };
