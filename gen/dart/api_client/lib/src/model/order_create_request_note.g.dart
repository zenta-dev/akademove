// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_request_note.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderCreateRequestNote extends OrderCreateRequestNote {
  @override
  final String? pickup;
  @override
  final String? dropoff;

  factory _$OrderCreateRequestNote([
    void Function(OrderCreateRequestNoteBuilder)? updates,
  ]) => (OrderCreateRequestNoteBuilder()..update(updates))._build();

  _$OrderCreateRequestNote._({this.pickup, this.dropoff}) : super._();
  @override
  OrderCreateRequestNote rebuild(
    void Function(OrderCreateRequestNoteBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OrderCreateRequestNoteBuilder toBuilder() =>
      OrderCreateRequestNoteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderCreateRequestNote &&
        pickup == other.pickup &&
        dropoff == other.dropoff;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pickup.hashCode);
    _$hash = $jc(_$hash, dropoff.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderCreateRequestNote')
          ..add('pickup', pickup)
          ..add('dropoff', dropoff))
        .toString();
  }
}

class OrderCreateRequestNoteBuilder
    implements Builder<OrderCreateRequestNote, OrderCreateRequestNoteBuilder> {
  _$OrderCreateRequestNote? _$v;

  String? _pickup;
  String? get pickup => _$this._pickup;
  set pickup(String? pickup) => _$this._pickup = pickup;

  String? _dropoff;
  String? get dropoff => _$this._dropoff;
  set dropoff(String? dropoff) => _$this._dropoff = dropoff;

  OrderCreateRequestNoteBuilder() {
    OrderCreateRequestNote._defaults(this);
  }

  OrderCreateRequestNoteBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pickup = $v.pickup;
      _dropoff = $v.dropoff;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderCreateRequestNote other) {
    _$v = other as _$OrderCreateRequestNote;
  }

  @override
  void update(void Function(OrderCreateRequestNoteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderCreateRequestNote build() => _build();

  _$OrderCreateRequestNote _build() {
    final _$result =
        _$v ?? _$OrderCreateRequestNote._(pickup: pickup, dropoff: dropoff);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
