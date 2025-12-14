//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum OrderKey {
  @JsonValue(r'id')
  id(r'id'),
  @JsonValue(r'userId')
  userId(r'userId'),
  @JsonValue(r'driverId')
  driverId(r'driverId'),
  @JsonValue(r'completedDriverId')
  completedDriverId(r'completedDriverId'),
  @JsonValue(r'merchantId')
  merchantId(r'merchantId'),
  @JsonValue(r'type')
  type(r'type'),
  @JsonValue(r'status')
  status(r'status'),
  @JsonValue(r'pickupLocation')
  pickupLocation(r'pickupLocation'),
  @JsonValue(r'dropoffLocation')
  dropoffLocation(r'dropoffLocation'),
  @JsonValue(r'pickupAddress')
  pickupAddress(r'pickupAddress'),
  @JsonValue(r'dropoffAddress')
  dropoffAddress(r'dropoffAddress'),
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
  @JsonValue(r'discountAmount')
  discountAmount(r'discountAmount'),
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
  @JsonValue(r'createdAt')
  createdAt(r'createdAt'),
  @JsonValue(r'updatedAt')
  updatedAt(r'updatedAt'),
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
  @JsonValue(r'deliveryItemPhotoUrl')
  deliveryItemPhotoUrl(r'deliveryItemPhotoUrl'),
  @JsonValue(r'deliveryItemType')
  deliveryItemType(r'deliveryItemType'),
  @JsonValue(r'attachmentUrl')
  attachmentUrl(r'attachmentUrl');

  const OrderKey(this.value);

  final String value;

  @override
  String toString() => value;
}
