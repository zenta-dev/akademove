//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'time.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Time {
  /// Returns a new [Time] instance.
  const Time({
    required this.h,
    required this.m,
  });
  @JsonKey(name: r'h', required: true, includeIfNull: false)
  final num h;
  
  @JsonKey(name: r'm', required: true, includeIfNull: false)
  final num m;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is Time &&
    other.h == h &&
    other.m == m;

  @override
  int get hashCode =>
      h.hashCode +
      m.hashCode;

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  Map<String, dynamic> toJson() => _$TimeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

