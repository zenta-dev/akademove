// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ban_user_schema_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BanUserSchemaRequest extends BanUserSchemaRequest {
  @override
  final String banReason;
  @override
  final num? banExpiresIn;

  factory _$BanUserSchemaRequest([
    void Function(BanUserSchemaRequestBuilder)? updates,
  ]) => (BanUserSchemaRequestBuilder()..update(updates))._build();

  _$BanUserSchemaRequest._({required this.banReason, this.banExpiresIn})
    : super._();
  @override
  BanUserSchemaRequest rebuild(
    void Function(BanUserSchemaRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BanUserSchemaRequestBuilder toBuilder() =>
      BanUserSchemaRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BanUserSchemaRequest &&
        banReason == other.banReason &&
        banExpiresIn == other.banExpiresIn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, banReason.hashCode);
    _$hash = $jc(_$hash, banExpiresIn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BanUserSchemaRequest')
          ..add('banReason', banReason)
          ..add('banExpiresIn', banExpiresIn))
        .toString();
  }
}

class BanUserSchemaRequestBuilder
    implements Builder<BanUserSchemaRequest, BanUserSchemaRequestBuilder> {
  _$BanUserSchemaRequest? _$v;

  String? _banReason;
  String? get banReason => _$this._banReason;
  set banReason(String? banReason) => _$this._banReason = banReason;

  num? _banExpiresIn;
  num? get banExpiresIn => _$this._banExpiresIn;
  set banExpiresIn(num? banExpiresIn) => _$this._banExpiresIn = banExpiresIn;

  BanUserSchemaRequestBuilder() {
    BanUserSchemaRequest._defaults(this);
  }

  BanUserSchemaRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _banReason = $v.banReason;
      _banExpiresIn = $v.banExpiresIn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BanUserSchemaRequest other) {
    _$v = other as _$BanUserSchemaRequest;
  }

  @override
  void update(void Function(BanUserSchemaRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BanUserSchemaRequest build() => _build();

  _$BanUserSchemaRequest _build() {
    final _$result =
        _$v ??
        _$BanUserSchemaRequest._(
          banReason: BuiltValueNullFieldError.checkNotNull(
            banReason,
            r'BanUserSchemaRequest',
            'banReason',
          ),
          banExpiresIn: banExpiresIn,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
