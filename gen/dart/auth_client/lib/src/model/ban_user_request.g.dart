// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ban_user_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BanUserRequest extends BanUserRequest {
  @override
  final String userId;
  @override
  final String? banReason;
  @override
  final num? banExpiresIn;

  factory _$BanUserRequest([void Function(BanUserRequestBuilder)? updates]) =>
      (BanUserRequestBuilder()..update(updates))._build();

  _$BanUserRequest._({required this.userId, this.banReason, this.banExpiresIn})
    : super._();
  @override
  BanUserRequest rebuild(void Function(BanUserRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BanUserRequestBuilder toBuilder() => BanUserRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BanUserRequest &&
        userId == other.userId &&
        banReason == other.banReason &&
        banExpiresIn == other.banExpiresIn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, banReason.hashCode);
    _$hash = $jc(_$hash, banExpiresIn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BanUserRequest')
          ..add('userId', userId)
          ..add('banReason', banReason)
          ..add('banExpiresIn', banExpiresIn))
        .toString();
  }
}

class BanUserRequestBuilder
    implements Builder<BanUserRequest, BanUserRequestBuilder> {
  _$BanUserRequest? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _banReason;
  String? get banReason => _$this._banReason;
  set banReason(String? banReason) => _$this._banReason = banReason;

  num? _banExpiresIn;
  num? get banExpiresIn => _$this._banExpiresIn;
  set banExpiresIn(num? banExpiresIn) => _$this._banExpiresIn = banExpiresIn;

  BanUserRequestBuilder() {
    BanUserRequest._defaults(this);
  }

  BanUserRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _banReason = $v.banReason;
      _banExpiresIn = $v.banExpiresIn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BanUserRequest other) {
    _$v = other as _$BanUserRequest;
  }

  @override
  void update(void Function(BanUserRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BanUserRequest build() => _build();

  _$BanUserRequest _build() {
    final _$result =
        _$v ??
        _$BanUserRequest._(
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'BanUserRequest',
            'userId',
          ),
          banReason: banReason,
          banExpiresIn: banExpiresIn,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
