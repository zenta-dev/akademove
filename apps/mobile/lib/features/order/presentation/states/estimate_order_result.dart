part of '_export.dart';

class EstimateOrderResult {
  const EstimateOrderResult({
    required this.summary,
    required this.pickup,
    required this.dropoff,
  });

  final OrderSummary summary;
  final Place pickup;
  final Place dropoff;
}
