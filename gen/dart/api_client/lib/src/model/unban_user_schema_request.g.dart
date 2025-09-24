// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unban_user_schema_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UnbanUserSchemaRequest extends UnbanUserSchemaRequest {
  @override
  final String id;

  factory _$UnbanUserSchemaRequest([
    void Function(UnbanUserSchemaRequestBuilder)? updates,
  ]) => (UnbanUserSchemaRequestBuilder()..update(updates))._build();

  _$UnbanUserSchemaRequest._({required this.id}) : super._();
  @override
  UnbanUserSchemaRequest rebuild(
    void Function(UnbanUserSchemaRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UnbanUserSchemaRequestBuilder toBuilder() =>
      UnbanUserSchemaRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnbanUserSchemaRequest && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'UnbanUserSchemaRequest',
    )..add('id', id)).toString();
  }
}

class UnbanUserSchemaRequestBuilder
    implements Builder<UnbanUserSchemaRequest, UnbanUserSchemaRequestBuilder> {
  _$UnbanUserSchemaRequest? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  UnbanUserSchemaRequestBuilder() {
    UnbanUserSchemaRequest._defaults(this);
  }

  UnbanUserSchemaRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnbanUserSchemaRequest other) {
    _$v = other as _$UnbanUserSchemaRequest;
  }

  @override
  void update(void Function(UnbanUserSchemaRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnbanUserSchemaRequest build() => _build();

  _$UnbanUserSchemaRequest _build() {
    final _$result =
        _$v ??
        _$UnbanUserSchemaRequest._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'UnbanUserSchemaRequest',
            'id',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
