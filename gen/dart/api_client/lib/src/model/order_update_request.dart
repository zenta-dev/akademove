//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_create_request_note.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/driver_update_request_user.dart';
import 'package:api_client/src/model/order_create_request_merchant.dart';
import 'package:api_client/src/model/order_create_request_driver.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_update_request.g.dart';

/// OrderUpdateRequest
///
/// Properties:
/// * [driverId] 
/// * [merchantId] 
/// * [type] 
/// * [status] 
/// * [distanceKm] 
/// * [tip] 
/// * [totalPrice] 
/// * [note] 
/// * [user] 
/// * [driver] 
/// * [merchant] 
@BuiltValue()
abstract class OrderUpdateRequest implements Built<OrderUpdateRequest, OrderUpdateRequestBuilder> {
  @BuiltValueField(wireName: r'driverId')
  String? get driverId;

  @BuiltValueField(wireName: r'merchantId')
  String? get merchantId;

  @BuiltValueField(wireName: r'type')
  OrderUpdateRequestTypeEnum? get type;
  // enum typeEnum {  ride,  delivery,  food,  };

  @BuiltValueField(wireName: r'status')
  OrderUpdateRequestStatusEnum? get status;
  // enum statusEnum {  requested,  matching,  accepted,  arriving,  in_trip,  completed,  cancelled_by_user,  cancelled_by_driver,  cancelled_by_system,  };

  @BuiltValueField(wireName: r'distanceKm')
  num? get distanceKm;

  @BuiltValueField(wireName: r'tip')
  num? get tip;

  @BuiltValueField(wireName: r'totalPrice')
  num? get totalPrice;

  @BuiltValueField(wireName: r'note')
  OrderCreateRequestNote? get note;

  @BuiltValueField(wireName: r'user')
  DriverUpdateRequestUser? get user;

  @BuiltValueField(wireName: r'driver')
  OrderCreateRequestDriver? get driver;

  @BuiltValueField(wireName: r'merchant')
  OrderCreateRequestMerchant? get merchant;

  OrderUpdateRequest._();

  factory OrderUpdateRequest([void updates(OrderUpdateRequestBuilder b)]) = _$OrderUpdateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderUpdateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderUpdateRequest> get serializer => _$OrderUpdateRequestSerializer();
}

class _$OrderUpdateRequestSerializer implements PrimitiveSerializer<OrderUpdateRequest> {
  @override
  final Iterable<Type> types = const [OrderUpdateRequest, _$OrderUpdateRequest];

