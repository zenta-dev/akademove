// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_investigation.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StartInvestigationCWProxy {
  StartInvestigation notes(String notes);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `StartInvestigation(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StartInvestigation(...).copyWith(id: 12, name: "My name")
  /// ```
  StartInvestigation call({String notes});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStartInvestigation.copyWith(...)` or call `instanceOfStartInvestigation.copyWith.fieldName(value)` for a single field.
class _$StartInvestigationCWProxyImpl implements _$StartInvestigationCWProxy {
  const _$StartInvestigationCWProxyImpl(this._value);

  final StartInvestigation _value;

  @override
  StartInvestigation notes(String notes) => call(notes: notes);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `StartInvestigation(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StartInvestigation(...).copyWith(id: 12, name: "My name")
  /// ```
  StartInvestigation call({Object? notes = const $CopyWithPlaceholder()}) {
    return StartInvestigation(
      notes: notes == const $CopyWithPlaceholder() || notes == null
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String,
    );
  }
}

extension $StartInvestigationCopyWith on StartInvestigation {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStartInvestigation.copyWith(...)` or `instanceOfStartInvestigation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StartInvestigationCWProxy get copyWith =>
      _$StartInvestigationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartInvestigation _$StartInvestigationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StartInvestigation', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['notes']);
      final val = StartInvestigation(
        notes: $checkedConvert('notes', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$StartInvestigationToJson(StartInvestigation instance) =>
    <String, dynamic>{'notes': instance.notes};
