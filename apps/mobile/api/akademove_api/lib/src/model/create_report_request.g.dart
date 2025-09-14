// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_report_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateReportRequestCategoryEnum
    _$createReportRequestCategoryEnum_behavior =
    const CreateReportRequestCategoryEnum._('behavior');
const CreateReportRequestCategoryEnum _$createReportRequestCategoryEnum_safety =
    const CreateReportRequestCategoryEnum._('safety');
const CreateReportRequestCategoryEnum _$createReportRequestCategoryEnum_fraud =
    const CreateReportRequestCategoryEnum._('fraud');
const CreateReportRequestCategoryEnum _$createReportRequestCategoryEnum_other =
    const CreateReportRequestCategoryEnum._('other');

CreateReportRequestCategoryEnum _$createReportRequestCategoryEnumValueOf(
    String name) {
  switch (name) {
    case 'behavior':
      return _$createReportRequestCategoryEnum_behavior;
    case 'safety':
      return _$createReportRequestCategoryEnum_safety;
    case 'fraud':
      return _$createReportRequestCategoryEnum_fraud;
    case 'other':
      return _$createReportRequestCategoryEnum_other;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateReportRequestCategoryEnum>
    _$createReportRequestCategoryEnumValues = BuiltSet<
        CreateReportRequestCategoryEnum>(const <CreateReportRequestCategoryEnum>[
  _$createReportRequestCategoryEnum_behavior,
  _$createReportRequestCategoryEnum_safety,
  _$createReportRequestCategoryEnum_fraud,
  _$createReportRequestCategoryEnum_other,
]);

const CreateReportRequestStatusEnum _$createReportRequestStatusEnum_pending =
    const CreateReportRequestStatusEnum._('pending');
const CreateReportRequestStatusEnum
    _$createReportRequestStatusEnum_investigating =
    const CreateReportRequestStatusEnum._('investigating');
const CreateReportRequestStatusEnum _$createReportRequestStatusEnum_resolved =
    const CreateReportRequestStatusEnum._('resolved');
const CreateReportRequestStatusEnum _$createReportRequestStatusEnum_dismissed =
    const CreateReportRequestStatusEnum._('dismissed');

CreateReportRequestStatusEnum _$createReportRequestStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'pending':
      return _$createReportRequestStatusEnum_pending;
    case 'investigating':
      return _$createReportRequestStatusEnum_investigating;
    case 'resolved':
      return _$createReportRequestStatusEnum_resolved;
    case 'dismissed':
      return _$createReportRequestStatusEnum_dismissed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateReportRequestStatusEnum>
    _$createReportRequestStatusEnumValues = BuiltSet<
        CreateReportRequestStatusEnum>(const <CreateReportRequestStatusEnum>[
  _$createReportRequestStatusEnum_pending,
  _$createReportRequestStatusEnum_investigating,
  _$createReportRequestStatusEnum_resolved,
  _$createReportRequestStatusEnum_dismissed,
]);

Serializer<CreateReportRequestCategoryEnum>
    _$createReportRequestCategoryEnumSerializer =
    _$CreateReportRequestCategoryEnumSerializer();
Serializer<CreateReportRequestStatusEnum>
    _$createReportRequestStatusEnumSerializer =
    _$CreateReportRequestStatusEnumSerializer();

class _$CreateReportRequestCategoryEnumSerializer
    implements PrimitiveSerializer<CreateReportRequestCategoryEnum> {
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
  final Iterable<Type> types = const <Type>[CreateReportRequestCategoryEnum];
  @override
  final String wireName = 'CreateReportRequestCategoryEnum';

  @override
  Object serialize(
          Serializers serializers, CreateReportRequestCategoryEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateReportRequestCategoryEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateReportRequestCategoryEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateReportRequestStatusEnumSerializer
    implements PrimitiveSerializer<CreateReportRequestStatusEnum> {
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
  final Iterable<Type> types = const <Type>[CreateReportRequestStatusEnum];
  @override
  final String wireName = 'CreateReportRequestStatusEnum';

  @override
  Object serialize(
          Serializers serializers, CreateReportRequestStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateReportRequestStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateReportRequestStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateReportRequest extends CreateReportRequest {
  @override
  final String? orderId;
  @override
  final String reporterId;
  @override
  final String targetUserId;
  @override
  final CreateReportRequestCategoryEnum category;
  @override
  final String description;
  @override
  final String? evidenceUrl;
  @override
  final String? handledById;
  @override
  final String? resolution;
  @override
  final CreateReportRequestStatusEnum? status;

  factory _$CreateReportRequest(
          [void Function(CreateReportRequestBuilder)? updates]) =>
      (CreateReportRequestBuilder()..update(updates))._build();

  _$CreateReportRequest._(
      {this.orderId,
      required this.reporterId,
      required this.targetUserId,
      required this.category,
      required this.description,
      this.evidenceUrl,
      this.handledById,
      this.resolution,
      this.status})
      : super._();
  @override
  CreateReportRequest rebuild(
          void Function(CreateReportRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateReportRequestBuilder toBuilder() =>
      CreateReportRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateReportRequest &&
        orderId == other.orderId &&
        reporterId == other.reporterId &&
        targetUserId == other.targetUserId &&
        category == other.category &&
        description == other.description &&
        evidenceUrl == other.evidenceUrl &&
        handledById == other.handledById &&
        resolution == other.resolution &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, reporterId.hashCode);
    _$hash = $jc(_$hash, targetUserId.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, evidenceUrl.hashCode);
    _$hash = $jc(_$hash, handledById.hashCode);
    _$hash = $jc(_$hash, resolution.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateReportRequest')
          ..add('orderId', orderId)
          ..add('reporterId', reporterId)
          ..add('targetUserId', targetUserId)
          ..add('category', category)
          ..add('description', description)
          ..add('evidenceUrl', evidenceUrl)
          ..add('handledById', handledById)
          ..add('resolution', resolution)
          ..add('status', status))
        .toString();
  }
}

class CreateReportRequestBuilder
    implements Builder<CreateReportRequest, CreateReportRequestBuilder> {
  _$CreateReportRequest? _$v;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _reporterId;
  String? get reporterId => _$this._reporterId;
  set reporterId(String? reporterId) => _$this._reporterId = reporterId;

  String? _targetUserId;
  String? get targetUserId => _$this._targetUserId;
  set targetUserId(String? targetUserId) => _$this._targetUserId = targetUserId;

  CreateReportRequestCategoryEnum? _category;
  CreateReportRequestCategoryEnum? get category => _$this._category;
  set category(CreateReportRequestCategoryEnum? category) =>
      _$this._category = category;

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

  CreateReportRequestStatusEnum? _status;
  CreateReportRequestStatusEnum? get status => _$this._status;
  set status(CreateReportRequestStatusEnum? status) => _$this._status = status;

  CreateReportRequestBuilder() {
    CreateReportRequest._defaults(this);
  }

  CreateReportRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderId = $v.orderId;
      _reporterId = $v.reporterId;
      _targetUserId = $v.targetUserId;
      _category = $v.category;
      _description = $v.description;
      _evidenceUrl = $v.evidenceUrl;
      _handledById = $v.handledById;
      _resolution = $v.resolution;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateReportRequest other) {
    _$v = other as _$CreateReportRequest;
  }

  @override
  void update(void Function(CreateReportRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateReportRequest build() => _build();

  _$CreateReportRequest _build() {
    final _$result = _$v ??
        _$CreateReportRequest._(
          orderId: orderId,
          reporterId: BuiltValueNullFieldError.checkNotNull(
              reporterId, r'CreateReportRequest', 'reporterId'),
          targetUserId: BuiltValueNullFieldError.checkNotNull(
              targetUserId, r'CreateReportRequest', 'targetUserId'),
          category: BuiltValueNullFieldError.checkNotNull(
              category, r'CreateReportRequest', 'category'),
          description: BuiltValueNullFieldError.checkNotNull(
              description, r'CreateReportRequest', 'description'),
          evidenceUrl: evidenceUrl,
          handledById: handledById,
          resolution: resolution,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
