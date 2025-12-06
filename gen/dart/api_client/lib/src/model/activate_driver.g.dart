// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activate_driver.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ActivateDriverCWProxy {
  ActivateDriver id(String id);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ActivateDriver(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ActivateDriver(...).copyWith(id: 12, name: "My name")
  /// ```
  ActivateDriver call({String id});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfActivateDriver.copyWith(...)` or call `instanceOfActivateDriver.copyWith.fieldName(value)` for a single field.
class _$ActivateDriverCWProxyImpl implements _$ActivateDriverCWProxy {
  const _$ActivateDriverCWProxyImpl(this._value);

  final ActivateDriver _value;

  @override
  ActivateDriver id(String id) => call(id: id);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ActivateDriver(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ActivateDriver(...).copyWith(id: 12, name: "My name")
  /// ```
  ActivateDriver call({Object? id = const $CopyWithPlaceholder()}) {
    return ActivateDriver(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $ActivateDriverCopyWith on ActivateDriver {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfActivateDriver.copyWith(...)` or `instanceOfActivateDriver.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ActivateDriverCWProxy get copyWith => _$ActivateDriverCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivateDriver _$ActivateDriverFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ActivateDriver', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id']);
      final val = ActivateDriver(id: $checkedConvert('id', (v) => v as String));
      return val;
    });

Map<String, dynamic> _$ActivateDriverToJson(ActivateDriver instance) =>
    <String, dynamic>{'id': instance.id};
