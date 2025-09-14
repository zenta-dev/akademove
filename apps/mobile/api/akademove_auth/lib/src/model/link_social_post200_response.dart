//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_social_post200_response.g.dart';

/// LinkSocialPost200Response
///
/// Properties:
/// * [redirect] - Indicates if the user should be redirected to the authorization URL
/// * [url] - The authorization URL to redirect the user to
/// * [status]
@BuiltValue()
abstract class LinkSocialPost200Response
    implements
        Built<LinkSocialPost200Response, LinkSocialPost200ResponseBuilder> {
  /// Indicates if the user should be redirected to the authorization URL
  @BuiltValueField(wireName: r'redirect')
  bool get redirect;

  /// The authorization URL to redirect the user to
  @BuiltValueField(wireName: r'url')
  String? get url;

  @BuiltValueField(wireName: r'status')
  bool? get status;

  LinkSocialPost200Response._();

  factory LinkSocialPost200Response(
          [void updates(LinkSocialPost200ResponseBuilder b)]) =
      _$LinkSocialPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkSocialPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkSocialPost200Response> get serializer =>
      _$LinkSocialPost200ResponseSerializer();
}

class _$LinkSocialPost200ResponseSerializer
    implements PrimitiveSerializer<LinkSocialPost200Response> {
  @override
  final Iterable<Type> types = const [
    LinkSocialPost200Response,
    _$LinkSocialPost200Response
  ];

  @override
  final String wireName = r'LinkSocialPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkSocialPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'redirect';
    yield serializers.serialize(
      object.redirect,
      specifiedType: const FullType(bool),
    );
    if (object.url != null) {
      yield r'url';
      yield serializers.serialize(
        object.url,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkSocialPost200Response object, {
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
    required LinkSocialPost200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'redirect':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.redirect = valueDes;
          break;
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkSocialPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkSocialPost200ResponseBuilder();
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
