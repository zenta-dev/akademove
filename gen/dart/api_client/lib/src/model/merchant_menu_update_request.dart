//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'merchant_menu_update_request.g.dart';

/// MerchantMenuUpdateRequest
///
/// Properties:
/// * [merchantId] 
/// * [name] 
/// * [category] 
/// * [price] 
/// * [stock] 
@BuiltValue()
abstract class MerchantMenuUpdateRequest implements Built<MerchantMenuUpdateRequest, MerchantMenuUpdateRequestBuilder> {
  @BuiltValueField(wireName: r'merchantId')
  String? get merchantId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'category')
  String? get category;

  @BuiltValueField(wireName: r'price')
  num? get price;

  @BuiltValueField(wireName: r'stock')
  num? get stock;

  MerchantMenuUpdateRequest._();

  factory MerchantMenuUpdateRequest([void updates(MerchantMenuUpdateRequestBuilder b)]) = _$MerchantMenuUpdateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MerchantMenuUpdateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MerchantMenuUpdateRequest> get serializer => _$MerchantMenuUpdateRequestSerializer();
}

class _$MerchantMenuUpdateRequestSerializer implements PrimitiveSerializer<MerchantMenuUpdateRequest> {
  @override
  final Iterable<Type> types = const [MerchantMenuUpdateRequest, _$MerchantMenuUpdateRequest];

  @override
  final String wireName = r'MerchantMenuUpdateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MerchantMenuUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.merchantId != null) {
      yield r'merchantId';
      yield serializers.serialize(
        object.merchantId,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(String),
      );
    }
    if (object.price != null) {
      yield r'price';
      yield serializers.serialize(
        object.price,
        specifiedType: const FullType(num),
      );
    }
    if (object.stock != null) {
      yield r'stock';
      yield serializers.serialize(
        object.stock,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MerchantMenuUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MerchantMenuUpdateRequestBuilder result,
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
  MerchantMenuUpdateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MerchantMenuUpdateRequestBuilder();
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

