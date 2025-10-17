// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverCWProxy {
  Driver id(String id);

  Driver userId(String userId);

  Driver studentId(num studentId);

  Driver licensePlate(String licensePlate);

  Driver status(DriverStatusEnum status);

  Driver rating(num rating);

  Driver isOnline(bool isOnline);

  Driver currentLocation(Location? currentLocation);

  Driver lastLocationUpdate(DateTime? lastLocationUpdate);

  Driver createdAt(DateTime createdAt);

  Driver studentCard(String studentCard);

  Driver driverLicense(String driverLicense);

  Driver vehicleCertificate(String vehicleCertificate);

  Driver bank(Bank bank);

  Driver user(OrderCreateRequestUser? user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Driver(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Driver(...).copyWith(id: 12, name: "My name")
  /// ````
  Driver call({
    String id,
    String userId,
    num studentId,
    String licensePlate,
    DriverStatusEnum status,
    num rating,
    bool isOnline,
    Location? currentLocation,
    DateTime? lastLocationUpdate,
    DateTime createdAt,
    String studentCard,
    String driverLicense,
    String vehicleCertificate,
    Bank bank,
    OrderCreateRequestUser? user,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDriver.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDriver.copyWith.fieldName(...)`
class _$DriverCWProxyImpl implements _$DriverCWProxy {
  const _$DriverCWProxyImpl(this._value);

  final Driver _value;

  @override
  Driver id(String id) => this(id: id);

  @override
  Driver userId(String userId) => this(userId: userId);

  @override
  Driver studentId(num studentId) => this(studentId: studentId);

  @override
  Driver licensePlate(String licensePlate) => this(licensePlate: licensePlate);

  @override
  Driver status(DriverStatusEnum status) => this(status: status);

  @override
  Driver rating(num rating) => this(rating: rating);

  @override
  Driver isOnline(bool isOnline) => this(isOnline: isOnline);

  @override
  Driver currentLocation(Location? currentLocation) =>
      this(currentLocation: currentLocation);

  @override
  Driver lastLocationUpdate(DateTime? lastLocationUpdate) =>
      this(lastLocationUpdate: lastLocationUpdate);

  @override
  Driver createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Driver studentCard(String studentCard) => this(studentCard: studentCard);

  @override
  Driver driverLicense(String driverLicense) =>
      this(driverLicense: driverLicense);

  @override
  Driver vehicleCertificate(String vehicleCertificate) =>
      this(vehicleCertificate: vehicleCertificate);

  @override
  Driver bank(Bank bank) => this(bank: bank);

  @override
  Driver user(OrderCreateRequestUser? user) => this(user: user);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Driver(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Driver(...).copyWith(id: 12, name: "My name")
  /// ````
  Driver call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? studentId = const $CopyWithPlaceholder(),
    Object? licensePlate = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? rating = const $CopyWithPlaceholder(),
    Object? isOnline = const $CopyWithPlaceholder(),
    Object? currentLocation = const $CopyWithPlaceholder(),
    Object? lastLocationUpdate = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? studentCard = const $CopyWithPlaceholder(),
    Object? driverLicense = const $CopyWithPlaceholder(),
    Object? vehicleCertificate = const $CopyWithPlaceholder(),
    Object? bank = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return Driver(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      studentId: studentId == const $CopyWithPlaceholder()
          ? _value.studentId
          // ignore: cast_nullable_to_non_nullable
          : studentId as num,
      licensePlate: licensePlate == const $CopyWithPlaceholder()
          ? _value.licensePlate
          // ignore: cast_nullable_to_non_nullable
          : licensePlate as String,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as DriverStatusEnum,
      rating: rating == const $CopyWithPlaceholder()
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as num,
      isOnline: isOnline == const $CopyWithPlaceholder()
          ? _value.isOnline
          // ignore: cast_nullable_to_non_nullable
          : isOnline as bool,
      currentLocation: currentLocation == const $CopyWithPlaceholder()
          ? _value.currentLocation
          // ignore: cast_nullable_to_non_nullable
          : currentLocation as Location?,
      lastLocationUpdate: lastLocationUpdate == const $CopyWithPlaceholder()
          ? _value.lastLocationUpdate
          // ignore: cast_nullable_to_non_nullable
          : lastLocationUpdate as DateTime?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      studentCard: studentCard == const $CopyWithPlaceholder()
          ? _value.studentCard
          // ignore: cast_nullable_to_non_nullable
          : studentCard as String,
      driverLicense: driverLicense == const $CopyWithPlaceholder()
          ? _value.driverLicense
          // ignore: cast_nullable_to_non_nullable
          : driverLicense as String,
      vehicleCertificate: vehicleCertificate == const $CopyWithPlaceholder()
          ? _value.vehicleCertificate
          // ignore: cast_nullable_to_non_nullable
          : vehicleCertificate as String,
      bank: bank == const $CopyWithPlaceholder()
          ? _value.bank
          // ignore: cast_nullable_to_non_nullable
          : bank as Bank,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as OrderCreateRequestUser?,
    );
  }
}

extension $DriverCopyWith on Driver {
  /// Returns a callable class that can be used as follows: `instanceOfDriver.copyWith(...)` or like so:`instanceOfDriver.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverCWProxy get copyWith => _$DriverCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Driver _$DriverFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Driver', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'userId',
          'studentId',
          'licensePlate',
          'status',
          'rating',
          'isOnline',
          'createdAt',
          'studentCard',
          'driverLicense',
          'vehicleCertificate',
          'bank',
        ],
      );
      final val = Driver(
        id: $checkedConvert('id', (v) => v as String),
        userId: $checkedConvert('userId', (v) => v as String),
        studentId: $checkedConvert('studentId', (v) => v as num),
        licensePlate: $checkedConvert('licensePlate', (v) => v as String),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$DriverStatusEnumEnumMap, v),
        ),
        rating: $checkedConvert('rating', (v) => v as num),
        isOnline: $checkedConvert('isOnline', (v) => v as bool),
        currentLocation: $checkedConvert(
          'currentLocation',
          (v) =>
              v == null ? null : Location.fromJson(v as Map<String, dynamic>),
        ),
        lastLocationUpdate: $checkedConvert(
          'lastLocationUpdate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        studentCard: $checkedConvert('studentCard', (v) => v as String),
        driverLicense: $checkedConvert('driverLicense', (v) => v as String),
        vehicleCertificate: $checkedConvert(
          'vehicleCertificate',
          (v) => v as String,
        ),
        bank: $checkedConvert(
          'bank',
          (v) => Bank.fromJson(v as Map<String, dynamic>),
        ),
        user: $checkedConvert(
          'user',
          (v) => v == null
              ? null
              : OrderCreateRequestUser.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'studentId': instance.studentId,
  'licensePlate': instance.licensePlate,
  'status': _$DriverStatusEnumEnumMap[instance.status]!,
  'rating': instance.rating,
  'isOnline': instance.isOnline,
  'currentLocation': ?instance.currentLocation?.toJson(),
  'lastLocationUpdate': ?instance.lastLocationUpdate?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'studentCard': instance.studentCard,
  'driverLicense': instance.driverLicense,
  'vehicleCertificate': instance.vehicleCertificate,
  'bank': instance.bank.toJson(),
  'user': ?instance.user?.toJson(),
};

const _$DriverStatusEnumEnumMap = {
  DriverStatusEnum.pending: 'pending',
  DriverStatusEnum.approved: 'approved',
  DriverStatusEnum.rejected: 'rejected',
  DriverStatusEnum.active: 'active',
  DriverStatusEnum.inactive: 'inactive',
  DriverStatusEnum.suspended: 'suspended',
};
