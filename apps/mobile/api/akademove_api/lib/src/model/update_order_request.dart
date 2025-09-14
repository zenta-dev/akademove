//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/create_order_request_note.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_order_request.g.dart';

/// UpdateOrderRequest
///
/// Properties:
/// * [driverId]
/// * [merchantId]
/// * [type]
/// * [status]
/// * [distanceKm]
/// * [totalPrice]
/// * [note]
/// * [tip]
@BuiltValue()
abstract class UpdateOrderRequest
    implements Built<UpdateOrderRequest, UpdateOrderRequestBuilder> {
  @BuiltValueField(wireName: r'driverId')
  String? get driverId;

  @BuiltValueField(wireName: r'merchantId')
  String? get merchantId;

  @BuiltValueField(wireName: r'type')
  UpdateOrderRequestTypeEnum get type;
  // enum typeEnum {  ride,  delivery,  food,  };

  @BuiltValueField(wireName: r'status')
  UpdateOrderRequestStatusEnum get status;
  // enum statusEnum {  requested,  matching,  accepted,  arriving,  in_trip,  completed,  cancelled_by_user,  cancelled_by_driver,  cancelled_by_system,  };

  @BuiltValueField(wireName: r'distanceKm')
  num get distanceKm;

  @BuiltValueField(wireName: r'totalPrice')
  num get totalPrice;

  @BuiltValueField(wireName: r'note')
  CreateOrderRequestNote? get note;

  @BuiltValueField(wireName: r'tip')
  num? get tip;

  UpdateOrderRequest._();

  factory UpdateOrderRequest([void updates(UpdateOrderRequestBuilder b)]) =
      _$UpdateOrderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateOrderRequestBuilder b) => b..tip = 0;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateOrderRequest> get serializer =>
      _$UpdateOrderRequestSerializer();
}

class _$UpdateOrderRequestSerializer
    implements PrimitiveSerializer<UpdateOrderRequest> {
  @override
  final Iterable<Type> types = const [UpdateOrderRequest, _$UpdateOrderRequest];

  @override
  final String wireName = r'UpdateOrderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'driverId';
    yield object.driverId == null
        ? null
        : serializers.serialize(
            object.driverId,
            specifiedType: const FullType.nullable(String),
          );
    yield r'merchantId';
    yield object.merchantId == null
        ? null
        : serializers.serialize(
            object.merchantId,
            specifiedType: const FullType.nullable(String),
          );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(UpdateOrderRequestTypeEnum),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(UpdateOrderRequestStatusEnum),
    );
    yield r'distanceKm';
    yield serializers.serialize(
      object.distanceKm,
      specifiedType: const FullType(num),
    );
    yield r'totalPrice';
    yield serializers.serialize(
      object.totalPrice,
      specifiedType: const FullType(num),
    );
    yield r'note';
    yield object.note == null
        ? null
        : serializers.serialize(
            object.note,
            specifiedType: const FullType.nullable(CreateOrderRequestNote),
          );
    if (object.tip != null) {
      yield r'tip';
      yield serializers.serialize(
        object.tip,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateOrderRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(UpdateOrderRequestTypeEnum),
          ) as UpdateOrderRequestTypeEnum;
          result.type = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UpdateOrderRequestStatusEnum),
          ) as UpdateOrderRequestStatusEnum;
          result.status = valueDes;
          break;
        case r'distanceKm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.distanceKm = valueDes;
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
        case r'tip':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.tip = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateOrderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateOrderRequestBuilder();
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

class UpdateOrderRequestTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'ride')
  static const UpdateOrderRequestTypeEnum ride =
      _$updateOrderRequestTypeEnum_ride;
  @BuiltValueEnumConst(wireName: r'delivery')
  static const UpdateOrderRequestTypeEnum delivery =
      _$updateOrderRequestTypeEnum_delivery;
  @BuiltValueEnumConst(wireName: r'food')
  static const UpdateOrderRequestTypeEnum food =
      _$updateOrderRequestTypeEnum_food;

  static Serializer<UpdateOrderRequestTypeEnum> get serializer =>
      _$updateOrderRequestTypeEnumSerializer;

  const UpdateOrderRequestTypeEnum._(String name) : super(name);

  static BuiltSet<UpdateOrderRequestTypeEnum> get values =>
      _$updateOrderRequestTypeEnumValues;
  static UpdateOrderRequestTypeEnum valueOf(String name) =>
      _$updateOrderRequestTypeEnumValueOf(name);
}

class UpdateOrderRequestStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'requested')
  static const UpdateOrderRequestStatusEnum requested =
      _$updateOrderRequestStatusEnum_requested;
  @BuiltValueEnumConst(wireName: r'matching')
  static const UpdateOrderRequestStatusEnum matching =
      _$updateOrderRequestStatusEnum_matching;
  @BuiltValueEnumConst(wireName: r'accepted')
  static const UpdateOrderRequestStatusEnum accepted =
      _$updateOrderRequestStatusEnum_accepted;
  @BuiltValueEnumConst(wireName: r'arriving')
  static const UpdateOrderRequestStatusEnum arriving =
      _$updateOrderRequestStatusEnum_arriving;
  @BuiltValueEnumConst(wireName: r'in_trip')
  static const UpdateOrderRequestStatusEnum inTrip =
      _$updateOrderRequestStatusEnum_inTrip;
  @BuiltValueEnumConst(wireName: r'completed')
  static const UpdateOrderRequestStatusEnum completed =
      _$updateOrderRequestStatusEnum_completed;
  @BuiltValueEnumConst(wireName: r'cancelled_by_user')
  static const UpdateOrderRequestStatusEnum cancelledByUser =
      _$updateOrderRequestStatusEnum_cancelledByUser;
  @BuiltValueEnumConst(wireName: r'cancelled_by_driver')
  static const UpdateOrderRequestStatusEnum cancelledByDriver =
      _$updateOrderRequestStatusEnum_cancelledByDriver;
  @BuiltValueEnumConst(wireName: r'cancelled_by_system')
  static const UpdateOrderRequestStatusEnum cancelledBySystem =
      _$updateOrderRequestStatusEnum_cancelledBySystem;

  static Serializer<UpdateOrderRequestStatusEnum> get serializer =>
      _$updateOrderRequestStatusEnumSerializer;

  const UpdateOrderRequestStatusEnum._(String name) : super(name);

  static BuiltSet<UpdateOrderRequestStatusEnum> get values =>
      _$updateOrderRequestStatusEnumValues;
  static UpdateOrderRequestStatusEnum valueOf(String name) =>
      _$updateOrderRequestStatusEnumValueOf(name);
}
