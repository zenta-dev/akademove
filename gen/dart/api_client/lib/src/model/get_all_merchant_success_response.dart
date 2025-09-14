//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/merchant.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_all_merchant_success_response.g.dart';

/// GetAllMerchantSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class GetAllMerchantSuccessResponse implements Built<GetAllMerchantSuccessResponse, GetAllMerchantSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetAllMerchantSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Merchant> get data;

  GetAllMerchantSuccessResponse._();

  factory GetAllMerchantSuccessResponse([void updates(GetAllMerchantSuccessResponseBuilder b)]) = _$GetAllMerchantSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetAllMerchantSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetAllMerchantSuccessResponse> get serializer => _$GetAllMerchantSuccessResponseSerializer();
}

class _$GetAllMerchantSuccessResponseSerializer implements PrimitiveSerializer<GetAllMerchantSuccessResponse> {
  @override
  final Iterable<Type> types = const [GetAllMerchantSuccessResponse, _$GetAllMerchantSuccessResponse];

  @override
  final String wireName = r'GetAllMerchantSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetAllMerchantSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetAllMerchantSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(Merchant)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetAllMerchantSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetAllMerchantSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GetAllMerchantSuccessResponseSuccessEnum),
          ) as GetAllMerchantSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(BuiltList, [FullType(Merchant)]),
          ) as BuiltList<Merchant>;
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
  GetAllMerchantSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetAllMerchantSuccessResponseBuilder();
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

class GetAllMerchantSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const GetAllMerchantSuccessResponseSuccessEnum true_ = _$getAllMerchantSuccessResponseSuccessEnum_true_;

  static Serializer<GetAllMerchantSuccessResponseSuccessEnum> get serializer => _$getAllMerchantSuccessResponseSuccessEnumSerializer;

  const GetAllMerchantSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<GetAllMerchantSuccessResponseSuccessEnum> get values => _$getAllMerchantSuccessResponseSuccessEnumValues;
  static GetAllMerchantSuccessResponseSuccessEnum valueOf(String name) => _$getAllMerchantSuccessResponseSuccessEnumValueOf(name);
}

