//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/merchant.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_merchant_by_id_success_response.g.dart';

/// GetMerchantByIdSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class GetMerchantByIdSuccessResponse
    implements
        Built<GetMerchantByIdSuccessResponse,
            GetMerchantByIdSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetMerchantByIdSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Merchant get data;

  GetMerchantByIdSuccessResponse._();

  factory GetMerchantByIdSuccessResponse(
          [void updates(GetMerchantByIdSuccessResponseBuilder b)]) =
      _$GetMerchantByIdSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetMerchantByIdSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetMerchantByIdSuccessResponse> get serializer =>
      _$GetMerchantByIdSuccessResponseSerializer();
}

class _$GetMerchantByIdSuccessResponseSerializer
    implements PrimitiveSerializer<GetMerchantByIdSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    GetMerchantByIdSuccessResponse,
    _$GetMerchantByIdSuccessResponse
  ];

  @override
  final String wireName = r'GetMerchantByIdSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetMerchantByIdSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetMerchantByIdSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Merchant),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetMerchantByIdSuccessResponse object, {
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
    required GetMerchantByIdSuccessResponseBuilder result,
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
                const FullType(GetMerchantByIdSuccessResponseSuccessEnum),
          ) as GetMerchantByIdSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(Merchant),
          ) as Merchant;
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
  GetMerchantByIdSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetMerchantByIdSuccessResponseBuilder();
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

class GetMerchantByIdSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const GetMerchantByIdSuccessResponseSuccessEnum true_ =
      _$getMerchantByIdSuccessResponseSuccessEnum_true_;

  static Serializer<GetMerchantByIdSuccessResponseSuccessEnum> get serializer =>
      _$getMerchantByIdSuccessResponseSuccessEnumSerializer;

  const GetMerchantByIdSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<GetMerchantByIdSuccessResponseSuccessEnum> get values =>
      _$getMerchantByIdSuccessResponseSuccessEnumValues;
  static GetMerchantByIdSuccessResponseSuccessEnum valueOf(String name) =>
      _$getMerchantByIdSuccessResponseSuccessEnumValueOf(name);
}
