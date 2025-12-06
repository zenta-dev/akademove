// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_driver.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ApproveDriverCWProxy {
  ApproveDriver id(String id);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ApproveDriver(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ApproveDriver(...).copyWith(id: 12, name: "My name")
  /// ```
  ApproveDriver call({String id});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfApproveDriver.copyWith(...)` or call `instanceOfApproveDriver.copyWith.fieldName(value)` for a single field.
class _$ApproveDriverCWProxyImpl implements _$ApproveDriverCWProxy {
  const _$ApproveDriverCWProxyImpl(this._value);

  final ApproveDriver _value;

  @override
  ApproveDriver id(String id) => call(id: id);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ApproveDriver(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ApproveDriver(...).copyWith(id: 12, name: "My name")
  /// ```
  ApproveDriver call({Object? id = const $CopyWithPlaceholder()}) {
    return ApproveDriver(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $ApproveDriverCopyWith on ApproveDriver {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfApproveDriver.copyWith(...)` or `instanceOfApproveDriver.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ApproveDriverCWProxy get copyWith => _$ApproveDriverCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproveDriver _$ApproveDriverFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ApproveDriver', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id']);
      final val = ApproveDriver(id: $checkedConvert('id', (v) => v as String));
      return val;
    });

Map<String, dynamic> _$ApproveDriverToJson(ApproveDriver instance) =>
    <String, dynamic>{'id': instance.id};
