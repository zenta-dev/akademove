// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resolve_report.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ResolveReportCWProxy {
  ResolveReport resolution(String resolution);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ResolveReport(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ResolveReport(...).copyWith(id: 12, name: "My name")
  /// ```
  ResolveReport call({String resolution});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfResolveReport.copyWith(...)` or call `instanceOfResolveReport.copyWith.fieldName(value)` for a single field.
class _$ResolveReportCWProxyImpl implements _$ResolveReportCWProxy {
  const _$ResolveReportCWProxyImpl(this._value);

  final ResolveReport _value;

  @override
  ResolveReport resolution(String resolution) => call(resolution: resolution);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ResolveReport(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ResolveReport(...).copyWith(id: 12, name: "My name")
  /// ```
  ResolveReport call({Object? resolution = const $CopyWithPlaceholder()}) {
    return ResolveReport(
      resolution:
          resolution == const $CopyWithPlaceholder() || resolution == null
          ? _value.resolution
          // ignore: cast_nullable_to_non_nullable
          : resolution as String,
    );
  }
}

extension $ResolveReportCopyWith on ResolveReport {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfResolveReport.copyWith(...)` or `instanceOfResolveReport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResolveReportCWProxy get copyWith => _$ResolveReportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResolveReport _$ResolveReportFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ResolveReport', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['resolution']);
      final val = ResolveReport(
        resolution: $checkedConvert('resolution', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ResolveReportToJson(ResolveReport instance) =>
    <String, dynamic>{'resolution': instance.resolution};
