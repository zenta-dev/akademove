//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_update_online_status_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverUpdateOnlineStatusRequest {
  /// Returns a new [DriverUpdateOnlineStatusRequest] instance.
  const DriverUpdateOnlineStatusRequest({
    required this.isOnline,
  });
  @JsonKey(name: r'isOnline', required: true, includeIfNull: false)
  final bool isOnline;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DriverUpdateOnlineStatusRequest &&
    other.isOnline == isOnline;

  @override
  int get hashCode =>
      isOnline.hashCode;

  factory DriverUpdateOnlineStatusRequest.fromJson(Map<String, dynamic> json) => _$DriverUpdateOnlineStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DriverUpdateOnlineStatusRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

