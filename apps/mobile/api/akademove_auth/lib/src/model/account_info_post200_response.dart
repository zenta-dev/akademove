//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_auth/src/model/account_info_post200_response_user.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_info_post200_response.g.dart';

/// AccountInfoPost200Response
///
/// Properties:
/// * [user]
/// * [data]
@BuiltValue()
abstract class AccountInfoPost200Response
    implements
        Built<AccountInfoPost200Response, AccountInfoPost200ResponseBuilder> {
  @BuiltValueField(wireName: r'user')
  AccountInfoPost200ResponseUser get user;

  @BuiltValueField(wireName: r'data')
  BuiltMap<String, JsonObject?> get data;

  AccountInfoPost200Response._();

  factory AccountInfoPost200Response(
          [void updates(AccountInfoPost200ResponseBuilder b)]) =
      _$AccountInfoPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountInfoPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountInfoPost200Response> get serializer =>
      _$AccountInfoPost200ResponseSerializer();
}

class _$AccountInfoPost200ResponseSerializer
    implements PrimitiveSerializer<AccountInfoPost200Response> {
  @override
  final Iterable<Type> types = const [
    AccountInfoPost200Response,
    _$AccountInfoPost200Response
  ];

  @override
  final String wireName = r'AccountInfoPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountInfoPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(AccountInfoPost200ResponseUser),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(
          BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountInfoPost200Response object, {
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
    required AccountInfoPost200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountInfoPost200ResponseUser),
          ) as AccountInfoPost200ResponseUser;
          result.user.replace(valueDes);
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
          ) as BuiltMap<String, JsonObject?>;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountInfoPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountInfoPost200ResponseBuilder();
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