  @override
  final String wireName = r'OrderUpdateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.driverId != null) {
      yield r'driverId';
      yield serializers.serialize(
        object.driverId,
        specifiedType: const FullType(String),
      );
    }
    if (object.merchantId != null) {
      yield r'merchantId';
      yield serializers.serialize(
        object.merchantId,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(OrderUpdateRequestTypeEnum),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(OrderUpdateRequestStatusEnum),
      );
    }
    if (object.distanceKm != null) {
      yield r'distanceKm';
      yield serializers.serialize(
        object.distanceKm,
        specifiedType: const FullType(num),
      );
    }
    if (object.tip != null) {
      yield r'tip';
      yield serializers.serialize(
        object.tip,
        specifiedType: const FullType(num),
      );
    }
    if (object.totalPrice != null) {
      yield r'totalPrice';
      yield serializers.serialize(
        object.totalPrice,
        specifiedType: const FullType(num),
      );
    }
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType(OrderCreateRequestNote),
      );
    }
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType(DriverUpdateRequestUser),
      );
    }
    if (object.driver != null) {
      yield r'driver';
      yield serializers.serialize(
        object.driver,
        specifiedType: const FullType(OrderCreateRequestDriver),
      );
    }
    if (object.merchant != null) {
      yield r'merchant';
      yield serializers.serialize(
        object.merchant,
        specifiedType: const FullType(OrderCreateRequestMerchant),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderUpdateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'driverId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.driverId = valueDes;
          break;
        case r'merchantId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.merchantId = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderUpdateRequestTypeEnum),
          ) as OrderUpdateRequestTypeEnum;
          result.type = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderUpdateRequestStatusEnum),
          ) as OrderUpdateRequestStatusEnum;
          result.status = valueDes;
          break;
        case r'distanceKm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.distanceKm = valueDes;
          break;
        case r'tip':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.tip = valueDes;
          break;
        case r'totalPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalPrice = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderCreateRequestNote),
          ) as OrderCreateRequestNote;
          result.note.replace(valueDes);
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DriverUpdateRequestUser),
          ) as DriverUpdateRequestUser;
          result.user.replace(valueDes);
          break;
        case r'driver':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderCreateRequestDriver),
          ) as OrderCreateRequestDriver;
          result.driver.replace(valueDes);
          break;
        case r'merchant':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderCreateRequestMerchant),
          ) as OrderCreateRequestMerchant;
          result.merchant.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderUpdateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderUpdateRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class OrderUpdateRequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ride')
  static const OrderUpdateRequestTypeEnum ride = _$orderUpdateRequestTypeEnum_ride;
  @BuiltValueEnumConst(wireName: r'delivery')
  static const OrderUpdateRequestTypeEnum delivery = _$orderUpdateRequestTypeEnum_delivery;
  @BuiltValueEnumConst(wireName: r'food')
  static const OrderUpdateRequestTypeEnum food = _$orderUpdateRequestTypeEnum_food;

  static Serializer<OrderUpdateRequestTypeEnum> get serializer => _$orderUpdateRequestTypeEnumSerializer;

  const OrderUpdateRequestTypeEnum._(String name): super(name);

  static BuiltSet<OrderUpdateRequestTypeEnum> get values => _$orderUpdateRequestTypeEnumValues;
  static OrderUpdateRequestTypeEnum valueOf(String name) => _$orderUpdateRequestTypeEnumValueOf(name);
}

class OrderUpdateRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'requested')
  static const OrderUpdateRequestStatusEnum requested = _$orderUpdateRequestStatusEnum_requested;
  @BuiltValueEnumConst(wireName: r'matching')
  static const OrderUpdateRequestStatusEnum matching = _$orderUpdateRequestStatusEnum_matching;
  @BuiltValueEnumConst(wireName: r'accepted')
  static const OrderUpdateRequestStatusEnum accepted = _$orderUpdateRequestStatusEnum_accepted;
  @BuiltValueEnumConst(wireName: r'arriving')
  static const OrderUpdateRequestStatusEnum arriving = _$orderUpdateRequestStatusEnum_arriving;
  @BuiltValueEnumConst(wireName: r'in_trip')
  static const OrderUpdateRequestStatusEnum inTrip = _$orderUpdateRequestStatusEnum_inTrip;
  @BuiltValueEnumConst(wireName: r'completed')
  static const OrderUpdateRequestStatusEnum completed = _$orderUpdateRequestStatusEnum_completed;
  @BuiltValueEnumConst(wireName: r'cancelled_by_user')
  static const OrderUpdateRequestStatusEnum cancelledByUser = _$orderUpdateRequestStatusEnum_cancelledByUser;
  @BuiltValueEnumConst(wireName: r'cancelled_by_driver')
  static const OrderUpdateRequestStatusEnum cancelledByDriver = _$orderUpdateRequestStatusEnum_cancelledByDriver;
  @BuiltValueEnumConst(wireName: r'cancelled_by_system')
  static const OrderUpdateRequestStatusEnum cancelledBySystem = _$orderUpdateRequestStatusEnum_cancelledBySystem;

  static Serializer<OrderUpdateRequestStatusEnum> get serializer => _$orderUpdateRequestStatusEnumSerializer;

  const OrderUpdateRequestStatusEnum._(String name): super(name);

  static BuiltSet<OrderUpdateRequestStatusEnum> get values => _$orderUpdateRequestStatusEnumValues;
  static OrderUpdateRequestStatusEnum valueOf(String name) => _$orderUpdateRequestStatusEnumValueOf(name);
}

