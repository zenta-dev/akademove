// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suspend_driver.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SuspendDriverCWProxy {
  SuspendDriver id(String? id);

  SuspendDriver reason(String reason);

  SuspendDriver suspendUntil(DateTime? suspendUntil);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SuspendDriver(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SuspendDriver(...).copyWith(id: 12, name: "My name")
  /// ```
  SuspendDriver call({String? id, String reason, DateTime? suspendUntil});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSuspendDriver.copyWith(...)` or call `instanceOfSuspendDriver.copyWith.fieldName(value)` for a single field.
class _$SuspendDriverCWProxyImpl implements _$SuspendDriverCWProxy {
  const _$SuspendDriverCWProxyImpl(this._value);

  final SuspendDriver _value;

  @override
  SuspendDriver id(String? id) => call(id: id);

  @override
  SuspendDriver reason(String reason) => call(reason: reason);

  @override
  SuspendDriver suspendUntil(DateTime? suspendUntil) =>
      call(suspendUntil: suspendUntil);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SuspendDriver(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SuspendDriver(...).copyWith(id: 12, name: "My name")
  /// ```
  SuspendDriver call({
    Object? id = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? suspendUntil = const $CopyWithPlaceholder(),
  }) {
    return SuspendDriver(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      suspendUntil: suspendUntil == const $CopyWithPlaceholder()
          ? _value.suspendUntil
          // ignore: cast_nullable_to_non_nullable
          : suspendUntil as DateTime?,
    );
  }
}

extension $SuspendDriverCopyWith on SuspendDriver {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSuspendDriver.copyWith(...)` or `instanceOfSuspendDriver.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SuspendDriverCWProxy get copyWith => _$SuspendDriverCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuspendDriver _$SuspendDriverFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SuspendDriver', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'reason']);
      final val = SuspendDriver(
        id: $checkedConvert('id', (v) => v as String?),
        reason: $checkedConvert('reason', (v) => v as String),
        suspendUntil: $checkedConvert(
          'suspendUntil',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SuspendDriverToJson(SuspendDriver instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reason': instance.reason,
      'suspendUntil': ?instance.suspendUntil?.toIso8601String(),
    };
