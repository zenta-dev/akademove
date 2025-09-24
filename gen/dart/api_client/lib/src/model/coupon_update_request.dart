//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coupon_create_request_rules.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'coupon_update_request.g.dart';

/// CouponUpdateRequest
///
/// Properties:
/// * [name] 
/// * [code] 
/// * [rules] 
/// * [discountAmount] 
/// * [discountPercentage] 
/// * [usageLimit] 
/// * [periodStart] - unix timestamp format
/// * [periodEnd] - unix timestamp format
/// * [isActive] 
@BuiltValue()
abstract class CouponUpdateRequest implements Built<CouponUpdateRequest, CouponUpdateRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'code')
  String? get code;

  @BuiltValueField(wireName: r'rules')
  CouponCreateRequestRules? get rules;

  @BuiltValueField(wireName: r'discountAmount')
  num? get discountAmount;

  @BuiltValueField(wireName: r'discountPercentage')
  num? get discountPercentage;

  @BuiltValueField(wireName: r'usageLimit')
  num? get usageLimit;

  /// unix timestamp format
  @BuiltValueField(wireName: r'periodStart')
  num? get periodStart;

  /// unix timestamp format
  @BuiltValueField(wireName: r'periodEnd')
  num? get periodEnd;

  @BuiltValueField(wireName: r'isActive')
  bool? get isActive;

  CouponUpdateRequest._();

  factory CouponUpdateRequest([void updates(CouponUpdateRequestBuilder b)]) = _$CouponUpdateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CouponUpdateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CouponUpdateRequest> get serializer => _$CouponUpdateRequestSerializer();
}

class _$CouponUpdateRequestSerializer implements PrimitiveSerializer<CouponUpdateRequest> {
  @override
  final Iterable<Type> types = const [CouponUpdateRequest, _$CouponUpdateRequest];

  @override
  final String wireName = r'CouponUpdateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CouponUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(String),
      );
    }
    if (object.rules != null) {
      yield r'rules';
      yield serializers.serialize(
        object.rules,
        specifiedType: const FullType(CouponCreateRequestRules),
      );
    }
    if (object.discountAmount != null) {
      yield r'discountAmount';
      yield serializers.serialize(
        object.discountAmount,
        specifiedType: const FullType(num),
      );
    }
    if (object.discountPercentage != null) {
      yield r'discountPercentage';
      yield serializers.serialize(
        object.discountPercentage,
        specifiedType: const FullType(num),
      );
    }
    if (object.usageLimit != null) {
      yield r'usageLimit';
      yield serializers.serialize(
        object.usageLimit,
        specifiedType: const FullType(num),
      );
    }
    if (object.periodStart != null) {
      yield r'periodStart';
      yield serializers.serialize(
        object.periodStart,
        specifiedType: const FullType(num),
      );
    }
    if (object.periodEnd != null) {
      yield r'periodEnd';
      yield serializers.serialize(
        object.periodEnd,
        specifiedType: const FullType(num),
      );
    }
    if (object.isActive != null) {
      yield r'isActive';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CouponUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CouponUpdateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(CouponCreateRequestRules),
          ) as CouponCreateRequestRules;
          result.rules.replace(valueDes);
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
        case r'usageLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.usageLimit = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CouponUpdateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CouponUpdateRequestBuilder();
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

