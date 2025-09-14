//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/order.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_all_order_success_response.g.dart';

/// GetAllOrderSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class GetAllOrderSuccessResponse
    implements
        Built<GetAllOrderSuccessResponse, GetAllOrderSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetAllOrderSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Order> get data;

  GetAllOrderSuccessResponse._();

  factory GetAllOrderSuccessResponse(
          [void updates(GetAllOrderSuccessResponseBuilder b)]) =
      _$GetAllOrderSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetAllOrderSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetAllOrderSuccessResponse> get serializer =>
      _$GetAllOrderSuccessResponseSerializer();
}

class _$GetAllOrderSuccessResponseSerializer
    implements PrimitiveSerializer<GetAllOrderSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    GetAllOrderSuccessResponse,
    _$GetAllOrderSuccessResponse
  ];

  @override
  final String wireName = r'GetAllOrderSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetAllOrderSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetAllOrderSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(Order)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetAllOrderSuccessResponse object, {
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
    required GetAllOrderSuccessResponseBuilder result,
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
                const FullType(GetAllOrderSuccessResponseSuccessEnum),
          ) as GetAllOrderSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(BuiltList, [FullType(Order)]),
          ) as BuiltList<Order>;
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
  GetAllOrderSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetAllOrderSuccessResponseBuilder();
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

class GetAllOrderSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const GetAllOrderSuccessResponseSuccessEnum true_ =
      _$getAllOrderSuccessResponseSuccessEnum_true_;

  static Serializer<GetAllOrderSuccessResponseSuccessEnum> get serializer =>
      _$getAllOrderSuccessResponseSuccessEnumSerializer;

  const GetAllOrderSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<GetAllOrderSuccessResponseSuccessEnum> get values =>
      _$getAllOrderSuccessResponseSuccessEnumValues;
  static GetAllOrderSuccessResponseSuccessEnum valueOf(String name) =>
      _$getAllOrderSuccessResponseSuccessEnumValueOf(name);
}
