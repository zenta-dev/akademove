//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/location.dart';
import 'package:api_client/src/model/driver_update_request_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_create_request_driver.g.dart';

/// OrderCreateRequestDriver
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [studentId] 
/// * [licenseNumber] 
/// * [status] 
/// * [rating] 
/// * [isOnline] 
/// * [currentLocation] 
/// * [lastLocationUpdate] - unix timestamp format
/// * [createdAt] - unix timestamp format
/// * [user] 
@BuiltValue()
abstract class OrderCreateRequestDriver implements Built<OrderCreateRequestDriver, OrderCreateRequestDriverBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'userId')
  String? get userId;

  @BuiltValueField(wireName: r'studentId')
  String? get studentId;

  @BuiltValueField(wireName: r'licenseNumber')
  String? get licenseNumber;

  @BuiltValueField(wireName: r'status')
  OrderCreateRequestDriverStatusEnum? get status;
  // enum statusEnum {  pending,  approved,  rejected,  active,  inactive,  suspended,  };

  @BuiltValueField(wireName: r'rating')
  num? get rating;

  @BuiltValueField(wireName: r'isOnline')
  bool? get isOnline;

  @BuiltValueField(wireName: r'currentLocation')
  Location? get currentLocation;

  /// unix timestamp format
  @BuiltValueField(wireName: r'lastLocationUpdate')
  num? get lastLocationUpdate;

  /// unix timestamp format
  @BuiltValueField(wireName: r'createdAt')
  num? get createdAt;

  @BuiltValueField(wireName: r'user')
  DriverUpdateRequestUser? get user;

  OrderCreateRequestDriver._();

  factory OrderCreateRequestDriver([void updates(OrderCreateRequestDriverBuilder b)]) = _$OrderCreateRequestDriver;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderCreateRequestDriverBuilder b) => b
      ..status = const OrderCreateRequestDriverStatusEnum._('pending');

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderCreateRequestDriver> get serializer => _$OrderCreateRequestDriverSerializer();
}

class _$OrderCreateRequestDriverSerializer implements PrimitiveSerializer<OrderCreateRequestDriver> {
  @override
  final Iterable<Type> types = const [OrderCreateRequestDriver, _$OrderCreateRequestDriver];

  @override
  final String wireName = r'OrderCreateRequestDriver';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderCreateRequestDriver object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
    if (object.studentId != null) {
      yield r'studentId';
      yield serializers.serialize(
        object.studentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.licenseNumber != null) {
      yield r'licenseNumber';
      yield serializers.serialize(
        object.licenseNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(OrderCreateRequestDriverStatusEnum),
      );
    }
    if (object.rating != null) {
      yield r'rating';
      yield serializers.serialize(
        object.rating,
        specifiedType: const FullType(num),
      );
    }
    if (object.isOnline != null) {
      yield r'isOnline';
      yield serializers.serialize(
        object.isOnline,
        specifiedType: const FullType(bool),
      );
    }
    if (object.currentLocation != null) {
      yield r'currentLocation';
      yield serializers.serialize(
        object.currentLocation,
        specifiedType: const FullType(Location),
      );
    }
    if (object.lastLocationUpdate != null) {
      yield r'lastLocationUpdate';
      yield serializers.serialize(
        object.lastLocationUpdate,
        specifiedType: const FullType(num),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(num),
      );
    }
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType(DriverUpdateRequestUser),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderCreateRequestDriver object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderCreateRequestDriverBuilder result,
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
        case r'studentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.studentId = valueDes;
          break;
        case r'licenseNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.licenseNumber = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderCreateRequestDriverStatusEnum),
          ) as OrderCreateRequestDriverStatusEnum;
          result.status = valueDes;
          break;
        case r'rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.rating = valueDes;
          break;
        case r'isOnline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isOnline = valueDes;
          break;
        case r'currentLocation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Location),
          ) as Location;
          result.currentLocation.replace(valueDes);
          break;
        case r'lastLocationUpdate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.lastLocationUpdate = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.createdAt = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DriverUpdateRequestUser),
          ) as DriverUpdateRequestUser;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderCreateRequestDriver deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderCreateRequestDriverBuilder();
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

class OrderCreateRequestDriverStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const OrderCreateRequestDriverStatusEnum pending = _$orderCreateRequestDriverStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'approved')
  static const OrderCreateRequestDriverStatusEnum approved = _$orderCreateRequestDriverStatusEnum_approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const OrderCreateRequestDriverStatusEnum rejected = _$orderCreateRequestDriverStatusEnum_rejected;
  @BuiltValueEnumConst(wireName: r'active')
  static const OrderCreateRequestDriverStatusEnum active = _$orderCreateRequestDriverStatusEnum_active;
  @BuiltValueEnumConst(wireName: r'inactive')
  static const OrderCreateRequestDriverStatusEnum inactive = _$orderCreateRequestDriverStatusEnum_inactive;
  @BuiltValueEnumConst(wireName: r'suspended')
  static const OrderCreateRequestDriverStatusEnum suspended = _$orderCreateRequestDriverStatusEnum_suspended;

  static Serializer<OrderCreateRequestDriverStatusEnum> get serializer => _$orderCreateRequestDriverStatusEnumSerializer;

  const OrderCreateRequestDriverStatusEnum._(String name): super(name);

  static BuiltSet<OrderCreateRequestDriverStatusEnum> get values => _$orderCreateRequestDriverStatusEnumValues;
  static OrderCreateRequestDriverStatusEnum valueOf(String name) => _$orderCreateRequestDriverStatusEnumValueOf(name);
}

