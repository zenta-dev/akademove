//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'promo.g.dart';

/// Promo
///
/// Properties:
/// * [id]
/// * [name]
/// * [code]
/// * [rules]
/// * [discountAmount]
/// * [discountPercentage]
/// * [minOrderAmount]
/// * [maxOrderAmount]
/// * [usageLimit]
/// * [usedCount]
/// * [periodStart] - unix timestamp format
/// * [periodEnd] - unix timestamp format
/// * [isActive]
/// * [createdById]
/// * [createdAt] - unix timestamp format
@BuiltValue()
abstract class Promo implements Built<Promo, PromoBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'rules')
  JsonObject? get rules;

  @BuiltValueField(wireName: r'discountAmount')
  num get discountAmount;

  @BuiltValueField(wireName: r'discountPercentage')
  num get discountPercentage;

  @BuiltValueField(wireName: r'minOrderAmount')
  num get minOrderAmount;

  @BuiltValueField(wireName: r'maxOrderAmount')
  num get maxOrderAmount;

  @BuiltValueField(wireName: r'usageLimit')
  num get usageLimit;

  @BuiltValueField(wireName: r'usedCount')
  num get usedCount;

  /// unix timestamp format
  @BuiltValueField(wireName: r'periodStart')
  num get periodStart;

  /// unix timestamp format
  @BuiltValueField(wireName: r'periodEnd')
  num get periodEnd;

  @BuiltValueField(wireName: r'isActive')
  bool get isActive;

  @BuiltValueField(wireName: r'createdById')
  String get createdById;

  /// unix timestamp format
  @BuiltValueField(wireName: r'createdAt')
  num get createdAt;

  Promo._();

  factory Promo([void updates(PromoBuilder b)]) = _$Promo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PromoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Promo> get serializer => _$PromoSerializer();
}

class _$PromoSerializer implements PrimitiveSerializer<Promo> {
  @override
  final Iterable<Type> types = const [Promo, _$Promo];

  @override
  final String wireName = r'Promo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Promo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'rules';
    yield object.rules == null
        ? null
        : serializers.serialize(
            object.rules,
            specifiedType: const FullType.nullable(JsonObject),
          );
    yield r'discountAmount';
    yield serializers.serialize(
      object.discountAmount,
      specifiedType: const FullType(num),
    );
    yield r'discountPercentage';
    yield serializers.serialize(
      object.discountPercentage,
      specifiedType: const FullType(num),
    );
    yield r'minOrderAmount';
    yield serializers.serialize(
      object.minOrderAmount,
      specifiedType: const FullType(num),
    );
    yield r'maxOrderAmount';
    yield serializers.serialize(
      object.maxOrderAmount,
      specifiedType: const FullType(num),
    );
    yield r'usageLimit';
    yield serializers.serialize(
      object.usageLimit,
      specifiedType: const FullType(num),
    );
    yield r'usedCount';
    yield serializers.serialize(
      object.usedCount,
      specifiedType: const FullType(num),
    );
    yield r'periodStart';
    yield serializers.serialize(
      object.periodStart,
      specifiedType: const FullType(num),
    );
    yield r'periodEnd';
    yield serializers.serialize(
      object.periodEnd,
      specifiedType: const FullType(num),
    );
    yield r'isActive';
    yield serializers.serialize(
      object.isActive,
      specifiedType: const FullType(bool),
    );
    yield r'createdById';
    yield serializers.serialize(
      object.createdById,
      specifiedType: const FullType(String),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Promo object, {
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
    required PromoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'rules':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.rules = valueDes;
          break;
        case r'discountAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.discountAmount = valueDes;
          break;
        case r'discountPercentage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.discountPercentage = valueDes;
          break;
        case r'minOrderAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minOrderAmount = valueDes;
          break;
        case r'maxOrderAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.maxOrderAmount = valueDes;
          break;
        case r'usageLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.usageLimit = valueDes;
          break;
        case r'usedCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.usedCount = valueDes;
          break;
        case r'periodStart':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.periodStart = valueDes;
          break;
        case r'periodEnd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.periodEnd = valueDes;
          break;
        case r'isActive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        case r'createdById':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createdById = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Promo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PromoBuilder();
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
