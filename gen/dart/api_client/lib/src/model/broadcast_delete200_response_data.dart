//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'broadcast_delete200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BroadcastDelete200ResponseData {
  /// Returns a new [BroadcastDelete200ResponseData] instance.
  const BroadcastDelete200ResponseData({
    required this.ok,
  });
  @JsonKey(name: r'ok', required: true, includeIfNull: false)
  final bool ok;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is BroadcastDelete200ResponseData &&
    other.ok == ok;

  @override
  int get hashCode =>
      ok.hashCode;

  factory BroadcastDelete200ResponseData.fromJson(Map<String, dynamic> json) => _$BroadcastDelete200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$BroadcastDelete200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

