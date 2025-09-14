//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/order.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_order_success_response.g.dart';

/// UpdateOrderSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class UpdateOrderSuccessResponse implements Built<UpdateOrderSuccessResponse, UpdateOrderSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  UpdateOrderSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Order get data;

  UpdateOrderSuccessResponse._();

  factory UpdateOrderSuccessResponse([void updates(UpdateOrderSuccessResponseBuilder b)]) = _$UpdateOrderSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateOrderSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateOrderSuccessResponse> get serializer => _$UpdateOrderSuccessResponseSerializer();
}

class _$UpdateOrderSuccessResponseSerializer implements PrimitiveSerializer<UpdateOrderSuccessResponse> {
  @override
  final Iterable<Type> types = const [UpdateOrderSuccessResponse, _$UpdateOrderSuccessResponse];

  @override
  final String wireName = r'UpdateOrderSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateOrderSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(UpdateOrderSuccessResponseSuccessEnum),
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
    UpdateOrderSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateOrderSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UpdateOrderSuccessResponseSuccessEnum),
          ) as UpdateOrderSuccessResponseSuccessEnum;
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
  UpdateOrderSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateOrderSuccessResponseBuilder();
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

class UpdateOrderSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const UpdateOrderSuccessResponseSuccessEnum true_ = _$updateOrderSuccessResponseSuccessEnum_true_;

  static Serializer<UpdateOrderSuccessResponseSuccessEnum> get serializer => _$updateOrderSuccessResponseSuccessEnumSerializer;

  const UpdateOrderSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<UpdateOrderSuccessResponseSuccessEnum> get values => _$updateOrderSuccessResponseSuccessEnumValues;
  static UpdateOrderSuccessResponseSuccessEnum valueOf(String name) => _$updateOrderSuccessResponseSuccessEnumValueOf(name);
}

