//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_create_request_note.g.dart';

/// OrderCreateRequestNote
///
/// Properties:
/// * [pickup] 
/// * [dropoff] 
@BuiltValue()
abstract class OrderCreateRequestNote implements Built<OrderCreateRequestNote, OrderCreateRequestNoteBuilder> {
  @BuiltValueField(wireName: r'pickup')
  String? get pickup;

  @BuiltValueField(wireName: r'dropoff')
  String? get dropoff;

  OrderCreateRequestNote._();

  factory OrderCreateRequestNote([void updates(OrderCreateRequestNoteBuilder b)]) = _$OrderCreateRequestNote;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderCreateRequestNoteBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderCreateRequestNote> get serializer => _$OrderCreateRequestNoteSerializer();
}

class _$OrderCreateRequestNoteSerializer implements PrimitiveSerializer<OrderCreateRequestNote> {
  @override
  final Iterable<Type> types = const [OrderCreateRequestNote, _$OrderCreateRequestNote];

  @override
  final String wireName = r'OrderCreateRequestNote';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderCreateRequestNote object, {
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
    OrderCreateRequestNote object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderCreateRequestNoteBuilder result,
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
  OrderCreateRequestNote deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderCreateRequestNoteBuilder();
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

