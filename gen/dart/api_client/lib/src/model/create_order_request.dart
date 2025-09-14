//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/create_order_request_note.dart';
import 'package:api_client/src/model/location.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_order_request.g.dart';

/// CreateOrderRequest
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
@BuiltValue()
abstract class CreateOrderRequest implements Built<CreateOrderRequest, CreateOrderRequestBuilder> {
  @BuiltValueField(wireName: r'userId')
  String get userId;

  @BuiltValueField(wireName: r'driverId')
  String? get driverId;

  @BuiltValueField(wireName: r'merchantId')
  String? get merchantId;

  @BuiltValueField(wireName: r'type')
  CreateOrderRequestTypeEnum get type;
  // enum typeEnum {  ride,  delivery,  food,  };

  @BuiltValueField(wireName: r'status')
  CreateOrderRequestStatusEnum get status;
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
  CreateOrderRequestNote? get note;

  CreateOrderRequest._();

  factory CreateOrderRequest([void updates(CreateOrderRequestBuilder b)]) = _$CreateOrderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateOrderRequestBuilder b) => b
      ..tip = 0;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateOrderRequest> get serializer => _$CreateOrderRequestSerializer();
}

class _$CreateOrderRequestSerializer implements PrimitiveSerializer<CreateOrderRequest> {
  @override
  final Iterable<Type> types = const [CreateOrderRequest, _$CreateOrderRequest];

  @override
  final String wireName = r'CreateOrderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    yield r'driverId';
    yield object.driverId == null ? null : serializers.serialize(
      object.driverId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'merchantId';
    yield object.merchantId == null ? null : serializers.serialize(
      object.merchantId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(CreateOrderRequestTypeEnum),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(CreateOrderRequestStatusEnum),
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
    yield r'note';
    yield object.note == null ? null : serializers.serialize(
      object.note,
      specifiedType: const FullType.nullable(CreateOrderRequestNote),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateOrderRequestBuilder result,
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
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.driverId = valueDes;
          break;
        case r'merchantId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.merchantId = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateOrderRequestTypeEnum),
          ) as CreateOrderRequestTypeEnum;
          result.type = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateOrderRequestStatusEnum),
          ) as CreateOrderRequestStatusEnum;
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
            specifiedType: const FullType.nullable(CreateOrderRequestNote),
          ) as CreateOrderRequestNote?;
          if (valueDes == null) continue;
          result.note.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateOrderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateOrderRequestBuilder();
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

class CreateOrderRequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ride')
  static const CreateOrderRequestTypeEnum ride = _$createOrderRequestTypeEnum_ride;
  @BuiltValueEnumConst(wireName: r'delivery')
  static const CreateOrderRequestTypeEnum delivery = _$createOrderRequestTypeEnum_delivery;
  @BuiltValueEnumConst(wireName: r'food')
  static const CreateOrderRequestTypeEnum food = _$createOrderRequestTypeEnum_food;

  static Serializer<CreateOrderRequestTypeEnum> get serializer => _$createOrderRequestTypeEnumSerializer;

  const CreateOrderRequestTypeEnum._(String name): super(name);

  static BuiltSet<CreateOrderRequestTypeEnum> get values => _$createOrderRequestTypeEnumValues;
  static CreateOrderRequestTypeEnum valueOf(String name) => _$createOrderRequestTypeEnumValueOf(name);
}

class CreateOrderRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'requested')
  static const CreateOrderRequestStatusEnum requested = _$createOrderRequestStatusEnum_requested;
  @BuiltValueEnumConst(wireName: r'matching')
  static const CreateOrderRequestStatusEnum matching = _$createOrderRequestStatusEnum_matching;
  @BuiltValueEnumConst(wireName: r'accepted')
  static const CreateOrderRequestStatusEnum accepted = _$createOrderRequestStatusEnum_accepted;
  @BuiltValueEnumConst(wireName: r'arriving')
  static const CreateOrderRequestStatusEnum arriving = _$createOrderRequestStatusEnum_arriving;
  @BuiltValueEnumConst(wireName: r'in_trip')
  static const CreateOrderRequestStatusEnum inTrip = _$createOrderRequestStatusEnum_inTrip;
  @BuiltValueEnumConst(wireName: r'completed')
  static const CreateOrderRequestStatusEnum completed = _$createOrderRequestStatusEnum_completed;
  @BuiltValueEnumConst(wireName: r'cancelled_by_user')
  static const CreateOrderRequestStatusEnum cancelledByUser = _$createOrderRequestStatusEnum_cancelledByUser;
  @BuiltValueEnumConst(wireName: r'cancelled_by_driver')
  static const CreateOrderRequestStatusEnum cancelledByDriver = _$createOrderRequestStatusEnum_cancelledByDriver;
  @BuiltValueEnumConst(wireName: r'cancelled_by_system')
  static const CreateOrderRequestStatusEnum cancelledBySystem = _$createOrderRequestStatusEnum_cancelledBySystem;

  static Serializer<CreateOrderRequestStatusEnum> get serializer => _$createOrderRequestStatusEnumSerializer;

  const CreateOrderRequestStatusEnum._(String name): super(name);

  static BuiltSet<CreateOrderRequestStatusEnum> get values => _$createOrderRequestStatusEnumValues;
  static CreateOrderRequestStatusEnum valueOf(String name) => _$createOrderRequestStatusEnumValueOf(name);
}

