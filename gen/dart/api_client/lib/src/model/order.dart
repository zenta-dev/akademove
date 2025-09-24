//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_create_request_note.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/location.dart';
import 'package:api_client/src/model/driver_update_request_user.dart';
import 'package:api_client/src/model/order_create_request_merchant.dart';
import 'package:api_client/src/model/order_create_request_driver.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order.g.dart';

/// Order
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [driverId] 
/// * [merchantId] 
/// * [type] 
/// * [status] 
/// * [pickupLocation] 
/// * [dropoffLocation] 
/// * [distanceKm] 
/// * [basePrice] 
/// * [tip] 
/// * [totalPrice] 
/// * [note] 
/// * [requestedAt] - unix timestamp format
/// * [acceptedAt] - unix timestamp format
/// * [arrivedAt] - unix timestamp format
/// * [createdAt] - unix timestamp format
/// * [updatedAt] - unix timestamp format
/// * [user] 
/// * [driver] 
/// * [merchant] 
@BuiltValue()
abstract class Order implements Built<Order, OrderBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'userId')
  String get userId;

  @BuiltValueField(wireName: r'driverId')
  String? get driverId;

  @BuiltValueField(wireName: r'merchantId')
  String? get merchantId;

  @BuiltValueField(wireName: r'type')
  OrderTypeEnum get type;
  // enum typeEnum {  ride,  delivery,  food,  };

  @BuiltValueField(wireName: r'status')
  OrderStatusEnum get status;
  // enum statusEnum {  requested,  matching,  accepted,  arriving,  in_trip,  completed,  cancelled_by_user,  cancelled_by_driver,  cancelled_by_system,  };

  @BuiltValueField(wireName: r'pickupLocation')
  Location get pickupLocation;

  @BuiltValueField(wireName: r'dropoffLocation')
  Location get dropoffLocation;

  @BuiltValueField(wireName: r'distanceKm')
  num get distanceKm;

  @BuiltValueField(wireName: r'basePrice')
  num get basePrice;

  @BuiltValueField(wireName: r'tip')
  num? get tip;

  @BuiltValueField(wireName: r'totalPrice')
  num get totalPrice;

  @BuiltValueField(wireName: r'note')
  OrderCreateRequestNote? get note;

  /// unix timestamp format
  @BuiltValueField(wireName: r'requestedAt')
  num get requestedAt;

  /// unix timestamp format
  @BuiltValueField(wireName: r'acceptedAt')
  num? get acceptedAt;

  /// unix timestamp format
  @BuiltValueField(wireName: r'arrivedAt')
  num? get arrivedAt;

  /// unix timestamp format
  @BuiltValueField(wireName: r'createdAt')
  num get createdAt;

  /// unix timestamp format
  @BuiltValueField(wireName: r'updatedAt')
  num get updatedAt;

  @BuiltValueField(wireName: r'user')
  DriverUpdateRequestUser? get user;

  @BuiltValueField(wireName: r'driver')
  OrderCreateRequestDriver? get driver;

  @BuiltValueField(wireName: r'merchant')
  OrderCreateRequestMerchant? get merchant;

  Order._();

  factory Order([void updates(OrderBuilder b)]) = _$Order;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Order> get serializer => _$OrderSerializer();
}

class _$OrderSerializer implements PrimitiveSerializer<Order> {
  @override
  final Iterable<Type> types = const [Order, _$Order];

