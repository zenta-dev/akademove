//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unlink_account_post_request.g.dart';

/// UnlinkAccountPostRequest
///
/// Properties:
/// * [providerId] 
/// * [accountId] 
@BuiltValue()
abstract class UnlinkAccountPostRequest implements Built<UnlinkAccountPostRequest, UnlinkAccountPostRequestBuilder> {
  @BuiltValueField(wireName: r'providerId')
  String get providerId;

  @BuiltValueField(wireName: r'accountId')
  String? get accountId;

  UnlinkAccountPostRequest._();

  factory UnlinkAccountPostRequest([void updates(UnlinkAccountPostRequestBuilder b)]) = _$UnlinkAccountPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnlinkAccountPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnlinkAccountPostRequest> get serializer => _$UnlinkAccountPostRequestSerializer();
}

class _$UnlinkAccountPostRequestSerializer implements PrimitiveSerializer<UnlinkAccountPostRequest> {
  @override
  final Iterable<Type> types = const [UnlinkAccountPostRequest, _$UnlinkAccountPostRequest];

  @override
  final String wireName = r'UnlinkAccountPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnlinkAccountPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'providerId';
    yield serializers.serialize(
      object.providerId,
      specifiedType: const FullType(String),
    );
    if (object.accountId != null) {
      yield r'accountId';
      yield serializers.serialize(
        object.accountId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UnlinkAccountPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnlinkAccountPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'providerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.providerId = valueDes;
          break;
        case r'accountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UnlinkAccountPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnlinkAccountPostRequestBuilder();
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

