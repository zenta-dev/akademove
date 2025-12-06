// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dismiss_report.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DismissReportCWProxy {
  DismissReport reason(String reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DismissReport(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DismissReport(...).copyWith(id: 12, name: "My name")
  /// ```
  DismissReport call({String reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDismissReport.copyWith(...)` or call `instanceOfDismissReport.copyWith.fieldName(value)` for a single field.
class _$DismissReportCWProxyImpl implements _$DismissReportCWProxy {
  const _$DismissReportCWProxyImpl(this._value);

  final DismissReport _value;

  @override
  DismissReport reason(String reason) => call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DismissReport(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DismissReport(...).copyWith(id: 12, name: "My name")
  /// ```
  DismissReport call({Object? reason = const $CopyWithPlaceholder()}) {
    return DismissReport(
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $DismissReportCopyWith on DismissReport {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDismissReport.copyWith(...)` or `instanceOfDismissReport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DismissReportCWProxy get copyWith => _$DismissReportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DismissReport _$DismissReportFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DismissReport', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['reason']);
      final val = DismissReport(
        reason: $checkedConvert('reason', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$DismissReportToJson(DismissReport instance) =>
    <String, dynamic>{'reason': instance.reason};
