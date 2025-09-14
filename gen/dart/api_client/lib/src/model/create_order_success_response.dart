//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/order.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_order_success_response.g.dart';

/// CreateOrderSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class CreateOrderSuccessResponse implements Built<CreateOrderSuccessResponse, CreateOrderSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  CreateOrderSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Order get data;

  CreateOrderSuccessResponse._();

  factory CreateOrderSuccessResponse([void updates(CreateOrderSuccessResponseBuilder b)]) = _$CreateOrderSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateOrderSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateOrderSuccessResponse> get serializer => _$CreateOrderSuccessResponseSerializer();
}

class _$CreateOrderSuccessResponseSerializer implements PrimitiveSerializer<CreateOrderSuccessResponse> {
  @override
  final Iterable<Type> types = const [CreateOrderSuccessResponse, _$CreateOrderSuccessResponse];

  @override
  final String wireName = r'CreateOrderSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateOrderSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(CreateOrderSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Order),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateOrderSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateOrderSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateOrderSuccessResponseSuccessEnum),
          ) as CreateOrderSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(Order),
          ) as Order;
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
  CreateOrderSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateOrderSuccessResponseBuilder();
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

class CreateOrderSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const CreateOrderSuccessResponseSuccessEnum true_ = _$createOrderSuccessResponseSuccessEnum_true_;

  static Serializer<CreateOrderSuccessResponseSuccessEnum> get serializer => _$createOrderSuccessResponseSuccessEnumSerializer;

  const CreateOrderSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<CreateOrderSuccessResponseSuccessEnum> get values => _$createOrderSuccessResponseSuccessEnumValues;
  static CreateOrderSuccessResponseSuccessEnum valueOf(String name) => _$createOrderSuccessResponseSuccessEnumValueOf(name);
}

