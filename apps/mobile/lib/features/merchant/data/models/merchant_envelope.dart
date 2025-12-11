// import 'package:api_client/api_client.dart';

// /// Event types for merchant WebSocket notifications
// enum MerchantEnvelopeEvent {
//   NEW_ORDER,
//   ORDER_CANCELLED,
//   DRIVER_ASSIGNED,
//   ORDER_COMPLETED,
//   ORDER_STATUS_CHANGED,
// }

// /// Payload for merchant WebSocket envelope
// class MerchantEnvelopePayload {
//   const MerchantEnvelopePayload({
//     this.order,
//     this.orderId,
//     this.merchantId,
//     this.itemCount,
//     this.totalAmount,
//     this.cancelReason,
//     this.driverName,
//     this.newStatus,
//   });

//   factory MerchantEnvelopePayload.fromJson(Map<String, dynamic> json) {
//     return MerchantEnvelopePayload(
//       order: json['order'] != null
//           ? Order.fromJson(json['order'] as Map<String, dynamic>)
//           : null,
//       orderId: json['orderId'] as String?,
//       merchantId: json['merchantId'] as String?,
//       itemCount: json['itemCount'] as int?,
//       totalAmount: (json['totalAmount'] as num?)?.toDouble(),
//       cancelReason: json['cancelReason'] as String?,
//       driverName: json['driverName'] as String?,
//       newStatus: json['newStatus'] as String?,
//     );
//   }

//   final Order? order;
//   final String? orderId;
//   final String? merchantId;
//   final int? itemCount;
//   final double? totalAmount;
//   final String? cancelReason;
//   final String? driverName;
//   final String? newStatus;

//   Map<String, dynamic> toJson() {
//     return {
//       if (order != null) 'order': order!.toJson(),
//       if (orderId != null) 'orderId': orderId,
//       if (merchantId != null) 'merchantId': merchantId,
//       if (itemCount != null) 'itemCount': itemCount,
//       if (totalAmount != null) 'totalAmount': totalAmount,
//       if (cancelReason != null) 'cancelReason': cancelReason,
//       if (driverName != null) 'driverName': driverName,
//       if (newStatus != null) 'newStatus': newStatus,
//     };
//   }
// }

// /// Merchant WebSocket envelope for real-time order notifications
// class MerchantEnvelope {
//   const MerchantEnvelope({
//     this.e,
//     this.a,
//     this.tg,
//     required this.f,
//     required this.t,
//     required this.p,
//   });

//   factory MerchantEnvelope.fromJson(Map<String, dynamic> json) {
//     return MerchantEnvelope(
//       e: _parseEvent(json['e'] as String?),
//       a: json['a'] as String?,
//       tg: json['tg'] as String?,
//       f: json['f'] as String,
//       t: json['t'] as String,
//       p: MerchantEnvelopePayload.fromJson(json['p'] as Map<String, dynamic>),
//     );
//   }

//   static MerchantEnvelopeEvent? _parseEvent(String? event) {
//     if (event == null) return null;
//     return MerchantEnvelopeEvent.values.firstWhere(
//       (e) => e.name == event,
//       orElse: () => MerchantEnvelopeEvent.ORDER_STATUS_CHANGED,
//     );
//   }

//   /// Event type (e.g., NEW_ORDER, ORDER_CANCELLED, etc.)
//   final MerchantEnvelopeEvent? e;

//   /// Action (usually "NONE" for merchant envelopes)
//   final String? a;

//   /// Target (e.g., "MERCHANT")
//   final String? tg;

//   /// From sender ("s" for server, "c" for client)
//   final String f;

//   /// To target ("s" for server, "c" for client)
//   final String t;

//   /// Payload containing order and metadata
//   final MerchantEnvelopePayload p;

//   Map<String, dynamic> toJson() {
//     return {
//       if (e != null) 'e': e!.name,
//       if (a != null) 'a': a,
//       if (tg != null) 'tg': tg,
//       'f': f,
//       't': t,
//       'p': p.toJson(),
//     };
//   }

//   @override
//   String toString() => toJson().toString();
// }
