// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_event_driver.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudEventDriverCWProxy {
  FraudEventDriver id(String id);

  FraudEventDriver studentId(num studentId);

  FraudEventDriver licensePlate(String licensePlate);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudEventDriver(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudEventDriver(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudEventDriver call({String id, num studentId, String licensePlate});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudEventDriver.copyWith(...)` or call `instanceOfFraudEventDriver.copyWith.fieldName(value)` for a single field.
class _$FraudEventDriverCWProxyImpl implements _$FraudEventDriverCWProxy {
  const _$FraudEventDriverCWProxyImpl(this._value);

  final FraudEventDriver _value;

  @override
  FraudEventDriver id(String id) => call(id: id);

  @override
  FraudEventDriver studentId(num studentId) => call(studentId: studentId);

  @override
  FraudEventDriver licensePlate(String licensePlate) =>
      call(licensePlate: licensePlate);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudEventDriver(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudEventDriver(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudEventDriver call({
    Object? id = const $CopyWithPlaceholder(),
    Object? studentId = const $CopyWithPlaceholder(),
    Object? licensePlate = const $CopyWithPlaceholder(),
  }) {
    return FraudEventDriver(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      studentId: studentId == const $CopyWithPlaceholder() || studentId == null
          ? _value.studentId
          // ignore: cast_nullable_to_non_nullable
          : studentId as num,
      licensePlate:
          licensePlate == const $CopyWithPlaceholder() || licensePlate == null
          ? _value.licensePlate
          // ignore: cast_nullable_to_non_nullable
          : licensePlate as String,
    );
  }
}

extension $FraudEventDriverCopyWith on FraudEventDriver {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudEventDriver.copyWith(...)` or `instanceOfFraudEventDriver.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudEventDriverCWProxy get copyWith => _$FraudEventDriverCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudEventDriver _$FraudEventDriverFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FraudEventDriver', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'studentId', 'licensePlate']);
      final val = FraudEventDriver(
        id: $checkedConvert('id', (v) => v as String),
        studentId: $checkedConvert('studentId', (v) => v as num),
        licensePlate: $checkedConvert('licensePlate', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$FraudEventDriverToJson(FraudEventDriver instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'licensePlate': instance.licensePlate,
    };
