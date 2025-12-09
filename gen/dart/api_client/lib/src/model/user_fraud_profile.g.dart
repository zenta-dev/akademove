// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_fraud_profile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserFraudProfileCWProxy {
  UserFraudProfile id(String id);

  UserFraudProfile userId(String userId);

  UserFraudProfile riskScore(num riskScore);

  UserFraudProfile totalEvents(int totalEvents);

  UserFraudProfile confirmedEvents(int confirmedEvents);

  UserFraudProfile isHighRisk(bool isHighRisk);

  UserFraudProfile knownIps(List<String> knownIps);

  UserFraudProfile lastEventAt(DateTime? lastEventAt);

  UserFraudProfile createdAt(DateTime createdAt);

  UserFraudProfile updatedAt(DateTime updatedAt);

  UserFraudProfile user(UserFraudProfileUser? user);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserFraudProfile(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserFraudProfile(...).copyWith(id: 12, name: "My name")
  /// ```
  UserFraudProfile call({
    String id,
    String userId,
    num riskScore,
    int totalEvents,
    int confirmedEvents,
    bool isHighRisk,
    List<String> knownIps,
    DateTime? lastEventAt,
    DateTime createdAt,
    DateTime updatedAt,
    UserFraudProfileUser? user,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserFraudProfile.copyWith(...)` or call `instanceOfUserFraudProfile.copyWith.fieldName(value)` for a single field.
class _$UserFraudProfileCWProxyImpl implements _$UserFraudProfileCWProxy {
  const _$UserFraudProfileCWProxyImpl(this._value);

  final UserFraudProfile _value;

  @override
  UserFraudProfile id(String id) => call(id: id);

  @override
  UserFraudProfile userId(String userId) => call(userId: userId);

  @override
  UserFraudProfile riskScore(num riskScore) => call(riskScore: riskScore);

  @override
  UserFraudProfile totalEvents(int totalEvents) =>
      call(totalEvents: totalEvents);

  @override
  UserFraudProfile confirmedEvents(int confirmedEvents) =>
      call(confirmedEvents: confirmedEvents);

  @override
  UserFraudProfile isHighRisk(bool isHighRisk) => call(isHighRisk: isHighRisk);

  @override
  UserFraudProfile knownIps(List<String> knownIps) => call(knownIps: knownIps);

  @override
  UserFraudProfile lastEventAt(DateTime? lastEventAt) =>
      call(lastEventAt: lastEventAt);

  @override
  UserFraudProfile createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  UserFraudProfile updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  UserFraudProfile user(UserFraudProfileUser? user) => call(user: user);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserFraudProfile(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserFraudProfile(...).copyWith(id: 12, name: "My name")
  /// ```
  UserFraudProfile call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? riskScore = const $CopyWithPlaceholder(),
    Object? totalEvents = const $CopyWithPlaceholder(),
    Object? confirmedEvents = const $CopyWithPlaceholder(),
    Object? isHighRisk = const $CopyWithPlaceholder(),
    Object? knownIps = const $CopyWithPlaceholder(),
    Object? lastEventAt = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return UserFraudProfile(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      riskScore: riskScore == const $CopyWithPlaceholder() || riskScore == null
          ? _value.riskScore
          // ignore: cast_nullable_to_non_nullable
          : riskScore as num,
      totalEvents:
          totalEvents == const $CopyWithPlaceholder() || totalEvents == null
          ? _value.totalEvents
          // ignore: cast_nullable_to_non_nullable
          : totalEvents as int,
      confirmedEvents:
          confirmedEvents == const $CopyWithPlaceholder() ||
              confirmedEvents == null
          ? _value.confirmedEvents
          // ignore: cast_nullable_to_non_nullable
          : confirmedEvents as int,
      isHighRisk:
          isHighRisk == const $CopyWithPlaceholder() || isHighRisk == null
          ? _value.isHighRisk
          // ignore: cast_nullable_to_non_nullable
          : isHighRisk as bool,
      knownIps: knownIps == const $CopyWithPlaceholder() || knownIps == null
          ? _value.knownIps
          // ignore: cast_nullable_to_non_nullable
          : knownIps as List<String>,
      lastEventAt: lastEventAt == const $CopyWithPlaceholder()
          ? _value.lastEventAt
          // ignore: cast_nullable_to_non_nullable
          : lastEventAt as DateTime?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as UserFraudProfileUser?,
    );
  }
}

extension $UserFraudProfileCopyWith on UserFraudProfile {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserFraudProfile.copyWith(...)` or `instanceOfUserFraudProfile.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserFraudProfileCWProxy get copyWith => _$UserFraudProfileCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFraudProfile _$UserFraudProfileFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UserFraudProfile', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'userId',
      'riskScore',
      'totalEvents',
      'confirmedEvents',
      'isHighRisk',
      'knownIps',
      'lastEventAt',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = UserFraudProfile(
    id: $checkedConvert('id', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    riskScore: $checkedConvert('riskScore', (v) => v as num),
    totalEvents: $checkedConvert('totalEvents', (v) => (v as num).toInt()),
    confirmedEvents: $checkedConvert(
      'confirmedEvents',
      (v) => (v as num).toInt(),
    ),
    isHighRisk: $checkedConvert('isHighRisk', (v) => v as bool),
    knownIps: $checkedConvert(
      'knownIps',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    lastEventAt: $checkedConvert(
      'lastEventAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
    user: $checkedConvert(
      'user',
      (v) => v == null
          ? null
          : UserFraudProfileUser.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$UserFraudProfileToJson(UserFraudProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'riskScore': instance.riskScore,
      'totalEvents': instance.totalEvents,
      'confirmedEvents': instance.confirmedEvents,
      'isHighRisk': instance.isHighRisk,
      'knownIps': instance.knownIps,
      'lastEventAt': instance.lastEventAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'user': ?instance.user?.toJson(),
    };
