// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info_post200_response_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountInfoPost200ResponseUser extends AccountInfoPost200ResponseUser {
  @override
  final String id;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? image;
  @override
  final bool emailVerified;

  factory _$AccountInfoPost200ResponseUser([
    void Function(AccountInfoPost200ResponseUserBuilder)? updates,
  ]) => (AccountInfoPost200ResponseUserBuilder()..update(updates))._build();

  _$AccountInfoPost200ResponseUser._({
    required this.id,
    this.name,
    this.email,
    this.image,
    required this.emailVerified,
  }) : super._();
  @override
  AccountInfoPost200ResponseUser rebuild(
    void Function(AccountInfoPost200ResponseUserBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountInfoPost200ResponseUserBuilder toBuilder() =>
      AccountInfoPost200ResponseUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountInfoPost200ResponseUser &&
        id == other.id &&
        name == other.name &&
        email == other.email &&
        image == other.image &&
        emailVerified == other.emailVerified;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, emailVerified.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountInfoPost200ResponseUser')
          ..add('id', id)
          ..add('name', name)
          ..add('email', email)
          ..add('image', image)
          ..add('emailVerified', emailVerified))
        .toString();
  }
}

class AccountInfoPost200ResponseUserBuilder
    implements
        Builder<
          AccountInfoPost200ResponseUser,
          AccountInfoPost200ResponseUserBuilder
        > {
  _$AccountInfoPost200ResponseUser? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  bool? _emailVerified;
  bool? get emailVerified => _$this._emailVerified;
  set emailVerified(bool? emailVerified) =>
      _$this._emailVerified = emailVerified;

  AccountInfoPost200ResponseUserBuilder() {
    AccountInfoPost200ResponseUser._defaults(this);
  }

  AccountInfoPost200ResponseUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _email = $v.email;
      _image = $v.image;
      _emailVerified = $v.emailVerified;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountInfoPost200ResponseUser other) {
    _$v = other as _$AccountInfoPost200ResponseUser;
  }

  @override
  void update(void Function(AccountInfoPost200ResponseUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountInfoPost200ResponseUser build() => _build();

  _$AccountInfoPost200ResponseUser _build() {
    final _$result =
        _$v ??
        _$AccountInfoPost200ResponseUser._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'AccountInfoPost200ResponseUser',
            'id',
          ),
          name: name,
          email: email,
          image: image,
          emailVerified: BuiltValueNullFieldError.checkNotNull(
            emailVerified,
            r'AccountInfoPost200ResponseUser',
            'emailVerified',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
