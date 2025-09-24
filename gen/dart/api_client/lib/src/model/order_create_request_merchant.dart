//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/location.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_create_request_merchant.g.dart';

/// OrderCreateRequestMerchant
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [type] 
/// * [name] 
/// * [address] 
/// * [location] 
/// * [isActive] 
/// * [rating] 
/// * [createdAt] - unix timestamp format
/// * [updatedAt] - unix timestamp format
@BuiltValue()
abstract class OrderCreateRequestMerchant implements Built<OrderCreateRequestMerchant, OrderCreateRequestMerchantBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'userId')
  String? get userId;

  @BuiltValueField(wireName: r'type')
  OrderCreateRequestMerchantTypeEnum? get type;
  // enum typeEnum {  merchant,  tenant,  };

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'location')
  Location? get location;

  @BuiltValueField(wireName: r'isActive')
  bool? get isActive;

  @BuiltValueField(wireName: r'rating')
  num? get rating;

  /// unix timestamp format
  @BuiltValueField(wireName: r'createdAt')
  num? get createdAt;

  /// unix timestamp format
  @BuiltValueField(wireName: r'updatedAt')
  num? get updatedAt;

  OrderCreateRequestMerchant._();

  factory OrderCreateRequestMerchant([void updates(OrderCreateRequestMerchantBuilder b)]) = _$OrderCreateRequestMerchant;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderCreateRequestMerchantBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderCreateRequestMerchant> get serializer => _$OrderCreateRequestMerchantSerializer();
}

class _$OrderCreateRequestMerchantSerializer implements PrimitiveSerializer<OrderCreateRequestMerchant> {
  @override
  final Iterable<Type> types = const [OrderCreateRequestMerchant, _$OrderCreateRequestMerchant];

  @override
  final String wireName = r'OrderCreateRequestMerchant';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderCreateRequestMerchant object, {
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
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(OrderCreateRequestMerchantTypeEnum),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType(String),
      );
    }
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType(Location),
      );
    }
    if (object.isActive != null) {
      yield r'isActive';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
    if (object.rating != null) {
      yield r'rating';
      yield serializers.serialize(
        object.rating,
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
    if (object.updatedAt != null) {
      yield r'updatedAt';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderCreateRequestMerchant object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderCreateRequestMerchantBuilder result,
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
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderCreateRequestMerchantTypeEnum),
          ) as OrderCreateRequestMerchantTypeEnum;
          result.type = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.address = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Location),
          ) as Location;
          result.location.replace(valueDes);
          break;
        case r'isActive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        case r'rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.rating = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderCreateRequestMerchant deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderCreateRequestMerchantBuilder();
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

class OrderCreateRequestMerchantTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'merchant')
  static const OrderCreateRequestMerchantTypeEnum merchant = _$orderCreateRequestMerchantTypeEnum_merchant;
  @BuiltValueEnumConst(wireName: r'tenant')
  static const OrderCreateRequestMerchantTypeEnum tenant = _$orderCreateRequestMerchantTypeEnum_tenant;

  static Serializer<OrderCreateRequestMerchantTypeEnum> get serializer => _$orderCreateRequestMerchantTypeEnumSerializer;

  const OrderCreateRequestMerchantTypeEnum._(String name): super(name);

  static BuiltSet<OrderCreateRequestMerchantTypeEnum> get values => _$orderCreateRequestMerchantTypeEnumValues;
  static OrderCreateRequestMerchantTypeEnum valueOf(String name) => _$orderCreateRequestMerchantTypeEnumValueOf(name);
}

