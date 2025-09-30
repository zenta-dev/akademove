//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/location.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'merchant_create_request.g.dart';

/// MerchantCreateRequest
///
/// Properties:
/// * [type] 
/// * [name] 
/// * [address] 
/// * [location] 
/// * [isActive] 
@BuiltValue()
abstract class MerchantCreateRequest implements Built<MerchantCreateRequest, MerchantCreateRequestBuilder> {
  @BuiltValueField(wireName: r'type')
  MerchantCreateRequestTypeEnum? get type;
  // enum typeEnum {  merchant,  tenant,  };

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'address')
  String get address;

  @BuiltValueField(wireName: r'location')
  Location? get location;

  @BuiltValueField(wireName: r'isActive')
  bool get isActive;

  MerchantCreateRequest._();

  factory MerchantCreateRequest([void updates(MerchantCreateRequestBuilder b)]) = _$MerchantCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MerchantCreateRequestBuilder b) => b
      ..type = const MerchantCreateRequestTypeEnum._('merchant');

  @BuiltValueSerializer(custom: true)
  static Serializer<MerchantCreateRequest> get serializer => _$MerchantCreateRequestSerializer();
}

class _$MerchantCreateRequestSerializer implements PrimitiveSerializer<MerchantCreateRequest> {
  @override
  final Iterable<Type> types = const [MerchantCreateRequest, _$MerchantCreateRequest];

  @override
  final String wireName = r'MerchantCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MerchantCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(MerchantCreateRequestTypeEnum),
      );
    }
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'address';
    yield serializers.serialize(
      object.address,
      specifiedType: const FullType(String),
    );
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType(Location),
      );
    }
    yield r'isActive';
    yield serializers.serialize(
      object.isActive,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MerchantCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MerchantCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MerchantCreateRequestTypeEnum),
          ) as MerchantCreateRequestTypeEnum;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MerchantCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MerchantCreateRequestBuilder();
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

class MerchantCreateRequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'merchant')
  static const MerchantCreateRequestTypeEnum merchant = _$merchantCreateRequestTypeEnum_merchant;
  @BuiltValueEnumConst(wireName: r'tenant')
  static const MerchantCreateRequestTypeEnum tenant = _$merchantCreateRequestTypeEnum_tenant;

  static Serializer<MerchantCreateRequestTypeEnum> get serializer => _$merchantCreateRequestTypeEnumSerializer;

  const MerchantCreateRequestTypeEnum._(String name): super(name);

  static BuiltSet<MerchantCreateRequestTypeEnum> get values => _$merchantCreateRequestTypeEnumValues;
  static MerchantCreateRequestTypeEnum valueOf(String name) => _$merchantCreateRequestTypeEnumValueOf(name);
}

