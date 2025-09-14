// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ReportCategoryEnum _$reportCategoryEnum_behavior =
    const ReportCategoryEnum._('behavior');
const ReportCategoryEnum _$reportCategoryEnum_safety =
    const ReportCategoryEnum._('safety');
const ReportCategoryEnum _$reportCategoryEnum_fraud =
    const ReportCategoryEnum._('fraud');
const ReportCategoryEnum _$reportCategoryEnum_other =
    const ReportCategoryEnum._('other');

ReportCategoryEnum _$reportCategoryEnumValueOf(String name) {
  switch (name) {
    case 'behavior':
      return _$reportCategoryEnum_behavior;
    case 'safety':
      return _$reportCategoryEnum_safety;
    case 'fraud':
      return _$reportCategoryEnum_fraud;
    case 'other':
      return _$reportCategoryEnum_other;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ReportCategoryEnum> _$reportCategoryEnumValues =
    BuiltSet<ReportCategoryEnum>(const <ReportCategoryEnum>[
  _$reportCategoryEnum_behavior,
  _$reportCategoryEnum_safety,
  _$reportCategoryEnum_fraud,
  _$reportCategoryEnum_other,
]);

const ReportStatusEnum _$reportStatusEnum_pending =
    const ReportStatusEnum._('pending');
const ReportStatusEnum _$reportStatusEnum_investigating =
    const ReportStatusEnum._('investigating');
const ReportStatusEnum _$reportStatusEnum_resolved =
    const ReportStatusEnum._('resolved');
const ReportStatusEnum _$reportStatusEnum_dismissed =
    const ReportStatusEnum._('dismissed');

ReportStatusEnum _$reportStatusEnumValueOf(String name) {
  switch (name) {
    case 'pending':
      return _$reportStatusEnum_pending;
    case 'investigating':
      return _$reportStatusEnum_investigating;
    case 'resolved':
      return _$reportStatusEnum_resolved;
    case 'dismissed':
      return _$reportStatusEnum_dismissed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ReportStatusEnum> _$reportStatusEnumValues =
    BuiltSet<ReportStatusEnum>(const <ReportStatusEnum>[
  _$reportStatusEnum_pending,
  _$reportStatusEnum_investigating,
  _$reportStatusEnum_resolved,
  _$reportStatusEnum_dismissed,
]);

Serializer<ReportCategoryEnum> _$reportCategoryEnumSerializer =
    _$ReportCategoryEnumSerializer();
Serializer<ReportStatusEnum> _$reportStatusEnumSerializer =
    _$ReportStatusEnumSerializer();

class _$ReportCategoryEnumSerializer
    implements PrimitiveSerializer<ReportCategoryEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'behavior': 'behavior',
    'safety': 'safety',
    'fraud': 'fraud',
    'other': 'other',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'behavior': 'behavior',
    'safety': 'safety',
    'fraud': 'fraud',
    'other': 'other',
  };

  @override
  final Iterable<Type> types = const <Type>[ReportCategoryEnum];
  @override
  final String wireName = 'ReportCategoryEnum';

  @override
  Object serialize(Serializers serializers, ReportCategoryEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ReportCategoryEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ReportCategoryEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ReportStatusEnumSerializer
    implements PrimitiveSerializer<ReportStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'investigating': 'investigating',
    'resolved': 'resolved',
    'dismissed': 'dismissed',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'investigating': 'investigating',
    'resolved': 'resolved',
    'dismissed': 'dismissed',
  };

  @override
  final Iterable<Type> types = const <Type>[ReportStatusEnum];
  @override
  final String wireName = 'ReportStatusEnum';

  @override
  Object serialize(Serializers serializers, ReportStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ReportStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ReportStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Report extends Report {
  @override
  final String id;
  @override
  final String? orderId;
  @override
  final String reporterId;
  @override
  final String targetUserId;
  @override
  final ReportCategoryEnum category;
  @override
  final String description;
  @override
  final String? evidenceUrl;
  @override
  final String? handledById;
  @override
  final String? resolution;
  @override
  final num reportedAt;
  @override
  final num? resolvedAt;
  @override
  final ReportStatusEnum? status;

  factory _$Report([void Function(ReportBuilder)? updates]) =>
      (ReportBuilder()..update(updates))._build();

  _$Report._(
      {required this.id,
      this.orderId,
      required this.reporterId,
      required this.targetUserId,
      required this.category,
      required this.description,
      this.evidenceUrl,
      this.handledById,
      this.resolution,
      required this.reportedAt,
      this.resolvedAt,
      this.status})
      : super._();
  @override
  Report rebuild(void Function(ReportBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReportBuilder toBuilder() => ReportBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Report &&
        id == other.id &&
        orderId == other.orderId &&
        reporterId == other.reporterId &&
        targetUserId == other.targetUserId &&
        category == other.category &&
        description == other.description &&
        evidenceUrl == other.evidenceUrl &&
        handledById == other.handledById &&
        resolution == other.resolution &&
        reportedAt == other.reportedAt &&
        resolvedAt == other.resolvedAt &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, reporterId.hashCode);
    _$hash = $jc(_$hash, targetUserId.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, evidenceUrl.hashCode);
    _$hash = $jc(_$hash, handledById.hashCode);
    _$hash = $jc(_$hash, resolution.hashCode);
    _$hash = $jc(_$hash, reportedAt.hashCode);
    _$hash = $jc(_$hash, resolvedAt.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Report')
          ..add('id', id)
          ..add('orderId', orderId)
          ..add('reporterId', reporterId)
          ..add('targetUserId', targetUserId)
          ..add('category', category)
          ..add('description', description)
          ..add('evidenceUrl', evidenceUrl)
          ..add('handledById', handledById)
          ..add('resolution', resolution)
          ..add('reportedAt', reportedAt)
          ..add('resolvedAt', resolvedAt)
          ..add('status', status))
        .toString();
  }
}

class ReportBuilder implements Builder<Report, ReportBuilder> {
  _$Report? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _reporterId;
  String? get reporterId => _$this._reporterId;
  set reporterId(String? reporterId) => _$this._reporterId = reporterId;

  String? _targetUserId;
  String? get targetUserId => _$this._targetUserId;
  set targetUserId(String? targetUserId) => _$this._targetUserId = targetUserId;

  ReportCategoryEnum? _category;
  ReportCategoryEnum? get category => _$this._category;
  set category(ReportCategoryEnum? category) => _$this._category = category;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _evidenceUrl;
  String? get evidenceUrl => _$this._evidenceUrl;
  set evidenceUrl(String? evidenceUrl) => _$this._evidenceUrl = evidenceUrl;

  String? _handledById;
  String? get handledById => _$this._handledById;
  set handledById(String? handledById) => _$this._handledById = handledById;

  String? _resolution;
  String? get resolution => _$this._resolution;
  set resolution(String? resolution) => _$this._resolution = resolution;

  num? _reportedAt;
  num? get reportedAt => _$this._reportedAt;
  set reportedAt(num? reportedAt) => _$this._reportedAt = reportedAt;

  num? _resolvedAt;
  num? get resolvedAt => _$this._resolvedAt;
  set resolvedAt(num? resolvedAt) => _$this._resolvedAt = resolvedAt;

  ReportStatusEnum? _status;
  ReportStatusEnum? get status => _$this._status;
  set status(ReportStatusEnum? status) => _$this._status = status;

  ReportBuilder() {
    Report._defaults(this);
  }

  ReportBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _orderId = $v.orderId;
      _reporterId = $v.reporterId;
      _targetUserId = $v.targetUserId;
      _category = $v.category;
      _description = $v.description;
      _evidenceUrl = $v.evidenceUrl;
      _handledById = $v.handledById;
      _resolution = $v.resolution;
      _reportedAt = $v.reportedAt;
      _resolvedAt = $v.resolvedAt;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Report other) {
    _$v = other as _$Report;
  }

  @override
  void update(void Function(ReportBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Report build() => _build();

  _$Report _build() {
    final _$result = _$v ??
        _$Report._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Report', 'id'),
          orderId: orderId,
          reporterId: BuiltValueNullFieldError.checkNotNull(
              reporterId, r'Report', 'reporterId'),
          targetUserId: BuiltValueNullFieldError.checkNotNull(
              targetUserId, r'Report', 'targetUserId'),
          category: BuiltValueNullFieldError.checkNotNull(
              category, r'Report', 'category'),
          description: BuiltValueNullFieldError.checkNotNull(
              description, r'Report', 'description'),
          evidenceUrl: evidenceUrl,
          handledById: handledById,
          resolution: resolution,
          reportedAt: BuiltValueNullFieldError.checkNotNull(
              reportedAt, r'Report', 'reportedAt'),
          resolvedAt: resolvedAt,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
