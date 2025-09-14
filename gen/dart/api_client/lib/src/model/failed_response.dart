//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'failed_response.g.dart';

/// FailedResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [errors] 
@BuiltValue()
abstract class FailedResponse implements Built<FailedResponse, FailedResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  FailedResponseSuccessEnum get success;
  // enum successEnum {  false,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'errors')
  BuiltList<String> get errors;

  FailedResponse._();

  factory FailedResponse([void updates(FailedResponseBuilder b)]) = _$FailedResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FailedResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FailedResponse> get serializer => _$FailedResponseSerializer();
}

class _$FailedResponseSerializer implements PrimitiveSerializer<FailedResponse> {
  @override
  final Iterable<Type> types = const [FailedResponse, _$FailedResponse];

  @override
  final String wireName = r'FailedResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FailedResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(FailedResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'errors';
    yield serializers.serialize(
      object.errors,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FailedResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FailedResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FailedResponseSuccessEnum),
          ) as FailedResponseSuccessEnum;
          result.success = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.errors.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FailedResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FailedResponseBuilder();
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

class FailedResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'false')
  static const FailedResponseSuccessEnum false_ = _$failedResponseSuccessEnum_false_;

  static Serializer<FailedResponseSuccessEnum> get serializer => _$failedResponseSuccessEnumSerializer;

  const FailedResponseSuccessEnum._(String name): super(name);

  static BuiltSet<FailedResponseSuccessEnum> get values => _$failedResponseSuccessEnumValues;
  static FailedResponseSuccessEnum valueOf(String name) => _$failedResponseSuccessEnumValueOf(name);
}

