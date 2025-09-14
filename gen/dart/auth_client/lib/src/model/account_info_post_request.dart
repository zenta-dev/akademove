//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_info_post_request.g.dart';

/// AccountInfoPostRequest
///
/// Properties:
/// * [accountId] - The provider given account id for which to get the account info
@BuiltValue()
abstract class AccountInfoPostRequest implements Built<AccountInfoPostRequest, AccountInfoPostRequestBuilder> {
  /// The provider given account id for which to get the account info
  @BuiltValueField(wireName: r'accountId')
  String get accountId;

  AccountInfoPostRequest._();

  factory AccountInfoPostRequest([void updates(AccountInfoPostRequestBuilder b)]) = _$AccountInfoPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountInfoPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountInfoPostRequest> get serializer => _$AccountInfoPostRequestSerializer();
}

class _$AccountInfoPostRequestSerializer implements PrimitiveSerializer<AccountInfoPostRequest> {
  @override
  final Iterable<Type> types = const [AccountInfoPostRequest, _$AccountInfoPostRequest];

  @override
  final String wireName = r'AccountInfoPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountInfoPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'accountId';
    yield serializers.serialize(
      object.accountId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountInfoPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountInfoPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  AccountInfoPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountInfoPostRequestBuilder();
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

