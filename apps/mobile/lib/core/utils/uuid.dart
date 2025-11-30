String generateOrderCode(String orderId) {
  final clean = orderId.replaceAll('-', '');

  if (clean.length < 12) {
    throw ArgumentError('Invalid UUIDv7: $orderId');
  }

  final tsHex = clean.substring(0, 12);
  final tsInt = int.parse(tsHex, radix: 16);

  final date = DateTime.fromMillisecondsSinceEpoch(tsInt, isUtc: true);

  final yyyy = date.year.toString();
  final mm = date.month.toString().padLeft(2, '0');
  final dd = date.day.toString().padLeft(2, '0');

  final short = clean.substring(clean.length - 6);

  return '$yyyy$mm$dd-$short';
}

