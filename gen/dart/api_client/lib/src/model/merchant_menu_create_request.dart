//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'merchant_menu_create_request.g.dart';

/// MerchantMenuCreateRequest
///
/// Properties:
/// * [merchantId] 
/// * [name] 
/// * [category] 
/// * [price] 
/// * [stock] 
@BuiltValue()
abstract class MerchantMenuCreateRequest implements Built<MerchantMenuCreateRequest, MerchantMenuCreateRequestBuilder> {
  @BuiltValueField(wireName: r'merchantId')
  String get merchantId;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'category')
  String? get category;

  @BuiltValueField(wireName: r'price')
  num get price;

  @BuiltValueField(wireName: r'stock')
  num get stock;

  MerchantMenuCreateRequest._();

  factory MerchantMenuCreateRequest([void updates(MerchantMenuCreateRequestBuilder b)]) = _$MerchantMenuCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MerchantMenuCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MerchantMenuCreateRequest> get serializer => _$MerchantMenuCreateRequestSerializer();
}

class _$MerchantMenuCreateRequestSerializer implements PrimitiveSerializer<MerchantMenuCreateRequest> {
  @override
  final Iterable<Type> types = const [MerchantMenuCreateRequest, _$MerchantMenuCreateRequest];

  @override
  final String wireName = r'MerchantMenuCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MerchantMenuCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'merchantId';
    yield serializers.serialize(
      object.merchantId,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(String),
      );
    }
    yield r'price';
    yield serializers.serialize(
      object.price,
      specifiedType: const FullType(num),
    );
    yield r'stock';
    yield serializers.serialize(
      object.stock,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MerchantMenuCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MerchantMenuCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'merchantId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.merchantId = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.price = valueDes;
          break;
        case r'stock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.stock = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MerchantMenuCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MerchantMenuCreateRequestBuilder();
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

