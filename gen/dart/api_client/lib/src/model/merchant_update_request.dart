//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/location.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'merchant_update_request.g.dart';

/// MerchantUpdateRequest
///
/// Properties:
/// * [type] 
/// * [name] 
/// * [address] 
/// * [location] 
/// * [isActive] 
@BuiltValue()
abstract class MerchantUpdateRequest implements Built<MerchantUpdateRequest, MerchantUpdateRequestBuilder> {
  @BuiltValueField(wireName: r'type')
  MerchantUpdateRequestTypeEnum? get type;
  // enum typeEnum {  merchant,  tenant,  };

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'location')
  Location? get location;

  @BuiltValueField(wireName: r'isActive')
  bool? get isActive;

  MerchantUpdateRequest._();

  factory MerchantUpdateRequest([void updates(MerchantUpdateRequestBuilder b)]) = _$MerchantUpdateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MerchantUpdateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MerchantUpdateRequest> get serializer => _$MerchantUpdateRequestSerializer();
}

class _$MerchantUpdateRequestSerializer implements PrimitiveSerializer<MerchantUpdateRequest> {
  @override
  final Iterable<Type> types = const [MerchantUpdateRequest, _$MerchantUpdateRequest];

  @override
  final String wireName = r'MerchantUpdateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MerchantUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(MerchantUpdateRequestTypeEnum),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    MerchantUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MerchantUpdateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MerchantUpdateRequestTypeEnum),
          ) as MerchantUpdateRequestTypeEnum;
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
  MerchantUpdateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MerchantUpdateRequestBuilder();
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

class MerchantUpdateRequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'merchant')
  static const MerchantUpdateRequestTypeEnum merchant = _$merchantUpdateRequestTypeEnum_merchant;
  @BuiltValueEnumConst(wireName: r'tenant')
  static const MerchantUpdateRequestTypeEnum tenant = _$merchantUpdateRequestTypeEnum_tenant;

  static Serializer<MerchantUpdateRequestTypeEnum> get serializer => _$merchantUpdateRequestTypeEnumSerializer;

  const MerchantUpdateRequestTypeEnum._(String name): super(name);

  static BuiltSet<MerchantUpdateRequestTypeEnum> get values => _$merchantUpdateRequestTypeEnumValues;
  static MerchantUpdateRequestTypeEnum valueOf(String name) => _$merchantUpdateRequestTypeEnumValueOf(name);
}

