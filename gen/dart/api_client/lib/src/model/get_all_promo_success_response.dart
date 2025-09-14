//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/promo.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_all_promo_success_response.g.dart';

/// GetAllPromoSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class GetAllPromoSuccessResponse implements Built<GetAllPromoSuccessResponse, GetAllPromoSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetAllPromoSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Promo> get data;

  GetAllPromoSuccessResponse._();

  factory GetAllPromoSuccessResponse([void updates(GetAllPromoSuccessResponseBuilder b)]) = _$GetAllPromoSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetAllPromoSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetAllPromoSuccessResponse> get serializer => _$GetAllPromoSuccessResponseSerializer();
}

class _$GetAllPromoSuccessResponseSerializer implements PrimitiveSerializer<GetAllPromoSuccessResponse> {
  @override
  final Iterable<Type> types = const [GetAllPromoSuccessResponse, _$GetAllPromoSuccessResponse];

  @override
  final String wireName = r'GetAllPromoSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetAllPromoSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetAllPromoSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(Promo)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetAllPromoSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetAllPromoSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GetAllPromoSuccessResponseSuccessEnum),
          ) as GetAllPromoSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(BuiltList, [FullType(Promo)]),
          ) as BuiltList<Promo>;
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
  GetAllPromoSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetAllPromoSuccessResponseBuilder();
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

class GetAllPromoSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const GetAllPromoSuccessResponseSuccessEnum true_ = _$getAllPromoSuccessResponseSuccessEnum_true_;

  static Serializer<GetAllPromoSuccessResponseSuccessEnum> get serializer => _$getAllPromoSuccessResponseSuccessEnumSerializer;

  const GetAllPromoSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<GetAllPromoSuccessResponseSuccessEnum> get values => _$getAllPromoSuccessResponseSuccessEnumValues;
  static GetAllPromoSuccessResponseSuccessEnum valueOf(String name) => _$getAllPromoSuccessResponseSuccessEnumValueOf(name);
}

