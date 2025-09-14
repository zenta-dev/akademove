//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_order_request_note.g.dart';

/// CreateOrderRequestNote
///
/// Properties:
/// * [pickup] 
/// * [dropoff] 
@BuiltValue()
abstract class CreateOrderRequestNote implements Built<CreateOrderRequestNote, CreateOrderRequestNoteBuilder> {
  @BuiltValueField(wireName: r'pickup')
  String? get pickup;

  @BuiltValueField(wireName: r'dropoff')
  String? get dropoff;

  CreateOrderRequestNote._();

  factory CreateOrderRequestNote([void updates(CreateOrderRequestNoteBuilder b)]) = _$CreateOrderRequestNote;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateOrderRequestNoteBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateOrderRequestNote> get serializer => _$CreateOrderRequestNoteSerializer();
}

class _$CreateOrderRequestNoteSerializer implements PrimitiveSerializer<CreateOrderRequestNote> {
  @override
  final Iterable<Type> types = const [CreateOrderRequestNote, _$CreateOrderRequestNote];

  @override
  final String wireName = r'CreateOrderRequestNote';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateOrderRequestNote object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.pickup != null) {
      yield r'pickup';
      yield serializers.serialize(
        object.pickup,
        specifiedType: const FullType(String),
      );
    }
    if (object.dropoff != null) {
      yield r'dropoff';
      yield serializers.serialize(
        object.dropoff,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateOrderRequestNote object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateOrderRequestNoteBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'pickup':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pickup = valueDes;
          break;
        case r'dropoff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.dropoff = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateOrderRequestNote deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateOrderRequestNoteBuilder();
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

