//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:auth_client/src/model/link_social_post_request_id_token.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_social_post_request.g.dart';

/// LinkSocialPostRequest
///
/// Properties:
/// * [callbackURL] - The URL to redirect to after the user has signed in
/// * [provider] 
/// * [idToken] 
/// * [requestSignUp] 
/// * [scopes] - Additional scopes to request from the provider
/// * [errorCallbackURL] - The URL to redirect to if there is an error during the link process
/// * [disableRedirect] - Disable automatic redirection to the provider. Useful for handling the redirection yourself
@BuiltValue()
abstract class LinkSocialPostRequest implements Built<LinkSocialPostRequest, LinkSocialPostRequestBuilder> {
  /// The URL to redirect to after the user has signed in
  @BuiltValueField(wireName: r'callbackURL')
  String? get callbackURL;

  @BuiltValueField(wireName: r'provider')
  String get provider;

  @BuiltValueField(wireName: r'idToken')
  LinkSocialPostRequestIdToken? get idToken;

  @BuiltValueField(wireName: r'requestSignUp')
  bool? get requestSignUp;

  /// Additional scopes to request from the provider
  @BuiltValueField(wireName: r'scopes')
  BuiltList<JsonObject?>? get scopes;

  /// The URL to redirect to if there is an error during the link process
  @BuiltValueField(wireName: r'errorCallbackURL')
  String? get errorCallbackURL;

  /// Disable automatic redirection to the provider. Useful for handling the redirection yourself
  @BuiltValueField(wireName: r'disableRedirect')
  bool? get disableRedirect;

  LinkSocialPostRequest._();

  factory LinkSocialPostRequest([void updates(LinkSocialPostRequestBuilder b)]) = _$LinkSocialPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkSocialPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkSocialPostRequest> get serializer => _$LinkSocialPostRequestSerializer();
}

class _$LinkSocialPostRequestSerializer implements PrimitiveSerializer<LinkSocialPostRequest> {
  @override
  final Iterable<Type> types = const [LinkSocialPostRequest, _$LinkSocialPostRequest];

  @override
  final String wireName = r'LinkSocialPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkSocialPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.callbackURL != null) {
      yield r'callbackURL';
      yield serializers.serialize(
        object.callbackURL,
        specifiedType: const FullType(String),
      );
    }
    yield r'provider';
    yield serializers.serialize(
      object.provider,
      specifiedType: const FullType(String),
    );
    if (object.idToken != null) {
      yield r'idToken';
      yield serializers.serialize(
        object.idToken,
        specifiedType: const FullType(LinkSocialPostRequestIdToken),
      );
    }
    if (object.requestSignUp != null) {
      yield r'requestSignUp';
      yield serializers.serialize(
        object.requestSignUp,
        specifiedType: const FullType(bool),
      );
    }
    if (object.scopes != null) {
      yield r'scopes';
      yield serializers.serialize(
        object.scopes,
        specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
      );
    }
    if (object.errorCallbackURL != null) {
      yield r'errorCallbackURL';
      yield serializers.serialize(
        object.errorCallbackURL,
        specifiedType: const FullType(String),
      );
    }
    if (object.disableRedirect != null) {
      yield r'disableRedirect';
      yield serializers.serialize(
        object.disableRedirect,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkSocialPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkSocialPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'callbackURL':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.callbackURL = valueDes;
          break;
        case r'provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.provider = valueDes;
          break;
        case r'idToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LinkSocialPostRequestIdToken),
          ) as LinkSocialPostRequestIdToken;
          result.idToken.replace(valueDes);
          break;
        case r'requestSignUp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.requestSignUp = valueDes;
          break;
        case r'scopes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.scopes.replace(valueDes);
          break;
        case r'errorCallbackURL':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errorCallbackURL = valueDes;
          break;
        case r'disableRedirect':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.disableRedirect = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkSocialPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkSocialPostRequestBuilder();
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

