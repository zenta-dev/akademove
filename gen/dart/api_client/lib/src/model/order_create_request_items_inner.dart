//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_create_request_items_inner_item.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_create_request_items_inner.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderCreateRequestItemsInner {
  /// Returns a new [OrderCreateRequestItemsInner] instance.
  OrderCreateRequestItemsInner({

    required  this.id,

    required  this.itemId,

    required  this.total,

    required  this.item,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'itemId',
    required: true,
    includeIfNull: false,
  )


  final String itemId;



  @JsonKey(
    
    name: r'total',
    required: true,
    includeIfNull: false,
  )


  final num total;



  @JsonKey(
    
    name: r'item',
    required: true,
    includeIfNull: false,
  )


  final OrderCreateRequestItemsInnerItem item;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderCreateRequestItemsInner &&
      other.id == id &&
      other.itemId == itemId &&
      other.total == total &&
      other.item == item;

    @override
    int get hashCode =>
        id.hashCode +
        itemId.hashCode +
        total.hashCode +
        item.hashCode;

  factory OrderCreateRequestItemsInner.fromJson(Map<String, dynamic> json) => _$OrderCreateRequestItemsInnerFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateRequestItemsInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

