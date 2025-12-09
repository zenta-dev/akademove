// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_fraud_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateFraudEventCWProxy {
  UpdateFraudEvent status(FraudStatus? status);

  UpdateFraudEvent resolution(String? resolution);

  UpdateFraudEvent actionTaken(String? actionTaken);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateFraudEvent(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateFraudEvent(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateFraudEvent call({
    FraudStatus? status,
    String? resolution,
    String? actionTaken,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateFraudEvent.copyWith(...)` or call `instanceOfUpdateFraudEvent.copyWith.fieldName(value)` for a single field.
class _$UpdateFraudEventCWProxyImpl implements _$UpdateFraudEventCWProxy {
  const _$UpdateFraudEventCWProxyImpl(this._value);

  final UpdateFraudEvent _value;

  @override
  UpdateFraudEvent status(FraudStatus? status) => call(status: status);

  @override
  UpdateFraudEvent resolution(String? resolution) =>
      call(resolution: resolution);

  @override
  UpdateFraudEvent actionTaken(String? actionTaken) =>
      call(actionTaken: actionTaken);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateFraudEvent(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateFraudEvent(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateFraudEvent call({
    Object? status = const $CopyWithPlaceholder(),
    Object? resolution = const $CopyWithPlaceholder(),
    Object? actionTaken = const $CopyWithPlaceholder(),
  }) {
    return UpdateFraudEvent(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as FraudStatus?,
      resolution: resolution == const $CopyWithPlaceholder()
          ? _value.resolution
          // ignore: cast_nullable_to_non_nullable
          : resolution as String?,
      actionTaken: actionTaken == const $CopyWithPlaceholder()
          ? _value.actionTaken
          // ignore: cast_nullable_to_non_nullable
          : actionTaken as String?,
    );
  }
}

extension $UpdateFraudEventCopyWith on UpdateFraudEvent {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateFraudEvent.copyWith(...)` or `instanceOfUpdateFraudEvent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateFraudEventCWProxy get copyWith => _$UpdateFraudEventCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateFraudEvent _$UpdateFraudEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateFraudEvent', json, ($checkedConvert) {
      final val = UpdateFraudEvent(
        status: $checkedConvert(
          'status',
          (v) => $enumDecodeNullable(_$FraudStatusEnumMap, v),
        ),
        resolution: $checkedConvert('resolution', (v) => v as String?),
        actionTaken: $checkedConvert('actionTaken', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$UpdateFraudEventToJson(UpdateFraudEvent instance) =>
    <String, dynamic>{
      'status': ?_$FraudStatusEnumMap[instance.status],
      'resolution': ?instance.resolution,
      'actionTaken': ?instance.actionTaken,
    };

const _$FraudStatusEnumMap = {
  FraudStatus.PENDING: 'PENDING',
  FraudStatus.REVIEWING: 'REVIEWING',
  FraudStatus.CONFIRMED: 'CONFIRMED',
  FraudStatus.DISMISSED: 'DISMISSED',
};
