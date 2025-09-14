//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/location.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_merchant_request.g.dart';

/// CreateMerchantRequest
///
/// Properties:
/// * [type]
/// * [name]
/// * [address]
/// * [location]
/// * [isActive]
@BuiltValue()
abstract class CreateMerchantRequest
    implements Built<CreateMerchantRequest, CreateMerchantRequestBuilder> {
  @BuiltValueField(wireName: r'type')
  CreateMerchantRequestTypeEnum get type;
  // enum typeEnum {  merchant,  tenant,  };

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'address')
  String get address;

  @BuiltValueField(wireName: r'location')
  Location? get location;

  @BuiltValueField(wireName: r'isActive')
  bool? get isActive;

  CreateMerchantRequest._();

  factory CreateMerchantRequest(
      [void updates(CreateMerchantRequestBuilder b)]) = _$CreateMerchantRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateMerchantRequestBuilder b) => b..isActive = true;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateMerchantRequest> get serializer =>
      _$CreateMerchantRequestSerializer();
}

class _$CreateMerchantRequestSerializer
    implements PrimitiveSerializer<CreateMerchantRequest> {
  @override
  final Iterable<Type> types = const [
    CreateMerchantRequest,
    _$CreateMerchantRequest
  ];

  @override
  final String wireName = r'CreateMerchantRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateMerchantRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(CreateMerchantRequestTypeEnum),
    );
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
    yield r'location';
    yield object.location == null
        ? null
        : serializers.serialize(
            object.location,
            specifiedType: const FullType.nullable(Location),
          );
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
    CreateMerchantRequest object, {
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
    required CreateMerchantRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateMerchantRequestTypeEnum),
          ) as CreateMerchantRequestTypeEnum;
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
            specifiedType: const FullType.nullable(Location),
          ) as Location?;
          if (valueDes == null) continue;
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
  CreateMerchantRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateMerchantRequestBuilder();
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

class CreateMerchantRequestTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'merchant')
  static const CreateMerchantRequestTypeEnum merchant =
      _$createMerchantRequestTypeEnum_merchant;
  @BuiltValueEnumConst(wireName: r'tenant')
  static const CreateMerchantRequestTypeEnum tenant =
      _$createMerchantRequestTypeEnum_tenant;

  static Serializer<CreateMerchantRequestTypeEnum> get serializer =>
      _$createMerchantRequestTypeEnumSerializer;

  const CreateMerchantRequestTypeEnum._(String name) : super(name);

  static BuiltSet<CreateMerchantRequestTypeEnum> get values =>
      _$createMerchantRequestTypeEnumValues;
  static CreateMerchantRequestTypeEnum valueOf(String name) =>
      _$createMerchantRequestTypeEnumValueOf(name);
}
