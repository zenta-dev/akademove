// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_event_list_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudEventListQueryCWProxy {
  FraudEventListQuery page(Object? page);

  FraudEventListQuery limit(Object? limit);

  FraudEventListQuery status(FraudStatus? status);

  FraudEventListQuery severity(FraudSeverity? severity);

  FraudEventListQuery eventType(FraudEventType? eventType);

  FraudEventListQuery userId(String? userId);

  FraudEventListQuery driverId(String? driverId);

  FraudEventListQuery startDate(DateTime? startDate);

  FraudEventListQuery endDate(DateTime? endDate);

  FraudEventListQuery sortBy(FraudEventListQuerySortByEnum? sortBy);

  FraudEventListQuery order(FraudEventListQueryOrderEnum? order);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudEventListQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudEventListQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudEventListQuery call({
    Object? page,
    Object? limit,
    FraudStatus? status,
    FraudSeverity? severity,
    FraudEventType? eventType,
    String? userId,
    String? driverId,
    DateTime? startDate,
    DateTime? endDate,
    FraudEventListQuerySortByEnum? sortBy,
    FraudEventListQueryOrderEnum? order,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudEventListQuery.copyWith(...)` or call `instanceOfFraudEventListQuery.copyWith.fieldName(value)` for a single field.
class _$FraudEventListQueryCWProxyImpl implements _$FraudEventListQueryCWProxy {
  const _$FraudEventListQueryCWProxyImpl(this._value);

  final FraudEventListQuery _value;

  @override
  FraudEventListQuery page(Object? page) => call(page: page);

  @override
  FraudEventListQuery limit(Object? limit) => call(limit: limit);

  @override
  FraudEventListQuery status(FraudStatus? status) => call(status: status);

  @override
  FraudEventListQuery severity(FraudSeverity? severity) =>
      call(severity: severity);

  @override
  FraudEventListQuery eventType(FraudEventType? eventType) =>
      call(eventType: eventType);

  @override
  FraudEventListQuery userId(String? userId) => call(userId: userId);

  @override
  FraudEventListQuery driverId(String? driverId) => call(driverId: driverId);

  @override
  FraudEventListQuery startDate(DateTime? startDate) =>
      call(startDate: startDate);

  @override
  FraudEventListQuery endDate(DateTime? endDate) => call(endDate: endDate);

  @override
  FraudEventListQuery sortBy(FraudEventListQuerySortByEnum? sortBy) =>
      call(sortBy: sortBy);

  @override
  FraudEventListQuery order(FraudEventListQueryOrderEnum? order) =>
      call(order: order);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudEventListQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudEventListQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudEventListQuery call({
    Object? page = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? severity = const $CopyWithPlaceholder(),
    Object? eventType = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? driverId = const $CopyWithPlaceholder(),
    Object? startDate = const $CopyWithPlaceholder(),
    Object? endDate = const $CopyWithPlaceholder(),
    Object? sortBy = const $CopyWithPlaceholder(),
    Object? order = const $CopyWithPlaceholder(),
  }) {
    return FraudEventListQuery(
      page: page == const $CopyWithPlaceholder()
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as Object?,
      limit: limit == const $CopyWithPlaceholder()
          ? _value.limit
          // ignore: cast_nullable_to_non_nullable
          : limit as Object?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as FraudStatus?,
      severity: severity == const $CopyWithPlaceholder()
          ? _value.severity
          // ignore: cast_nullable_to_non_nullable
          : severity as FraudSeverity?,
      eventType: eventType == const $CopyWithPlaceholder()
          ? _value.eventType
          // ignore: cast_nullable_to_non_nullable
          : eventType as FraudEventType?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      driverId: driverId == const $CopyWithPlaceholder()
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String?,
      startDate: startDate == const $CopyWithPlaceholder()
          ? _value.startDate
          // ignore: cast_nullable_to_non_nullable
          : startDate as DateTime?,
      endDate: endDate == const $CopyWithPlaceholder()
          ? _value.endDate
          // ignore: cast_nullable_to_non_nullable
          : endDate as DateTime?,
      sortBy: sortBy == const $CopyWithPlaceholder()
          ? _value.sortBy
          // ignore: cast_nullable_to_non_nullable
          : sortBy as FraudEventListQuerySortByEnum?,
      order: order == const $CopyWithPlaceholder()
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as FraudEventListQueryOrderEnum?,
    );
  }
}

extension $FraudEventListQueryCopyWith on FraudEventListQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudEventListQuery.copyWith(...)` or `instanceOfFraudEventListQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudEventListQueryCWProxy get copyWith =>
      _$FraudEventListQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudEventListQuery _$FraudEventListQueryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FraudEventListQuery', json, ($checkedConvert) {
      final val = FraudEventListQuery(
        page: $checkedConvert('page', (v) => v),
        limit: $checkedConvert('limit', (v) => v),
        status: $checkedConvert(
          'status',
          (v) => $enumDecodeNullable(_$FraudStatusEnumMap, v),
        ),
        severity: $checkedConvert(
          'severity',
          (v) => $enumDecodeNullable(_$FraudSeverityEnumMap, v),
        ),
        eventType: $checkedConvert(
          'eventType',
          (v) => $enumDecodeNullable(_$FraudEventTypeEnumMap, v),
        ),
        userId: $checkedConvert('userId', (v) => v as String?),
        driverId: $checkedConvert('driverId', (v) => v as String?),
        startDate: $checkedConvert(
          'startDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        endDate: $checkedConvert(
          'endDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        sortBy: $checkedConvert(
          'sortBy',
          (v) => $enumDecodeNullable(_$FraudEventListQuerySortByEnumEnumMap, v),
        ),
        order: $checkedConvert(
          'order',
          (v) => $enumDecodeNullable(_$FraudEventListQueryOrderEnumEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$FraudEventListQueryToJson(
  FraudEventListQuery instance,
) => <String, dynamic>{
  'page': ?instance.page,
  'limit': ?instance.limit,
  'status': ?_$FraudStatusEnumMap[instance.status],
  'severity': ?_$FraudSeverityEnumMap[instance.severity],
  'eventType': ?_$FraudEventTypeEnumMap[instance.eventType],
  'userId': ?instance.userId,
  'driverId': ?instance.driverId,
  'startDate': ?instance.startDate?.toIso8601String(),
  'endDate': ?instance.endDate?.toIso8601String(),
  'sortBy': ?_$FraudEventListQuerySortByEnumEnumMap[instance.sortBy],
  'order': ?_$FraudEventListQueryOrderEnumEnumMap[instance.order],
};

const _$FraudStatusEnumMap = {
  FraudStatus.PENDING: 'PENDING',
  FraudStatus.REVIEWING: 'REVIEWING',
  FraudStatus.CONFIRMED: 'CONFIRMED',
  FraudStatus.DISMISSED: 'DISMISSED',
};

const _$FraudSeverityEnumMap = {
  FraudSeverity.LOW: 'LOW',
  FraudSeverity.MEDIUM: 'MEDIUM',
  FraudSeverity.HIGH: 'HIGH',
  FraudSeverity.CRITICAL: 'CRITICAL',
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

const _$FraudEventListQuerySortByEnumEnumMap = {
  FraudEventListQuerySortByEnum.detectedAt: 'detectedAt',
  FraudEventListQuerySortByEnum.severity: 'severity',
  FraudEventListQuerySortByEnum.score: 'score',
};

const _$FraudEventListQueryOrderEnumEnumMap = {
  FraudEventListQueryOrderEnum.asc: 'asc',
  FraudEventListQueryOrderEnum.desc: 'desc',
};
