//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/merchant.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_merchant_success_response.g.dart';

/// CreateMerchantSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class CreateMerchantSuccessResponse
    implements
        Built<CreateMerchantSuccessResponse,
            CreateMerchantSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  CreateMerchantSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Merchant get data;

  CreateMerchantSuccessResponse._();

  factory CreateMerchantSuccessResponse(
          [void updates(CreateMerchantSuccessResponseBuilder b)]) =
      _$CreateMerchantSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateMerchantSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateMerchantSuccessResponse> get serializer =>
      _$CreateMerchantSuccessResponseSerializer();
}

class _$CreateMerchantSuccessResponseSerializer
    implements PrimitiveSerializer<CreateMerchantSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    CreateMerchantSuccessResponse,
    _$CreateMerchantSuccessResponse
  ];

  @override
  final String wireName = r'CreateMerchantSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateMerchantSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(CreateMerchantSuccessResponseSuccessEnum),
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
    CreateMerchantSuccessResponse object, {
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
    required CreateMerchantSuccessResponseBuilder result,
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
                const FullType(CreateMerchantSuccessResponseSuccessEnum),
          ) as CreateMerchantSuccessResponseSuccessEnum;
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
  CreateMerchantSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateMerchantSuccessResponseBuilder();
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

class CreateMerchantSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const CreateMerchantSuccessResponseSuccessEnum true_ =
      _$createMerchantSuccessResponseSuccessEnum_true_;

  static Serializer<CreateMerchantSuccessResponseSuccessEnum> get serializer =>
      _$createMerchantSuccessResponseSuccessEnumSerializer;

  const CreateMerchantSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<CreateMerchantSuccessResponseSuccessEnum> get values =>
      _$createMerchantSuccessResponseSuccessEnumValues;
  static CreateMerchantSuccessResponseSuccessEnum valueOf(String name) =>
      _$createMerchantSuccessResponseSuccessEnumValueOf(name);
}
