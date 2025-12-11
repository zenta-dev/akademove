//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_get_active200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderGetActive200ResponseData {
  /// Returns a new [OrderGetActive200ResponseData] instance.
  const OrderGetActive200ResponseData({
     this.order,
     this.payment,
     this.transaction,
     this.driver,
  });
  @JsonKey(name: r'order', required: false, includeIfNull: false)
  final Order? order;
  
  @JsonKey(name: r'payment', required: false, includeIfNull: false)
  final Object? payment;
  
  @JsonKey(name: r'transaction', required: false, includeIfNull: false)
  final Object? transaction;
  
  @JsonKey(name: r'driver', required: false, includeIfNull: false)
  final Object? driver;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderGetActive200ResponseData &&
    other.order == order &&
    other.payment == payment &&
    other.transaction == transaction &&
    other.driver == driver;

  @override
  int get hashCode =>
      order.hashCode +
      (payment == null ? 0 : payment.hashCode) +
      (transaction == null ? 0 : transaction.hashCode) +
      (driver == null ? 0 : driver.hashCode);

  factory OrderGetActive200ResponseData.fromJson(Map<String, dynamic> json) => _$OrderGetActive200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderGetActive200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

