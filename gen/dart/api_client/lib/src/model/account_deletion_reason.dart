//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum AccountDeletionReason {
  @JsonValue(r'NO_LONGER_NEEDED')
  NO_LONGER_NEEDED(r'NO_LONGER_NEEDED'),
  @JsonValue(r'PRIVACY_CONCERNS')
  PRIVACY_CONCERNS(r'PRIVACY_CONCERNS'),
  @JsonValue(r'SWITCHING_SERVICE')
  SWITCHING_SERVICE(r'SWITCHING_SERVICE'),
  @JsonValue(r'TOO_MANY_NOTIFICATIONS')
  TOO_MANY_NOTIFICATIONS(r'TOO_MANY_NOTIFICATIONS'),
  @JsonValue(r'DIFFICULT_TO_USE')
  DIFFICULT_TO_USE(r'DIFFICULT_TO_USE'),
  @JsonValue(r'POOR_EXPERIENCE')
  POOR_EXPERIENCE(r'POOR_EXPERIENCE'),
  @JsonValue(r'OTHER')
  OTHER(r'OTHER');

  const AccountDeletionReason(this.value);

  final String value;

  @override
  String toString() => value;
}
