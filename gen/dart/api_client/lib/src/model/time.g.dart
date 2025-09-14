// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Time extends Time {
  @override
  final num h;
  @override
  final num m;

  factory _$Time([void Function(TimeBuilder)? updates]) =>
      (TimeBuilder()..update(updates))._build();

  _$Time._({required this.h, required this.m}) : super._();
  @override
  Time rebuild(void Function(TimeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TimeBuilder toBuilder() => TimeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Time && h == other.h && m == other.m;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, h.hashCode);
    _$hash = $jc(_$hash, m.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Time')
          ..add('h', h)
          ..add('m', m))
        .toString();
  }
}

class TimeBuilder implements Builder<Time, TimeBuilder> {
  _$Time? _$v;

  num? _h;
  num? get h => _$this._h;
  set h(num? h) => _$this._h = h;

  num? _m;
  num? get m => _$this._m;
  set m(num? m) => _$this._m = m;

  TimeBuilder() {
    Time._defaults(this);
  }

  TimeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _h = $v.h;
      _m = $v.m;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Time other) {
    _$v = other as _$Time;
  }

  @override
  void update(void Function(TimeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Time build() => _build();

  _$Time _build() {
    final _$result =
        _$v ??
        _$Time._(
          h: BuiltValueNullFieldError.checkNotNull(h, r'Time', 'h'),
          m: BuiltValueNullFieldError.checkNotNull(m, r'Time', 'm'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
