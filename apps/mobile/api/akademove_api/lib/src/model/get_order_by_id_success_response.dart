//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/order.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_order_by_id_success_response.g.dart';

/// GetOrderByIdSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class GetOrderByIdSuccessResponse
    implements
        Built<GetOrderByIdSuccessResponse, GetOrderByIdSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetOrderByIdSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Order get data;

  GetOrderByIdSuccessResponse._();

  factory GetOrderByIdSuccessResponse(
          [void updates(GetOrderByIdSuccessResponseBuilder b)]) =
      _$GetOrderByIdSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetOrderByIdSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetOrderByIdSuccessResponse> get serializer =>
      _$GetOrderByIdSuccessResponseSerializer();
}

class _$GetOrderByIdSuccessResponseSerializer
    implements PrimitiveSerializer<GetOrderByIdSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    GetOrderByIdSuccessResponse,
    _$GetOrderByIdSuccessResponse
  ];

  @override
  final String wireName = r'GetOrderByIdSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetOrderByIdSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetOrderByIdSuccessResponseSuccessEnum),
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
    GetOrderByIdSuccessResponse object, {
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
    required GetOrderByIdSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(GetOrderByIdSuccessResponseSuccessEnum),
          ) as GetOrderByIdSuccessResponseSuccessEnum;
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
  GetOrderByIdSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetOrderByIdSuccessResponseBuilder();
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

class GetOrderByIdSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const GetOrderByIdSuccessResponseSuccessEnum true_ =
      _$getOrderByIdSuccessResponseSuccessEnum_true_;

  static Serializer<GetOrderByIdSuccessResponseSuccessEnum> get serializer =>
      _$getOrderByIdSuccessResponseSuccessEnumSerializer;

  const GetOrderByIdSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<GetOrderByIdSuccessResponseSuccessEnum> get values =>
      _$getOrderByIdSuccessResponseSuccessEnumValues;
  static GetOrderByIdSuccessResponseSuccessEnum valueOf(String name) =>
      _$getOrderByIdSuccessResponseSuccessEnumValueOf(name);
}
