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

part 'order_create_request.g.dart';

/// OrderCreateRequest
///
/// Properties:
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
/// * [user] 
/// * [driver] 
/// * [merchant] 
@BuiltValue()
abstract class OrderCreateRequest implements Built<OrderCreateRequest, OrderCreateRequestBuilder> {
  @BuiltValueField(wireName: r'userId')
  String get userId;

  @BuiltValueField(wireName: r'driverId')
  String? get driverId;

  @BuiltValueField(wireName: r'merchantId')
  String? get merchantId;

  @BuiltValueField(wireName: r'type')
  OrderCreateRequestTypeEnum? get type;
  // enum typeEnum {  ride,  delivery,  food,  };

  @BuiltValueField(wireName: r'status')
  OrderCreateRequestStatusEnum? get status;
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

  @BuiltValueField(wireName: r'user')
  DriverUpdateRequestUser? get user;

  @BuiltValueField(wireName: r'driver')
  OrderCreateRequestDriver? get driver;

  @BuiltValueField(wireName: r'merchant')
  OrderCreateRequestMerchant? get merchant;

  OrderCreateRequest._();

  factory OrderCreateRequest([void updates(OrderCreateRequestBuilder b)]) = _$OrderCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderCreateRequestBuilder b) => b
      ..type = const OrderCreateRequestTypeEnum._('ride')
      ..status = const OrderCreateRequestStatusEnum._('requested');

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderCreateRequest> get serializer => _$OrderCreateRequestSerializer();
}

class _$OrderCreateRequestSerializer implements PrimitiveSerializer<OrderCreateRequest> {
  @override
  final Iterable<Type> types = const [OrderCreateRequest, _$OrderCreateRequest];

  @override
  final String wireName = r'OrderCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(OrderCreateRequestTypeEnum),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(OrderCreateRequestStatusEnum),
      );
    }
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
    OrderCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(OrderCreateRequestTypeEnum),
          ) as OrderCreateRequestTypeEnum;
          result.type = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderCreateRequestStatusEnum),
          ) as OrderCreateRequestStatusEnum;
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
  OrderCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderCreateRequestBuilder();
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

class OrderCreateRequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ride')
  static const OrderCreateRequestTypeEnum ride = _$orderCreateRequestTypeEnum_ride;
  @BuiltValueEnumConst(wireName: r'delivery')
  static const OrderCreateRequestTypeEnum delivery = _$orderCreateRequestTypeEnum_delivery;
  @BuiltValueEnumConst(wireName: r'food')
  static const OrderCreateRequestTypeEnum food = _$orderCreateRequestTypeEnum_food;

  static Serializer<OrderCreateRequestTypeEnum> get serializer => _$orderCreateRequestTypeEnumSerializer;

  const OrderCreateRequestTypeEnum._(String name): super(name);

  static BuiltSet<OrderCreateRequestTypeEnum> get values => _$orderCreateRequestTypeEnumValues;
  static OrderCreateRequestTypeEnum valueOf(String name) => _$orderCreateRequestTypeEnumValueOf(name);
}

class OrderCreateRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'requested')
  static const OrderCreateRequestStatusEnum requested = _$orderCreateRequestStatusEnum_requested;
  @BuiltValueEnumConst(wireName: r'matching')
  static const OrderCreateRequestStatusEnum matching = _$orderCreateRequestStatusEnum_matching;
  @BuiltValueEnumConst(wireName: r'accepted')
  static const OrderCreateRequestStatusEnum accepted = _$orderCreateRequestStatusEnum_accepted;
  @BuiltValueEnumConst(wireName: r'arriving')
  static const OrderCreateRequestStatusEnum arriving = _$orderCreateRequestStatusEnum_arriving;
  @BuiltValueEnumConst(wireName: r'in_trip')
  static const OrderCreateRequestStatusEnum inTrip = _$orderCreateRequestStatusEnum_inTrip;
  @BuiltValueEnumConst(wireName: r'completed')
  static const OrderCreateRequestStatusEnum completed = _$orderCreateRequestStatusEnum_completed;
  @BuiltValueEnumConst(wireName: r'cancelled_by_user')
  static const OrderCreateRequestStatusEnum cancelledByUser = _$orderCreateRequestStatusEnum_cancelledByUser;
  @BuiltValueEnumConst(wireName: r'cancelled_by_driver')
  static const OrderCreateRequestStatusEnum cancelledByDriver = _$orderCreateRequestStatusEnum_cancelledByDriver;
  @BuiltValueEnumConst(wireName: r'cancelled_by_system')
  static const OrderCreateRequestStatusEnum cancelledBySystem = _$orderCreateRequestStatusEnum_cancelledBySystem;

  static Serializer<OrderCreateRequestStatusEnum> get serializer => _$orderCreateRequestStatusEnumSerializer;

  const OrderCreateRequestStatusEnum._(String name): super(name);

  static BuiltSet<OrderCreateRequestStatusEnum> get values => _$orderCreateRequestStatusEnumValues;
  static OrderCreateRequestStatusEnum valueOf(String name) => _$orderCreateRequestStatusEnumValueOf(name);
}

