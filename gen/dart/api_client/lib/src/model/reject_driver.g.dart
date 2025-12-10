// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject_driver.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RejectDriverCWProxy {
  RejectDriver id(String id);

  RejectDriver reason(String reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RejectDriver(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RejectDriver(...).copyWith(id: 12, name: "My name")
  /// ```
  RejectDriver call({String id, String reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRejectDriver.copyWith(...)` or call `instanceOfRejectDriver.copyWith.fieldName(value)` for a single field.
class _$RejectDriverCWProxyImpl implements _$RejectDriverCWProxy {
  const _$RejectDriverCWProxyImpl(this._value);

  final RejectDriver _value;

  @override
  RejectDriver id(String id) => call(id: id);

  @override
  RejectDriver reason(String reason) => call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RejectDriver(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RejectDriver(...).copyWith(id: 12, name: "My name")
  /// ```
  RejectDriver call({
    Object? id = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return RejectDriver(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $RejectDriverCopyWith on RejectDriver {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRejectDriver.copyWith(...)` or `instanceOfRejectDriver.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RejectDriverCWProxy get copyWith => _$RejectDriverCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectDriver _$RejectDriverFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RejectDriver', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'reason']);
      final val = RejectDriver(
        id: $checkedConvert('id', (v) => v as String),
        reason: $checkedConvert('reason', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RejectDriverToJson(RejectDriver instance) =>
    <String, dynamic>{'id': instance.id, 'reason': instance.reason};
