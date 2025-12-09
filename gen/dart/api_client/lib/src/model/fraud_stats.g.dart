// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_stats.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudStatsCWProxy {
  FraudStats totalEvents(int totalEvents);

  FraudStats pendingEvents(int pendingEvents);

  FraudStats reviewingEvents(int reviewingEvents);

  FraudStats confirmedEvents(int confirmedEvents);

  FraudStats dismissedEvents(int dismissedEvents);

  FraudStats eventsBySeverity(FraudStatsEventsBySeverity eventsBySeverity);

  FraudStats eventsByType(Map<String, int> eventsByType);

  FraudStats highRiskUsers(int highRiskUsers);

  FraudStats recentTrend(List<FraudStatsRecentTrendInner> recentTrend);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudStats(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudStats(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudStats call({
    int totalEvents,
    int pendingEvents,
    int reviewingEvents,
    int confirmedEvents,
    int dismissedEvents,
    FraudStatsEventsBySeverity eventsBySeverity,
    Map<String, int> eventsByType,
    int highRiskUsers,
    List<FraudStatsRecentTrendInner> recentTrend,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudStats.copyWith(...)` or call `instanceOfFraudStats.copyWith.fieldName(value)` for a single field.
class _$FraudStatsCWProxyImpl implements _$FraudStatsCWProxy {
  const _$FraudStatsCWProxyImpl(this._value);

  final FraudStats _value;

  @override
  FraudStats totalEvents(int totalEvents) => call(totalEvents: totalEvents);

  @override
  FraudStats pendingEvents(int pendingEvents) =>
      call(pendingEvents: pendingEvents);

  @override
  FraudStats reviewingEvents(int reviewingEvents) =>
      call(reviewingEvents: reviewingEvents);

  @override
  FraudStats confirmedEvents(int confirmedEvents) =>
      call(confirmedEvents: confirmedEvents);

  @override
  FraudStats dismissedEvents(int dismissedEvents) =>
      call(dismissedEvents: dismissedEvents);

  @override
  FraudStats eventsBySeverity(FraudStatsEventsBySeverity eventsBySeverity) =>
      call(eventsBySeverity: eventsBySeverity);

  @override
  FraudStats eventsByType(Map<String, int> eventsByType) =>
      call(eventsByType: eventsByType);

  @override
  FraudStats highRiskUsers(int highRiskUsers) =>
      call(highRiskUsers: highRiskUsers);

  @override
  FraudStats recentTrend(List<FraudStatsRecentTrendInner> recentTrend) =>
      call(recentTrend: recentTrend);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudStats(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudStats(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudStats call({
    Object? totalEvents = const $CopyWithPlaceholder(),
    Object? pendingEvents = const $CopyWithPlaceholder(),
    Object? reviewingEvents = const $CopyWithPlaceholder(),
    Object? confirmedEvents = const $CopyWithPlaceholder(),
    Object? dismissedEvents = const $CopyWithPlaceholder(),
    Object? eventsBySeverity = const $CopyWithPlaceholder(),
    Object? eventsByType = const $CopyWithPlaceholder(),
    Object? highRiskUsers = const $CopyWithPlaceholder(),
    Object? recentTrend = const $CopyWithPlaceholder(),
  }) {
    return FraudStats(
      totalEvents:
          totalEvents == const $CopyWithPlaceholder() || totalEvents == null
          ? _value.totalEvents
          // ignore: cast_nullable_to_non_nullable
          : totalEvents as int,
      pendingEvents:
          pendingEvents == const $CopyWithPlaceholder() || pendingEvents == null
          ? _value.pendingEvents
          // ignore: cast_nullable_to_non_nullable
          : pendingEvents as int,
      reviewingEvents:
          reviewingEvents == const $CopyWithPlaceholder() ||
              reviewingEvents == null
          ? _value.reviewingEvents
          // ignore: cast_nullable_to_non_nullable
          : reviewingEvents as int,
      confirmedEvents:
          confirmedEvents == const $CopyWithPlaceholder() ||
              confirmedEvents == null
          ? _value.confirmedEvents
          // ignore: cast_nullable_to_non_nullable
          : confirmedEvents as int,
      dismissedEvents:
          dismissedEvents == const $CopyWithPlaceholder() ||
              dismissedEvents == null
          ? _value.dismissedEvents
          // ignore: cast_nullable_to_non_nullable
          : dismissedEvents as int,
      eventsBySeverity:
          eventsBySeverity == const $CopyWithPlaceholder() ||
              eventsBySeverity == null
          ? _value.eventsBySeverity
          // ignore: cast_nullable_to_non_nullable
          : eventsBySeverity as FraudStatsEventsBySeverity,
      eventsByType:
          eventsByType == const $CopyWithPlaceholder() || eventsByType == null
          ? _value.eventsByType
          // ignore: cast_nullable_to_non_nullable
          : eventsByType as Map<String, int>,
      highRiskUsers:
          highRiskUsers == const $CopyWithPlaceholder() || highRiskUsers == null
          ? _value.highRiskUsers
          // ignore: cast_nullable_to_non_nullable
          : highRiskUsers as int,
      recentTrend:
          recentTrend == const $CopyWithPlaceholder() || recentTrend == null
          ? _value.recentTrend
          // ignore: cast_nullable_to_non_nullable
          : recentTrend as List<FraudStatsRecentTrendInner>,
    );
  }
}

extension $FraudStatsCopyWith on FraudStats {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudStats.copyWith(...)` or `instanceOfFraudStats.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudStatsCWProxy get copyWith => _$FraudStatsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudStats _$FraudStatsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FraudStats', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'totalEvents',
      'pendingEvents',
      'reviewingEvents',
      'confirmedEvents',
      'dismissedEvents',
      'eventsBySeverity',
      'eventsByType',
      'highRiskUsers',
      'recentTrend',
    ],
  );
  final val = FraudStats(
    totalEvents: $checkedConvert('totalEvents', (v) => (v as num).toInt()),
    pendingEvents: $checkedConvert('pendingEvents', (v) => (v as num).toInt()),
    reviewingEvents: $checkedConvert(
      'reviewingEvents',
      (v) => (v as num).toInt(),
    ),
    confirmedEvents: $checkedConvert(
      'confirmedEvents',
      (v) => (v as num).toInt(),
    ),
    dismissedEvents: $checkedConvert(
      'dismissedEvents',
      (v) => (v as num).toInt(),
    ),
    eventsBySeverity: $checkedConvert(
      'eventsBySeverity',
      (v) => FraudStatsEventsBySeverity.fromJson(v as Map<String, dynamic>),
    ),
    eventsByType: $checkedConvert(
      'eventsByType',
      (v) => Map<String, int>.from(v as Map),
    ),
    highRiskUsers: $checkedConvert('highRiskUsers', (v) => (v as num).toInt()),
    recentTrend: $checkedConvert(
      'recentTrend',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                FraudStatsRecentTrendInner.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$FraudStatsToJson(FraudStats instance) =>
    <String, dynamic>{
      'totalEvents': instance.totalEvents,
      'pendingEvents': instance.pendingEvents,
      'reviewingEvents': instance.reviewingEvents,
      'confirmedEvents': instance.confirmedEvents,
      'dismissedEvents': instance.dismissedEvents,
      'eventsBySeverity': instance.eventsBySeverity.toJson(),
      'eventsByType': instance.eventsByType,
      'highRiskUsers': instance.highRiskUsers,
      'recentTrend': instance.recentTrend.map((e) => e.toJson()).toList(),
    };
