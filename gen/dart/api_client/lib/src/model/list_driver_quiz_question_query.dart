//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/pagination_mode.dart';
import 'package:api_client/src/model/driver_quiz_question_category.dart';
import 'package:api_client/src/model/pagination_order.dart';
import 'package:api_client/src/model/driver_quiz_question_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'list_driver_quiz_question_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ListDriverQuizQuestionQuery {
  /// Returns a new [ListDriverQuizQuestionQuery] instance.
  const ListDriverQuizQuestionQuery({
     this.cursor,
     this.limit,
     this.direction,
     this.page,
     this.query,
     this.sortBy,
     this.order = PaginationOrder.desc,
     this.mode = PaginationMode.offset,
     this.category,
     this.type,
     this.isActive,
  });
  @JsonKey(name: r'cursor', required: false, includeIfNull: false)
  final String? cursor;
  
  @JsonKey(name: r'limit', required: false, includeIfNull: false)
  final Object? limit;
  
  @JsonKey(name: r'direction', required: false, includeIfNull: false)
  final ListDriverQuizQuestionQueryDirectionEnum? direction;
  
  @JsonKey(name: r'page', required: false, includeIfNull: false)
  final Object? page;
  
  @JsonKey(name: r'query', required: false, includeIfNull: false)
  final String? query;
  
  @JsonKey(name: r'sortBy', required: false, includeIfNull: false)
  final ListDriverQuizQuestionQuerySortByEnum? sortBy;
  
  @JsonKey(defaultValue: PaginationOrder.desc,name: r'order', required: false, includeIfNull: false)
  final PaginationOrder? order;
  
  @JsonKey(defaultValue: PaginationMode.offset,name: r'mode', required: false, includeIfNull: false)
  final PaginationMode? mode;
  
  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final DriverQuizQuestionCategory? category;
  
  @JsonKey(name: r'type', required: false, includeIfNull: false)
  final DriverQuizQuestionType? type;
  
  @JsonKey(name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is ListDriverQuizQuestionQuery &&
    other.cursor == cursor &&
    other.limit == limit &&
    other.direction == direction &&
    other.page == page &&
    other.query == query &&
    other.sortBy == sortBy &&
    other.order == order &&
    other.mode == mode &&
    other.category == category &&
    other.type == type &&
    other.isActive == isActive;

  @override
  int get hashCode =>
      cursor.hashCode +
      (limit == null ? 0 : limit.hashCode) +
      direction.hashCode +
      (page == null ? 0 : page.hashCode) +
      query.hashCode +
      sortBy.hashCode +
      order.hashCode +
      mode.hashCode +
      category.hashCode +
      type.hashCode +
      isActive.hashCode;

  factory ListDriverQuizQuestionQuery.fromJson(Map<String, dynamic> json) => _$ListDriverQuizQuestionQueryFromJson(json);

  Map<String, dynamic> toJson() => _$ListDriverQuizQuestionQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum ListDriverQuizQuestionQueryDirectionEnum {
  @JsonValue(r'next')
  next(r'next'),
  @JsonValue(r'prev')
  prev(r'prev');
  
  const ListDriverQuizQuestionQueryDirectionEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

enum ListDriverQuizQuestionQuerySortByEnum {
  @JsonValue(r'key')
  key(r'key'),
  @JsonValue(r'name')
  name(r'name'),
  @JsonValue(r'description')
  description(r'description'),
  @JsonValue(r'updatedById')
  updatedById(r'updatedById'),
  @JsonValue(r'updatedAt')
  updatedAt(r'updatedAt'),
  @JsonValue(r'id')
  id(r'id'),
  @JsonValue(r'code')
  code(r'code'),
  @JsonValue(r'couponType')
  couponType(r'couponType'),
  @JsonValue(r'rules')
  rules(r'rules'),
  @JsonValue(r'discountAmount')
  discountAmount(r'discountAmount'),
  @JsonValue(r'discountPercentage')
  discountPercentage(r'discountPercentage'),
  @JsonValue(r'usageLimit')
  usageLimit(r'usageLimit'),
  @JsonValue(r'usedCount')
  usedCount(r'usedCount'),
  @JsonValue(r'periodStart')
  periodStart(r'periodStart'),
  @JsonValue(r'periodEnd')
  periodEnd(r'periodEnd'),
  @JsonValue(r'isActive')
  isActive(r'isActive'),
  @JsonValue(r'merchantId')
  merchantId(r'merchantId'),
  @JsonValue(r'eventName')
  eventName(r'eventName'),
  @JsonValue(r'eventDescription')
  eventDescription(r'eventDescription'),
  @JsonValue(r'createdById')
  createdById(r'createdById'),
  @JsonValue(r'createdAt')
  createdAt(r'createdAt'),
  @JsonValue(r'userId')
  userId(r'userId'),
  @JsonValue(r'studentId')
  studentId(r'studentId'),
  @JsonValue(r'licensePlate')
  licensePlate(r'licensePlate'),
  @JsonValue(r'status')
  status(r'status'),
  @JsonValue(r'quizStatus')
  quizStatus(r'quizStatus'),
  @JsonValue(r'quizAttemptId')
  quizAttemptId(r'quizAttemptId'),
  @JsonValue(r'quizScore')
  quizScore(r'quizScore'),
  @JsonValue(r'quizCompletedAt')
  quizCompletedAt(r'quizCompletedAt'),
  @JsonValue(r'rating')
  rating(r'rating'),
  @JsonValue(r'isTakingOrder')
  isTakingOrder(r'isTakingOrder'),
  @JsonValue(r'isOnline')
  isOnline(r'isOnline'),
  @JsonValue(r'currentLocation')
  currentLocation(r'currentLocation'),
  @JsonValue(r'lastLocationUpdate')
  lastLocationUpdate(r'lastLocationUpdate'),
  @JsonValue(r'cancellationCount')
  cancellationCount(r'cancellationCount'),
  @JsonValue(r'lastCancellationDate')
  lastCancellationDate(r'lastCancellationDate'),
  @JsonValue(r'studentCard')
  studentCard(r'studentCard'),
  @JsonValue(r'driverLicense')
  driverLicense(r'driverLicense'),
  @JsonValue(r'vehicleCertificate')
  vehicleCertificate(r'vehicleCertificate'),
  @JsonValue(r'bank')
  bank(r'bank'),
  @JsonValue(r'driverId')
  driverId(r'driverId'),
  @JsonValue(r'dayOfWeek')
  dayOfWeek(r'dayOfWeek'),
  @JsonValue(r'startTime')
  startTime(r'startTime'),
  @JsonValue(r'endTime')
  endTime(r'endTime'),
  @JsonValue(r'isRecurring')
  isRecurring(r'isRecurring'),
  @JsonValue(r'specificDate')
  specificDate(r'specificDate'),
  @JsonValue(r'email')
  email(r'email'),
  @JsonValue(r'phone')
  phone(r'phone'),
  @JsonValue(r'address')
  address(r'address'),
  @JsonValue(r'location')
  location(r'location'),
  @JsonValue(r'isTakingOrders')
  isTakingOrders(r'isTakingOrders'),
  @JsonValue(r'operatingStatus')
  operatingStatus(r'operatingStatus'),
  @JsonValue(r'document')
  document(r'document'),
  @JsonValue(r'image')
  image(r'image'),
  @JsonValue(r'category')
  category(r'category'),
  @JsonValue(r'categories')
  categories(r'categories'),
  @JsonValue(r'price')
  price(r'price'),
  @JsonValue(r'stock')
  stock(r'stock'),
  @JsonValue(r'type')
  type(r'type'),
  @JsonValue(r'pickupLocation')
  pickupLocation(r'pickupLocation'),
  @JsonValue(r'dropoffLocation')
  dropoffLocation(r'dropoffLocation'),
  @JsonValue(r'distanceKm')
  distanceKm(r'distanceKm'),
  @JsonValue(r'basePrice')
  basePrice(r'basePrice'),
  @JsonValue(r'tip')
  tip(r'tip'),
  @JsonValue(r'totalPrice')
  totalPrice(r'totalPrice'),
  @JsonValue(r'platformCommission')
  platformCommission(r'platformCommission'),
  @JsonValue(r'driverEarning')
  driverEarning(r'driverEarning'),
  @JsonValue(r'merchantCommission')
  merchantCommission(r'merchantCommission'),
  @JsonValue(r'couponId')
  couponId(r'couponId'),
  @JsonValue(r'couponCode')
  couponCode(r'couponCode'),
  @JsonValue(r'note')
  note(r'note'),
  @JsonValue(r'requestedAt')
  requestedAt(r'requestedAt'),
  @JsonValue(r'acceptedAt')
  acceptedAt(r'acceptedAt'),
  @JsonValue(r'preparedAt')
  preparedAt(r'preparedAt'),
  @JsonValue(r'readyAt')
  readyAt(r'readyAt'),
  @JsonValue(r'arrivedAt')
  arrivedAt(r'arrivedAt'),
  @JsonValue(r'cancelReason')
  cancelReason(r'cancelReason'),
  @JsonValue(r'gender')
  gender(r'gender'),
  @JsonValue(r'genderPreference')
  genderPreference(r'genderPreference'),
  @JsonValue(r'scheduledAt')
  scheduledAt(r'scheduledAt'),
  @JsonValue(r'scheduledMatchingAt')
  scheduledMatchingAt(r'scheduledMatchingAt'),
  @JsonValue(r'proofOfDeliveryUrl')
  proofOfDeliveryUrl(r'proofOfDeliveryUrl'),
  @JsonValue(r'deliveryOtp')
  deliveryOtp(r'deliveryOtp'),
  @JsonValue(r'otpVerifiedAt')
  otpVerifiedAt(r'otpVerifiedAt'),
  @JsonValue(r'transactionId')
  transactionId(r'transactionId'),
  @JsonValue(r'provider')
  provider(r'provider'),
  @JsonValue(r'method')
  method(r'method'),
  @JsonValue(r'bankProvider')
  bankProvider(r'bankProvider'),
  @JsonValue(r'amount')
  amount(r'amount'),
  @JsonValue(r'externalId')
  externalId(r'externalId'),
  @JsonValue(r'paymentUrl')
  paymentUrl(r'paymentUrl'),
  @JsonValue(r'va_number')
  vaNumber(r'va_number'),
  @JsonValue(r'metadata')
  metadata(r'metadata'),
  @JsonValue(r'expiresAt')
  expiresAt(r'expiresAt'),
  @JsonValue(r'payload')
  payload(r'payload'),
  @JsonValue(r'response')
  response(r'response'),
  @JsonValue(r'orderId')
  orderId(r'orderId'),
  @JsonValue(r'reporterId')
  reporterId(r'reporterId'),
  @JsonValue(r'targetUserId')
  targetUserId(r'targetUserId'),
  @JsonValue(r'evidenceUrl')
  evidenceUrl(r'evidenceUrl'),
  @JsonValue(r'handledById')
  handledById(r'handledById'),
  @JsonValue(r'resolution')
  resolution(r'resolution'),
  @JsonValue(r'reportedAt')
  reportedAt(r'reportedAt'),
  @JsonValue(r'resolvedAt')
  resolvedAt(r'resolvedAt'),
  @JsonValue(r'fromUserId')
  fromUserId(r'fromUserId'),
  @JsonValue(r'toUserId')
  toUserId(r'toUserId'),
  @JsonValue(r'score')
  score(r'score'),
  @JsonValue(r'comment')
  comment(r'comment'),
  @JsonValue(r'walletId')
  walletId(r'walletId'),
  @JsonValue(r'balanceBefore')
  balanceBefore(r'balanceBefore'),
  @JsonValue(r'balanceAfter')
  balanceAfter(r'balanceAfter'),
  @JsonValue(r'referenceId')
  referenceId(r'referenceId'),
  @JsonValue(r'emailVerified')
  emailVerified(r'emailVerified'),
  @JsonValue(r'role')
  role(r'role'),
  @JsonValue(r'banned')
  banned(r'banned'),
  @JsonValue(r'banReason')
  banReason(r'banReason'),
  @JsonValue(r'banExpires')
  banExpires(r'banExpires'),
  @JsonValue(r'balance')
  balance(r'balance'),
  @JsonValue(r'currency')
  currency(r'currency');
  
  const ListDriverQuizQuestionQuerySortByEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

