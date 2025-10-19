//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_list_statuses_parameter.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderListStatusesParameter {
  /// Returns a new [OrderListStatusesParameter] instance.
  OrderListStatusesParameter({
  });



    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderListStatusesParameter &&

    @override
    int get hashCode =>

  factory OrderListStatusesParameter.fromJson(Map<String, dynamic> json) => _$OrderListStatusesParameterFromJson(json);

  Map<String, dynamic> toJson() => _$OrderListStatusesParameterToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

