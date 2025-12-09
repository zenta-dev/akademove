// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_signal.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudSignalCWProxy {
  FraudSignal type(FraudEventType type);

  FraudSignal severity(FraudSeverity severity);

  FraudSignal confidence(num confidence);

  FraudSignal metadata(Map<String, Object>? metadata);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudSignal(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudSignal(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudSignal call({
    FraudEventType type,
    FraudSeverity severity,
    num confidence,
    Map<String, Object>? metadata,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudSignal.copyWith(...)` or call `instanceOfFraudSignal.copyWith.fieldName(value)` for a single field.
class _$FraudSignalCWProxyImpl implements _$FraudSignalCWProxy {
  const _$FraudSignalCWProxyImpl(this._value);

  final FraudSignal _value;

  @override
  FraudSignal type(FraudEventType type) => call(type: type);

  @override
  FraudSignal severity(FraudSeverity severity) => call(severity: severity);

  @override
  FraudSignal confidence(num confidence) => call(confidence: confidence);

  @override
  FraudSignal metadata(Map<String, Object>? metadata) =>
      call(metadata: metadata);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudSignal(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudSignal(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudSignal call({
    Object? type = const $CopyWithPlaceholder(),
    Object? severity = const $CopyWithPlaceholder(),
    Object? confidence = const $CopyWithPlaceholder(),
    Object? metadata = const $CopyWithPlaceholder(),
  }) {
    return FraudSignal(
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as FraudEventType,
      severity: severity == const $CopyWithPlaceholder() || severity == null
          ? _value.severity
          // ignore: cast_nullable_to_non_nullable
          : severity as FraudSeverity,
      confidence:
          confidence == const $CopyWithPlaceholder() || confidence == null
          ? _value.confidence
          // ignore: cast_nullable_to_non_nullable
          : confidence as num,
      metadata: metadata == const $CopyWithPlaceholder()
          ? _value.metadata
          // ignore: cast_nullable_to_non_nullable
          : metadata as Map<String, Object>?,
    );
  }
}

extension $FraudSignalCopyWith on FraudSignal {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudSignal.copyWith(...)` or `instanceOfFraudSignal.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudSignalCWProxy get copyWith => _$FraudSignalCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudSignal _$FraudSignalFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FraudSignal', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'severity', 'confidence']);
      final val = FraudSignal(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$FraudEventTypeEnumMap, v),
        ),
        severity: $checkedConvert(
          'severity',
          (v) => $enumDecode(_$FraudSeverityEnumMap, v),
        ),
        confidence: $checkedConvert('confidence', (v) => v as num),
        metadata: $checkedConvert(
          'metadata',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as Object),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$FraudSignalToJson(FraudSignal instance) =>
    <String, dynamic>{
      'type': _$FraudEventTypeEnumMap[instance.type]!,
      'severity': _$FraudSeverityEnumMap[instance.severity]!,
      'confidence': instance.confidence,
      'metadata': ?instance.metadata,
    };

const _$FraudEventTypeEnumMap = {
  FraudEventType.GPS_SPOOF_VELOCITY: 'GPS_SPOOF_VELOCITY',
  FraudEventType.GPS_SPOOF_TELEPORT: 'GPS_SPOOF_TELEPORT',
  FraudEventType.GPS_SPOOF_MOCK_DETECTED: 'GPS_SPOOF_MOCK_DETECTED',
  FraudEventType.DUPLICATE_BANK_ACCOUNT: 'DUPLICATE_BANK_ACCOUNT',
  FraudEventType.DUPLICATE_IP_PATTERN: 'DUPLICATE_IP_PATTERN',
  FraudEventType.DUPLICATE_NAME_SIMILARITY: 'DUPLICATE_NAME_SIMILARITY',
  FraudEventType.SUSPICIOUS_REGISTRATION: 'SUSPICIOUS_REGISTRATION',
};

const _$FraudSeverityEnumMap = {
  FraudSeverity.LOW: 'LOW',
  FraudSeverity.MEDIUM: 'MEDIUM',
  FraudSeverity.HIGH: 'HIGH',
  FraudSeverity.CRITICAL: 'CRITICAL',
};
