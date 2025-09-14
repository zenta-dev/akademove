//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/promo.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_promo_success_response.g.dart';

/// CreatePromoSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class CreatePromoSuccessResponse implements Built<CreatePromoSuccessResponse, CreatePromoSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  CreatePromoSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Promo get data;

  CreatePromoSuccessResponse._();

  factory CreatePromoSuccessResponse([void updates(CreatePromoSuccessResponseBuilder b)]) = _$CreatePromoSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatePromoSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatePromoSuccessResponse> get serializer => _$CreatePromoSuccessResponseSerializer();
}

class _$CreatePromoSuccessResponseSerializer implements PrimitiveSerializer<CreatePromoSuccessResponse> {
  @override
  final Iterable<Type> types = const [CreatePromoSuccessResponse, _$CreatePromoSuccessResponse];

  @override
  final String wireName = r'CreatePromoSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatePromoSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(CreatePromoSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Promo),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreatePromoSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreatePromoSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreatePromoSuccessResponseSuccessEnum),
          ) as CreatePromoSuccessResponseSuccessEnum;
          result.success = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Promo),
          ) as Promo;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreatePromoSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatePromoSuccessResponseBuilder();
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

class CreatePromoSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const CreatePromoSuccessResponseSuccessEnum true_ = _$createPromoSuccessResponseSuccessEnum_true_;

  static Serializer<CreatePromoSuccessResponseSuccessEnum> get serializer => _$createPromoSuccessResponseSuccessEnumSerializer;

  const CreatePromoSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<CreatePromoSuccessResponseSuccessEnum> get values => _$createPromoSuccessResponseSuccessEnumValues;
  static CreatePromoSuccessResponseSuccessEnum valueOf(String name) => _$createPromoSuccessResponseSuccessEnumValueOf(name);
}

