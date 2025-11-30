//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'statements.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Statements {
  /// Returns a new [Statements] instance.
  const Statements({
     this.driver,
     this.merchant,
     this.merchantMenu,
     this.order,
     this.schedule,
     this.coupon,
     this.report,
     this.review,
     this.user,
     this.session,
     this.pricing,
     this.bookings,
     this.configurations,
  });

  @JsonKey(name: r'driver', required: false, includeIfNull: false)
  final List<StatementsDriverEnum>? driver;
  
  @JsonKey(name: r'merchant', required: false, includeIfNull: false)
  final List<StatementsMerchantEnum>? merchant;
  
  @JsonKey(name: r'merchantMenu', required: false, includeIfNull: false)
  final List<StatementsMerchantMenuEnum>? merchantMenu;
  
  @JsonKey(name: r'order', required: false, includeIfNull: false)
  final List<StatementsOrderEnum>? order;
  
  @JsonKey(name: r'schedule', required: false, includeIfNull: false)
  final List<StatementsScheduleEnum>? schedule;
  
  @JsonKey(name: r'coupon', required: false, includeIfNull: false)
  final List<StatementsCouponEnum>? coupon;
  
  @JsonKey(name: r'report', required: false, includeIfNull: false)
  final List<StatementsReportEnum>? report;
  
  @JsonKey(name: r'review', required: false, includeIfNull: false)
  final List<StatementsReviewEnum>? review;
  
  @JsonKey(name: r'user', required: false, includeIfNull: false)
  final List<StatementsUserEnum>? user;
  
  @JsonKey(name: r'session', required: false, includeIfNull: false)
  final List<StatementsSessionEnum>? session;
  
  @JsonKey(name: r'pricing', required: false, includeIfNull: false)
  final List<StatementsPricingEnum>? pricing;
  
  @JsonKey(name: r'bookings', required: false, includeIfNull: false)
  final List<StatementsBookingsEnum>? bookings;
  
  @JsonKey(name: r'configurations', required: false, includeIfNull: false)
  final List<StatementsConfigurationsEnum>? configurations;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is Statements &&
    other.driver == driver &&
    other.merchant == merchant &&
    other.merchantMenu == merchantMenu &&
    other.order == order &&
    other.schedule == schedule &&
    other.coupon == coupon &&
    other.report == report &&
    other.review == review &&
    other.user == user &&
    other.session == session &&
    other.pricing == pricing &&
    other.bookings == bookings &&
    other.configurations == configurations;

  @override
  int get hashCode =>
      driver.hashCode +
      merchant.hashCode +
      merchantMenu.hashCode +
      order.hashCode +
      schedule.hashCode +
      coupon.hashCode +
      report.hashCode +
      review.hashCode +
      user.hashCode +
      session.hashCode +
      pricing.hashCode +
      bookings.hashCode +
      configurations.hashCode;

  factory Statements.fromJson(Map<String, dynamic> json) => _$StatementsFromJson(json);

  Map<String, dynamic> toJson() => _$StatementsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum StatementsDriverEnum {
  @JsonValue(r'list')
  list(r'list'),
  @JsonValue(r'get')
  get_(r'get'),
  @JsonValue(r'create')
  create(r'create'),
  @JsonValue(r'update')
  update(r'update'),
  @JsonValue(r'delete')
  delete(r'delete'),
  @JsonValue(r'ban')
  ban(r'ban'),
  @JsonValue(r'approve')
  approve(r'approve');
  
  const StatementsDriverEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


enum StatementsMerchantEnum {
  @JsonValue(r'list')
  list(r'list'),
  @JsonValue(r'get')
  get_(r'get'),
  @JsonValue(r'create')
  create(r'create'),
  @JsonValue(r'update')
  update(r'update'),
  @JsonValue(r'delete')
  delete(r'delete'),
  @JsonValue(r'approve')
  approve(r'approve');
  
  const StatementsMerchantEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


enum StatementsMerchantMenuEnum {
  @JsonValue(r'list')
  list(r'list'),
  @JsonValue(r'get')
  get_(r'get'),
  @JsonValue(r'create')
  create(r'create'),
  @JsonValue(r'update')
  update(r'update'),
  @JsonValue(r'delete')
  delete(r'delete');
  
  const StatementsMerchantMenuEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


enum StatementsOrderEnum {
  @JsonValue(r'list')
  list(r'list'),
  @JsonValue(r'get')
  get_(r'get'),
  @JsonValue(r'create')
  create(r'create'),
  @JsonValue(r'update')
  update(r'update'),
  @JsonValue(r'delete')
  delete(r'delete'),
  @JsonValue(r'cancel')
  cancel(r'cancel'),
  @JsonValue(r'assign')
  assign(r'assign');
  
  const StatementsOrderEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


enum StatementsScheduleEnum {
  @JsonValue(r'list')
  list(r'list'),
  @JsonValue(r'get')
  get_(r'get'),
  @JsonValue(r'create')
  create(r'create'),
  @JsonValue(r'update')
  update(r'update'),
  @JsonValue(r'delete')
  delete(r'delete');
  
  const StatementsScheduleEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


enum StatementsCouponEnum {
  @JsonValue(r'list')
  list(r'list'),
  @JsonValue(r'get')
  get_(r'get'),
  @JsonValue(r'create')
  create(r'create'),
  @JsonValue(r'update')
  update(r'update'),
  @JsonValue(r'delete')
  delete(r'delete'),
  @JsonValue(r'approve')
  approve(r'approve');
  
  const StatementsCouponEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


enum StatementsReportEnum {
  @JsonValue(r'list')
  list(r'list'),
  @JsonValue(r'get')
  get_(r'get'),
  @JsonValue(r'create')
  create(r'create'),
  @JsonValue(r'update')
  update(r'update'),
  @JsonValue(r'delete')
  delete(r'delete'),
  @JsonValue(r'export')
  export_(r'export');
  
  const StatementsReportEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


enum StatementsReviewEnum {
  @JsonValue(r'list')
  list(r'list'),
  @JsonValue(r'get')
  get_(r'get'),
  @JsonValue(r'create')
  create(r'create'),
  @JsonValue(r'update')
  update(r'update'),
  @JsonValue(r'delete')
  delete(r'delete');
  
  const StatementsReviewEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


enum StatementsUserEnum {
  @JsonValue(r'list')
  list(r'list'),
  @JsonValue(r'get')
  get_(r'get'),
  @JsonValue(r'invite')
  invite(r'invite'),
  @JsonValue(r'create')
  create(r'create'),
  @JsonValue(r'update')
  update(r'update'),
  @JsonValue(r'delete')
  delete(r'delete'),
  @JsonValue(r'verify')
  verify(r'verify'),
  @JsonValue(r'set-role')
  setRole(r'set-role'),
  @JsonValue(r'ban')
  ban(r'ban'),
  @JsonValue(r'impersonate')
  impersonate(r'impersonate'),
  @JsonValue(r'set-password')
  setPassword(r'set-password');
  
  const StatementsUserEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


enum StatementsSessionEnum {
  @JsonValue(r'list')
  list(r'list'),
  @JsonValue(r'revoke')
  revoke(r'revoke'),
  @JsonValue(r'delete')
  delete(r'delete');
  
  const StatementsSessionEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


enum StatementsPricingEnum {
  @JsonValue(r'get')
  get_(r'get'),
  @JsonValue(r'update')
  update(r'update'),
  @JsonValue(r'delete')
  delete(r'delete');
  
  const StatementsPricingEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


enum StatementsBookingsEnum {
  @JsonValue(r'list')
  list(r'list'),
  @JsonValue(r'get')
  get_(r'get'),
  @JsonValue(r'create')
  create(r'create'),
  @JsonValue(r'update')
  update(r'update'),
  @JsonValue(r'delete')
  delete(r'delete');
  
  const StatementsBookingsEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


enum StatementsConfigurationsEnum {
  @JsonValue(r'list')
  list(r'list'),
  @JsonValue(r'get')
  get_(r'get'),
  @JsonValue(r'update')
  update(r'update');
  
  const StatementsConfigurationsEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


