// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_driver_quiz_question_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ListDriverQuizQuestionQueryCWProxy {
  ListDriverQuizQuestionQuery cursor(String? cursor);

  ListDriverQuizQuestionQuery limit(Object? limit);

  ListDriverQuizQuestionQuery direction(
    ListDriverQuizQuestionQueryDirectionEnum? direction,
  );

  ListDriverQuizQuestionQuery page(Object? page);

  ListDriverQuizQuestionQuery query(String? query);

  ListDriverQuizQuestionQuery sortBy(
    ListDriverQuizQuestionQuerySortByEnum? sortBy,
  );

  ListDriverQuizQuestionQuery order(PaginationOrder? order);

  ListDriverQuizQuestionQuery mode(PaginationMode? mode);

  ListDriverQuizQuestionQuery category(DriverQuizQuestionCategory? category);

  ListDriverQuizQuestionQuery type(DriverQuizQuestionType? type);

  ListDriverQuizQuestionQuery isActive(bool? isActive);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ListDriverQuizQuestionQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ListDriverQuizQuestionQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  ListDriverQuizQuestionQuery call({
    String? cursor,
    Object? limit,
    ListDriverQuizQuestionQueryDirectionEnum? direction,
    Object? page,
    String? query,
    ListDriverQuizQuestionQuerySortByEnum? sortBy,
    PaginationOrder? order,
    PaginationMode? mode,
    DriverQuizQuestionCategory? category,
    DriverQuizQuestionType? type,
    bool? isActive,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfListDriverQuizQuestionQuery.copyWith(...)` or call `instanceOfListDriverQuizQuestionQuery.copyWith.fieldName(value)` for a single field.
class _$ListDriverQuizQuestionQueryCWProxyImpl
    implements _$ListDriverQuizQuestionQueryCWProxy {
  const _$ListDriverQuizQuestionQueryCWProxyImpl(this._value);

  final ListDriverQuizQuestionQuery _value;

  @override
  ListDriverQuizQuestionQuery cursor(String? cursor) => call(cursor: cursor);

  @override
  ListDriverQuizQuestionQuery limit(Object? limit) => call(limit: limit);

  @override
  ListDriverQuizQuestionQuery direction(
    ListDriverQuizQuestionQueryDirectionEnum? direction,
  ) => call(direction: direction);

  @override
  ListDriverQuizQuestionQuery page(Object? page) => call(page: page);

  @override
  ListDriverQuizQuestionQuery query(String? query) => call(query: query);

  @override
  ListDriverQuizQuestionQuery sortBy(
    ListDriverQuizQuestionQuerySortByEnum? sortBy,
  ) => call(sortBy: sortBy);

  @override
  ListDriverQuizQuestionQuery order(PaginationOrder? order) =>
      call(order: order);

  @override
  ListDriverQuizQuestionQuery mode(PaginationMode? mode) => call(mode: mode);

  @override
  ListDriverQuizQuestionQuery category(DriverQuizQuestionCategory? category) =>
      call(category: category);

  @override
  ListDriverQuizQuestionQuery type(DriverQuizQuestionType? type) =>
      call(type: type);

  @override
  ListDriverQuizQuestionQuery isActive(bool? isActive) =>
      call(isActive: isActive);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ListDriverQuizQuestionQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ListDriverQuizQuestionQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  ListDriverQuizQuestionQuery call({
    Object? cursor = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
    Object? direction = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? sortBy = const $CopyWithPlaceholder(),
    Object? order = const $CopyWithPlaceholder(),
    Object? mode = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return ListDriverQuizQuestionQuery(
      cursor: cursor == const $CopyWithPlaceholder()
          ? _value.cursor
          // ignore: cast_nullable_to_non_nullable
          : cursor as String?,
      limit: limit == const $CopyWithPlaceholder()
          ? _value.limit
          // ignore: cast_nullable_to_non_nullable
          : limit as Object?,
      direction: direction == const $CopyWithPlaceholder()
          ? _value.direction
          // ignore: cast_nullable_to_non_nullable
          : direction as ListDriverQuizQuestionQueryDirectionEnum?,
      page: page == const $CopyWithPlaceholder()
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as Object?,
      query: query == const $CopyWithPlaceholder()
          ? _value.query
          // ignore: cast_nullable_to_non_nullable
          : query as String?,
      sortBy: sortBy == const $CopyWithPlaceholder()
          ? _value.sortBy
          // ignore: cast_nullable_to_non_nullable
          : sortBy as ListDriverQuizQuestionQuerySortByEnum?,
      order: order == const $CopyWithPlaceholder()
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as PaginationOrder?,
      mode: mode == const $CopyWithPlaceholder()
          ? _value.mode
          // ignore: cast_nullable_to_non_nullable
          : mode as PaginationMode?,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as DriverQuizQuestionCategory?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as DriverQuizQuestionType?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
    );
  }
}

extension $ListDriverQuizQuestionQueryCopyWith on ListDriverQuizQuestionQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfListDriverQuizQuestionQuery.copyWith(...)` or `instanceOfListDriverQuizQuestionQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ListDriverQuizQuestionQueryCWProxy get copyWith =>
      _$ListDriverQuizQuestionQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListDriverQuizQuestionQuery _$ListDriverQuizQuestionQueryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ListDriverQuizQuestionQuery', json, ($checkedConvert) {
  final val = ListDriverQuizQuestionQuery(
    cursor: $checkedConvert('cursor', (v) => v as String?),
    limit: $checkedConvert('limit', (v) => v),
    direction: $checkedConvert(
      'direction',
      (v) => $enumDecodeNullable(
        _$ListDriverQuizQuestionQueryDirectionEnumEnumMap,
        v,
      ),
    ),
    page: $checkedConvert('page', (v) => v),
    query: $checkedConvert('query', (v) => v as String?),
    sortBy: $checkedConvert(
      'sortBy',
      (v) => $enumDecodeNullable(
        _$ListDriverQuizQuestionQuerySortByEnumEnumMap,
        v,
      ),
    ),
    order: $checkedConvert(
      'order',
      (v) =>
          $enumDecodeNullable(_$PaginationOrderEnumMap, v) ??
          PaginationOrder.desc,
    ),
    mode: $checkedConvert(
      'mode',
      (v) =>
          $enumDecodeNullable(_$PaginationModeEnumMap, v) ??
          PaginationMode.offset,
    ),
    category: $checkedConvert(
      'category',
      (v) => $enumDecodeNullable(_$DriverQuizQuestionCategoryEnumMap, v),
    ),
    type: $checkedConvert(
      'type',
      (v) => $enumDecodeNullable(_$DriverQuizQuestionTypeEnumMap, v),
    ),
    isActive: $checkedConvert('isActive', (v) => v as bool?),
  );
  return val;
});

Map<String, dynamic> _$ListDriverQuizQuestionQueryToJson(
  ListDriverQuizQuestionQuery instance,
) => <String, dynamic>{
  'cursor': ?instance.cursor,
  'limit': ?instance.limit,
  'direction':
      ?_$ListDriverQuizQuestionQueryDirectionEnumEnumMap[instance.direction],
  'page': ?instance.page,
  'query': ?instance.query,
  'sortBy': ?_$ListDriverQuizQuestionQuerySortByEnumEnumMap[instance.sortBy],
  'order': ?_$PaginationOrderEnumMap[instance.order],
  'mode': ?_$PaginationModeEnumMap[instance.mode],
  'category': ?_$DriverQuizQuestionCategoryEnumMap[instance.category],
  'type': ?_$DriverQuizQuestionTypeEnumMap[instance.type],
  'isActive': ?instance.isActive,
};

const _$ListDriverQuizQuestionQueryDirectionEnumEnumMap = {
  ListDriverQuizQuestionQueryDirectionEnum.next: 'next',
  ListDriverQuizQuestionQueryDirectionEnum.prev: 'prev',
};

const _$ListDriverQuizQuestionQuerySortByEnumEnumMap = {
  ListDriverQuizQuestionQuerySortByEnum.key: 'key',
  ListDriverQuizQuestionQuerySortByEnum.name: 'name',
  ListDriverQuizQuestionQuerySortByEnum.description: 'description',
  ListDriverQuizQuestionQuerySortByEnum.updatedById: 'updatedById',
  ListDriverQuizQuestionQuerySortByEnum.updatedAt: 'updatedAt',
  ListDriverQuizQuestionQuerySortByEnum.id: 'id',
  ListDriverQuizQuestionQuerySortByEnum.code: 'code',
  ListDriverQuizQuestionQuerySortByEnum.couponType: 'couponType',
  ListDriverQuizQuestionQuerySortByEnum.rules: 'rules',
  ListDriverQuizQuestionQuerySortByEnum.discountAmount: 'discountAmount',
  ListDriverQuizQuestionQuerySortByEnum.discountPercentage:
      'discountPercentage',
  ListDriverQuizQuestionQuerySortByEnum.usageLimit: 'usageLimit',
  ListDriverQuizQuestionQuerySortByEnum.usedCount: 'usedCount',
  ListDriverQuizQuestionQuerySortByEnum.periodStart: 'periodStart',
  ListDriverQuizQuestionQuerySortByEnum.periodEnd: 'periodEnd',
  ListDriverQuizQuestionQuerySortByEnum.isActive: 'isActive',
  ListDriverQuizQuestionQuerySortByEnum.merchantId: 'merchantId',
  ListDriverQuizQuestionQuerySortByEnum.eventName: 'eventName',
  ListDriverQuizQuestionQuerySortByEnum.eventDescription: 'eventDescription',
  ListDriverQuizQuestionQuerySortByEnum.createdById: 'createdById',
  ListDriverQuizQuestionQuerySortByEnum.createdAt: 'createdAt',
  ListDriverQuizQuestionQuerySortByEnum.userId: 'userId',
  ListDriverQuizQuestionQuerySortByEnum.studentId: 'studentId',
  ListDriverQuizQuestionQuerySortByEnum.licensePlate: 'licensePlate',
  ListDriverQuizQuestionQuerySortByEnum.status: 'status',
  ListDriverQuizQuestionQuerySortByEnum.quizStatus: 'quizStatus',
  ListDriverQuizQuestionQuerySortByEnum.quizAttemptId: 'quizAttemptId',
  ListDriverQuizQuestionQuerySortByEnum.quizScore: 'quizScore',
  ListDriverQuizQuestionQuerySortByEnum.quizCompletedAt: 'quizCompletedAt',
  ListDriverQuizQuestionQuerySortByEnum.rating: 'rating',
  ListDriverQuizQuestionQuerySortByEnum.isTakingOrder: 'isTakingOrder',
  ListDriverQuizQuestionQuerySortByEnum.isOnline: 'isOnline',
  ListDriverQuizQuestionQuerySortByEnum.currentLocation: 'currentLocation',
  ListDriverQuizQuestionQuerySortByEnum.lastLocationUpdate:
      'lastLocationUpdate',
  ListDriverQuizQuestionQuerySortByEnum.cancellationCount: 'cancellationCount',
  ListDriverQuizQuestionQuerySortByEnum.lastCancellationDate:
      'lastCancellationDate',
  ListDriverQuizQuestionQuerySortByEnum.studentCard: 'studentCard',
  ListDriverQuizQuestionQuerySortByEnum.driverLicense: 'driverLicense',
  ListDriverQuizQuestionQuerySortByEnum.vehicleCertificate:
      'vehicleCertificate',
  ListDriverQuizQuestionQuerySortByEnum.bank: 'bank',
  ListDriverQuizQuestionQuerySortByEnum.driverId: 'driverId',
  ListDriverQuizQuestionQuerySortByEnum.dayOfWeek: 'dayOfWeek',
  ListDriverQuizQuestionQuerySortByEnum.startTime: 'startTime',
  ListDriverQuizQuestionQuerySortByEnum.endTime: 'endTime',
  ListDriverQuizQuestionQuerySortByEnum.isRecurring: 'isRecurring',
  ListDriverQuizQuestionQuerySortByEnum.specificDate: 'specificDate',
  ListDriverQuizQuestionQuerySortByEnum.email: 'email',
  ListDriverQuizQuestionQuerySortByEnum.phone: 'phone',
  ListDriverQuizQuestionQuerySortByEnum.address: 'address',
  ListDriverQuizQuestionQuerySortByEnum.location: 'location',
  ListDriverQuizQuestionQuerySortByEnum.isTakingOrders: 'isTakingOrders',
  ListDriverQuizQuestionQuerySortByEnum.operatingStatus: 'operatingStatus',
  ListDriverQuizQuestionQuerySortByEnum.document: 'document',
  ListDriverQuizQuestionQuerySortByEnum.image: 'image',
  ListDriverQuizQuestionQuerySortByEnum.category: 'category',
  ListDriverQuizQuestionQuerySortByEnum.categories: 'categories',
  ListDriverQuizQuestionQuerySortByEnum.price: 'price',
  ListDriverQuizQuestionQuerySortByEnum.stock: 'stock',
  ListDriverQuizQuestionQuerySortByEnum.type: 'type',
  ListDriverQuizQuestionQuerySortByEnum.pickupLocation: 'pickupLocation',
  ListDriverQuizQuestionQuerySortByEnum.dropoffLocation: 'dropoffLocation',
  ListDriverQuizQuestionQuerySortByEnum.distanceKm: 'distanceKm',
  ListDriverQuizQuestionQuerySortByEnum.basePrice: 'basePrice',
  ListDriverQuizQuestionQuerySortByEnum.tip: 'tip',
  ListDriverQuizQuestionQuerySortByEnum.totalPrice: 'totalPrice',
  ListDriverQuizQuestionQuerySortByEnum.platformCommission:
      'platformCommission',
  ListDriverQuizQuestionQuerySortByEnum.driverEarning: 'driverEarning',
  ListDriverQuizQuestionQuerySortByEnum.merchantCommission:
      'merchantCommission',
  ListDriverQuizQuestionQuerySortByEnum.couponId: 'couponId',
  ListDriverQuizQuestionQuerySortByEnum.couponCode: 'couponCode',
  ListDriverQuizQuestionQuerySortByEnum.note: 'note',
  ListDriverQuizQuestionQuerySortByEnum.requestedAt: 'requestedAt',
  ListDriverQuizQuestionQuerySortByEnum.acceptedAt: 'acceptedAt',
  ListDriverQuizQuestionQuerySortByEnum.preparedAt: 'preparedAt',
  ListDriverQuizQuestionQuerySortByEnum.readyAt: 'readyAt',
  ListDriverQuizQuestionQuerySortByEnum.arrivedAt: 'arrivedAt',
  ListDriverQuizQuestionQuerySortByEnum.cancelReason: 'cancelReason',
  ListDriverQuizQuestionQuerySortByEnum.gender: 'gender',
  ListDriverQuizQuestionQuerySortByEnum.genderPreference: 'genderPreference',
  ListDriverQuizQuestionQuerySortByEnum.scheduledAt: 'scheduledAt',
  ListDriverQuizQuestionQuerySortByEnum.scheduledMatchingAt:
      'scheduledMatchingAt',
  ListDriverQuizQuestionQuerySortByEnum.proofOfDeliveryUrl:
      'proofOfDeliveryUrl',
  ListDriverQuizQuestionQuerySortByEnum.deliveryOtp: 'deliveryOtp',
  ListDriverQuizQuestionQuerySortByEnum.otpVerifiedAt: 'otpVerifiedAt',
  ListDriverQuizQuestionQuerySortByEnum.transactionId: 'transactionId',
  ListDriverQuizQuestionQuerySortByEnum.provider: 'provider',
  ListDriverQuizQuestionQuerySortByEnum.method: 'method',
  ListDriverQuizQuestionQuerySortByEnum.bankProvider: 'bankProvider',
  ListDriverQuizQuestionQuerySortByEnum.amount: 'amount',
  ListDriverQuizQuestionQuerySortByEnum.externalId: 'externalId',
  ListDriverQuizQuestionQuerySortByEnum.paymentUrl: 'paymentUrl',
  ListDriverQuizQuestionQuerySortByEnum.vaNumber: 'va_number',
  ListDriverQuizQuestionQuerySortByEnum.metadata: 'metadata',
  ListDriverQuizQuestionQuerySortByEnum.expiresAt: 'expiresAt',
  ListDriverQuizQuestionQuerySortByEnum.payload: 'payload',
  ListDriverQuizQuestionQuerySortByEnum.response: 'response',
  ListDriverQuizQuestionQuerySortByEnum.orderId: 'orderId',
  ListDriverQuizQuestionQuerySortByEnum.reporterId: 'reporterId',
  ListDriverQuizQuestionQuerySortByEnum.targetUserId: 'targetUserId',
  ListDriverQuizQuestionQuerySortByEnum.evidenceUrl: 'evidenceUrl',
  ListDriverQuizQuestionQuerySortByEnum.handledById: 'handledById',
  ListDriverQuizQuestionQuerySortByEnum.resolution: 'resolution',
  ListDriverQuizQuestionQuerySortByEnum.reportedAt: 'reportedAt',
  ListDriverQuizQuestionQuerySortByEnum.resolvedAt: 'resolvedAt',
  ListDriverQuizQuestionQuerySortByEnum.fromUserId: 'fromUserId',
  ListDriverQuizQuestionQuerySortByEnum.toUserId: 'toUserId',
  ListDriverQuizQuestionQuerySortByEnum.score: 'score',
  ListDriverQuizQuestionQuerySortByEnum.comment: 'comment',
  ListDriverQuizQuestionQuerySortByEnum.walletId: 'walletId',
  ListDriverQuizQuestionQuerySortByEnum.balanceBefore: 'balanceBefore',
  ListDriverQuizQuestionQuerySortByEnum.balanceAfter: 'balanceAfter',
  ListDriverQuizQuestionQuerySortByEnum.referenceId: 'referenceId',
  ListDriverQuizQuestionQuerySortByEnum.emailVerified: 'emailVerified',
  ListDriverQuizQuestionQuerySortByEnum.role: 'role',
  ListDriverQuizQuestionQuerySortByEnum.banned: 'banned',
  ListDriverQuizQuestionQuerySortByEnum.banReason: 'banReason',
  ListDriverQuizQuestionQuerySortByEnum.banExpires: 'banExpires',
  ListDriverQuizQuestionQuerySortByEnum.balance: 'balance',
  ListDriverQuizQuestionQuerySortByEnum.currency: 'currency',
};

const _$PaginationOrderEnumMap = {
  PaginationOrder.asc: 'asc',
  PaginationOrder.desc: 'desc',
};

const _$PaginationModeEnumMap = {
  PaginationMode.offset: 'offset',
  PaginationMode.cursor: 'cursor',
};

const _$DriverQuizQuestionCategoryEnumMap = {
  DriverQuizQuestionCategory.SAFETY: 'SAFETY',
  DriverQuizQuestionCategory.NAVIGATION: 'NAVIGATION',
  DriverQuizQuestionCategory.CUSTOMER_SERVICE: 'CUSTOMER_SERVICE',
  DriverQuizQuestionCategory.PLATFORM_RULES: 'PLATFORM_RULES',
  DriverQuizQuestionCategory.EMERGENCY_PROCEDURES: 'EMERGENCY_PROCEDURES',
  DriverQuizQuestionCategory.VEHICLE_MAINTENANCE: 'VEHICLE_MAINTENANCE',
  DriverQuizQuestionCategory.GENERAL: 'GENERAL',
};

const _$DriverQuizQuestionTypeEnumMap = {
  DriverQuizQuestionType.MULTIPLE_CHOICE: 'MULTIPLE_CHOICE',
  DriverQuizQuestionType.TRUE_FALSE: 'TRUE_FALSE',
};
