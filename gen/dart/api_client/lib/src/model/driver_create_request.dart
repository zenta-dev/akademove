//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'driver_create_request.g.dart';

/// DriverCreateRequest
///
/// Properties:
/// * [studentId] 
/// * [licenseNumber] 
@BuiltValue()
abstract class DriverCreateRequest implements Built<DriverCreateRequest, DriverCreateRequestBuilder> {
  @BuiltValueField(wireName: r'studentId')
  String get studentId;

  @BuiltValueField(wireName: r'licenseNumber')
  String get licenseNumber;

  DriverCreateRequest._();

  factory DriverCreateRequest([void updates(DriverCreateRequestBuilder b)]) = _$DriverCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DriverCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DriverCreateRequest> get serializer => _$DriverCreateRequestSerializer();
}

class _$DriverCreateRequestSerializer implements PrimitiveSerializer<DriverCreateRequest> {
  @override
  final Iterable<Type> types = const [DriverCreateRequest, _$DriverCreateRequest];

  @override
  final String wireName = r'DriverCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DriverCreateRequest object, {
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
    DriverCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DriverCreateRequestBuilder result,
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
  DriverCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DriverCreateRequestBuilder();
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

