//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user_fraud_profile_user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user_fraud_profile.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserFraudProfile {
  /// Returns a new [UserFraudProfile] instance.
  const UserFraudProfile({
    required this.id,
    required this.userId,
    required this.riskScore,
    required this.totalEvents,
    required this.confirmedEvents,
    required this.isHighRisk,
    required this.knownIps,
    required this.lastEventAt,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  // minimum: 0
  // maximum: 100
  @JsonKey(name: r'riskScore', required: true, includeIfNull: false)
  final num riskScore;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'totalEvents', required: true, includeIfNull: false)
  final int totalEvents;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'confirmedEvents', required: true, includeIfNull: false)
  final int confirmedEvents;

  @JsonKey(name: r'isHighRisk', required: true, includeIfNull: false)
  final bool isHighRisk;

  @JsonKey(name: r'knownIps', required: true, includeIfNull: false)
  final List<String> knownIps;

  @JsonKey(name: r'lastEventAt', required: true, includeIfNull: true)
  final DateTime? lastEventAt;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @JsonKey(name: r'user', required: false, includeIfNull: false)
  final UserFraudProfileUser? user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserFraudProfile &&
          other.id == id &&
          other.userId == userId &&
          other.riskScore == riskScore &&
          other.totalEvents == totalEvents &&
          other.confirmedEvents == confirmedEvents &&
          other.isHighRisk == isHighRisk &&
          other.knownIps == knownIps &&
          other.lastEventAt == lastEventAt &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.user == user;

  @override
  int get hashCode =>
      id.hashCode +
      userId.hashCode +
      riskScore.hashCode +
      totalEvents.hashCode +
      confirmedEvents.hashCode +
      isHighRisk.hashCode +
      knownIps.hashCode +
      (lastEventAt == null ? 0 : lastEventAt.hashCode) +
      createdAt.hashCode +
      updatedAt.hashCode +
      user.hashCode;

  factory UserFraudProfile.fromJson(Map<String, dynamic> json) =>
      _$UserFraudProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserFraudProfileToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
