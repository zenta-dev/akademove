// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_review_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetAllReviewSuccessResponseSuccessEnum
    _$getAllReviewSuccessResponseSuccessEnum_true_ =
    const GetAllReviewSuccessResponseSuccessEnum._('true_');

GetAllReviewSuccessResponseSuccessEnum
    _$getAllReviewSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getAllReviewSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetAllReviewSuccessResponseSuccessEnum>
    _$getAllReviewSuccessResponseSuccessEnumValues = BuiltSet<
        GetAllReviewSuccessResponseSuccessEnum>(const <GetAllReviewSuccessResponseSuccessEnum>[
  _$getAllReviewSuccessResponseSuccessEnum_true_,
]);

Serializer<GetAllReviewSuccessResponseSuccessEnum>
    _$getAllReviewSuccessResponseSuccessEnumSerializer =
    _$GetAllReviewSuccessResponseSuccessEnumSerializer();

class _$GetAllReviewSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetAllReviewSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetAllReviewSuccessResponseSuccessEnum
  ];
  @override
  final String wireName = 'GetAllReviewSuccessResponseSuccessEnum';

  @override
  Object serialize(Serializers serializers,
          GetAllReviewSuccessResponseSuccessEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  GetAllReviewSuccessResponseSuccessEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GetAllReviewSuccessResponseSuccessEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$GetAllReviewSuccessResponse extends GetAllReviewSuccessResponse {
  @override
  final GetAllReviewSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final BuiltList<Review> data;

  factory _$GetAllReviewSuccessResponse(
          [void Function(GetAllReviewSuccessResponseBuilder)? updates]) =>
      (GetAllReviewSuccessResponseBuilder()..update(updates))._build();

  _$GetAllReviewSuccessResponse._(
      {required this.success, required this.message, required this.data})
      : super._();
  @override
  GetAllReviewSuccessResponse rebuild(
          void Function(GetAllReviewSuccessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetAllReviewSuccessResponseBuilder toBuilder() =>
      GetAllReviewSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetAllReviewSuccessResponse &&
        success == other.success &&
        message == other.message &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetAllReviewSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetAllReviewSuccessResponseBuilder
    implements
        Builder<GetAllReviewSuccessResponse,
            GetAllReviewSuccessResponseBuilder> {
  _$GetAllReviewSuccessResponse? _$v;

  GetAllReviewSuccessResponseSuccessEnum? _success;
  GetAllReviewSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetAllReviewSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Review>? _data;
  ListBuilder<Review> get data => _$this._data ??= ListBuilder<Review>();
  set data(ListBuilder<Review>? data) => _$this._data = data;

  GetAllReviewSuccessResponseBuilder() {
    GetAllReviewSuccessResponse._defaults(this);
  }

  GetAllReviewSuccessResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetAllReviewSuccessResponse other) {
    _$v = other as _$GetAllReviewSuccessResponse;
  }

  @override
  void update(void Function(GetAllReviewSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetAllReviewSuccessResponse build() => _build();

  _$GetAllReviewSuccessResponse _build() {
    _$GetAllReviewSuccessResponse _$result;
    try {
      _$result = _$v ??
          _$GetAllReviewSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
                success, r'GetAllReviewSuccessResponse', 'success'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'GetAllReviewSuccessResponse', 'message'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GetAllReviewSuccessResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