  @override
  final String wireName = r'Order';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Order object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
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
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(OrderTypeEnum),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(OrderStatusEnum),
    );
    yield r'pickupLocation';
    yield serializers.serialize(
      object.pickupLocation,
      specifiedType: const FullType(Location),
    );
    yield r'dropoffLocation';
    yield serializers.serialize(
      object.dropoffLocation,
      specifiedType: const FullType(Location),
    );
    yield r'distanceKm';
    yield serializers.serialize(
      object.distanceKm,
      specifiedType: const FullType(num),
    );
    yield r'basePrice';
    yield serializers.serialize(
      object.basePrice,
      specifiedType: const FullType(num),
    );
    if (object.tip != null) {
      yield r'tip';
      yield serializers.serialize(
        object.tip,
        specifiedType: const FullType(num),
      );
    }
    yield r'totalPrice';
    yield serializers.serialize(
      object.totalPrice,
      specifiedType: const FullType(num),
    );
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType(OrderCreateRequestNote),
      );
    }
    yield r'requestedAt';
    yield serializers.serialize(
      object.requestedAt,
      specifiedType: const FullType(num),
    );
    if (object.acceptedAt != null) {
      yield r'acceptedAt';
      yield serializers.serialize(
        object.acceptedAt,
        specifiedType: const FullType(num),
      );
    }
    if (object.arrivedAt != null) {
      yield r'arrivedAt';
      yield serializers.serialize(
        object.arrivedAt,
        specifiedType: const FullType(num),
      );
    }
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(num),
    );
    yield r'updatedAt';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(num),
    );
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
    Order object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
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
            specifiedType: const FullType(OrderTypeEnum),
          ) as OrderTypeEnum;
          result.type = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderStatusEnum),
          ) as OrderStatusEnum;
          result.status = valueDes;
          break;
        case r'pickupLocation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Location),
          ) as Location;
          result.pickupLocation.replace(valueDes);
          break;
        case r'dropoffLocation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Location),
          ) as Location;
          result.dropoffLocation.replace(valueDes);
          break;
        case r'distanceKm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.distanceKm = valueDes;
          break;
        case r'basePrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.basePrice = valueDes;
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
        case r'requestedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.requestedAt = valueDes;
          break;
        case r'acceptedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.acceptedAt = valueDes;
          break;
        case r'arrivedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.arrivedAt = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.createdAt = valueDes;
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.updatedAt = valueDes;
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
  Order deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderBuilder();
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

class OrderTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ride')
  static const OrderTypeEnum ride = _$orderTypeEnum_ride;
  @BuiltValueEnumConst(wireName: r'delivery')
  static const OrderTypeEnum delivery = _$orderTypeEnum_delivery;
  @BuiltValueEnumConst(wireName: r'food')
  static const OrderTypeEnum food = _$orderTypeEnum_food;

  static Serializer<OrderTypeEnum> get serializer => _$orderTypeEnumSerializer;

  const OrderTypeEnum._(String name): super(name);

  static BuiltSet<OrderTypeEnum> get values => _$orderTypeEnumValues;
  static OrderTypeEnum valueOf(String name) => _$orderTypeEnumValueOf(name);
}

class OrderStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'requested')
  static const OrderStatusEnum requested = _$orderStatusEnum_requested;
  @BuiltValueEnumConst(wireName: r'matching')
  static const OrderStatusEnum matching = _$orderStatusEnum_matching;
  @BuiltValueEnumConst(wireName: r'accepted')
  static const OrderStatusEnum accepted = _$orderStatusEnum_accepted;
  @BuiltValueEnumConst(wireName: r'arriving')
  static const OrderStatusEnum arriving = _$orderStatusEnum_arriving;
  @BuiltValueEnumConst(wireName: r'in_trip')
  static const OrderStatusEnum inTrip = _$orderStatusEnum_inTrip;
  @BuiltValueEnumConst(wireName: r'completed')
  static const OrderStatusEnum completed = _$orderStatusEnum_completed;
  @BuiltValueEnumConst(wireName: r'cancelled_by_user')
  static const OrderStatusEnum cancelledByUser = _$orderStatusEnum_cancelledByUser;
  @BuiltValueEnumConst(wireName: r'cancelled_by_driver')
  static const OrderStatusEnum cancelledByDriver = _$orderStatusEnum_cancelledByDriver;
  @BuiltValueEnumConst(wireName: r'cancelled_by_system')
  static const OrderStatusEnum cancelledBySystem = _$orderStatusEnum_cancelledBySystem;

  static Serializer<OrderStatusEnum> get serializer => _$orderStatusEnumSerializer;

  const OrderStatusEnum._(String name): super(name);

  static BuiltSet<OrderStatusEnum> get values => _$orderStatusEnumValues;
  static OrderStatusEnum valueOf(String name) => _$orderStatusEnumValueOf(name);
}

