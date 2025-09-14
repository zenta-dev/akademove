//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'time.g.dart';

/// Time
///
/// Properties:
/// * [h] 
/// * [m] 
@BuiltValue()
abstract class Time implements Built<Time, TimeBuilder> {
  @BuiltValueField(wireName: r'h')
  num get h;

  @BuiltValueField(wireName: r'm')
  num get m;

  Time._();

  factory Time([void updates(TimeBuilder b)]) = _$Time;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TimeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Time> get serializer => _$TimeSerializer();
}

class _$TimeSerializer implements PrimitiveSerializer<Time> {
  @override
  final Iterable<Type> types = const [Time, _$Time];

  @override
  final String wireName = r'Time';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Time object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'h';
    yield serializers.serialize(
      object.h,
      specifiedType: const FullType(num),
    );
    yield r'm';
    yield serializers.serialize(
      object.m,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Time object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TimeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'h':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.h = valueDes;
          break;
        case r'm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.m = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Time deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TimeBuilder();
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

