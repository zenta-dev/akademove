//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_driver_request.g.dart';

/// CreateDriverRequest
///
/// Properties:
/// * [studentId] 
/// * [licenseNumber] 
@BuiltValue()
abstract class CreateDriverRequest implements Built<CreateDriverRequest, CreateDriverRequestBuilder> {
  @BuiltValueField(wireName: r'studentId')
  String get studentId;

  @BuiltValueField(wireName: r'licenseNumber')
  String get licenseNumber;

  CreateDriverRequest._();

  factory CreateDriverRequest([void updates(CreateDriverRequestBuilder b)]) = _$CreateDriverRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateDriverRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateDriverRequest> get serializer => _$CreateDriverRequestSerializer();
}

class _$CreateDriverRequestSerializer implements PrimitiveSerializer<CreateDriverRequest> {
  @override
  final Iterable<Type> types = const [CreateDriverRequest, _$CreateDriverRequest];

  @override
  final String wireName = r'CreateDriverRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateDriverRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'studentId';
    yield serializers.serialize(
      object.studentId,
      specifiedType: const FullType(String),
    );
    yield r'licenseNumber';
    yield serializers.serialize(
      object.licenseNumber,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateDriverRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateDriverRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'studentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.studentId = valueDes;
          break;
        case r'licenseNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.licenseNumber = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateDriverRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateDriverRequestBuilder();
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

