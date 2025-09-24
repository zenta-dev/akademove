//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ban_user_schema_request.g.dart';

/// BanUserSchemaRequest
///
/// Properties:
/// * [banReason] 
/// * [banExpiresIn] 
@BuiltValue()
abstract class BanUserSchemaRequest implements Built<BanUserSchemaRequest, BanUserSchemaRequestBuilder> {
  @BuiltValueField(wireName: r'banReason')
  String get banReason;

  @BuiltValueField(wireName: r'banExpiresIn')
  num? get banExpiresIn;

  BanUserSchemaRequest._();

  factory BanUserSchemaRequest([void updates(BanUserSchemaRequestBuilder b)]) = _$BanUserSchemaRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BanUserSchemaRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BanUserSchemaRequest> get serializer => _$BanUserSchemaRequestSerializer();
}

class _$BanUserSchemaRequestSerializer implements PrimitiveSerializer<BanUserSchemaRequest> {
  @override
  final Iterable<Type> types = const [BanUserSchemaRequest, _$BanUserSchemaRequest];

  @override
  final String wireName = r'BanUserSchemaRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BanUserSchemaRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'banReason';
    yield serializers.serialize(
      object.banReason,
      specifiedType: const FullType(String),
    );
    if (object.banExpiresIn != null) {
      yield r'banExpiresIn';
      yield serializers.serialize(
        object.banExpiresIn,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BanUserSchemaRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BanUserSchemaRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'banReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.banReason = valueDes;
          break;
        case r'banExpiresIn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.banExpiresIn = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BanUserSchemaRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BanUserSchemaRequestBuilder();
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

