import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A widget that displays an address, with automatic reverse geocoding
/// if the address is not available.
///
/// Usage:
/// ```dart
/// AddressText(
///   address: order.pickupAddress,
///   coordinate: order.pickupLocation,
///   style: context.typography.p,
/// )
/// ```
class AddressText extends StatefulWidget {
  const AddressText({
    required this.coordinate,
    this.address,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    super.key,
  });

  /// The address string to display. If null or empty, reverse geocoding
  /// will be attempted using the coordinate.
  final String? address;

  /// The coordinate to use for reverse geocoding if address is not available.
  final Coordinate coordinate;

  /// Text style for the address.
  final TextStyle? style;

  /// Maximum number of lines for the text.
  final int? maxLines;

  /// How to handle text overflow.
  final TextOverflow? overflow;

  /// Text alignment.
  final TextAlign? textAlign;

  @override
  State<AddressText> createState() => _AddressTextState();
}

class _AddressTextState extends State<AddressText> {
  String? _resolvedAddress;
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _resolveAddress();
  }

  @override
  void didUpdateWidget(AddressText oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-resolve if address or coordinate changed
    if (widget.address != oldWidget.address ||
        widget.coordinate.x != oldWidget.coordinate.x ||
        widget.coordinate.y != oldWidget.coordinate.y) {
      _resolveAddress();
    }
  }

  Future<void> _resolveAddress() async {
    // If address is provided, use it directly
    if (widget.address != null && widget.address!.isNotEmpty) {
      setState(() {
        _resolvedAddress = widget.address;
        _isLoading = false;
        _hasError = false;
      });
      return;
    }

    // Otherwise, try to reverse geocode
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final mapService = sl<MapService>();
      final place = await mapService.reverseGeocode(widget.coordinate);

      if (mounted) {
        setState(() {
          // Use vicinity (formatted address) or name as fallback
          _resolvedAddress = place.vicinity.isNotEmpty
              ? place.vicinity
              : place.name;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Text(
        context.l10n.loading,
        style: widget.style?.copyWith(
          color: context.colorScheme.mutedForeground,
          fontStyle: FontStyle.italic,
        ),
        maxLines: widget.maxLines,
        overflow: widget.overflow,
        textAlign: widget.textAlign,
      );
    }

    if (_hasError || _resolvedAddress == null || _resolvedAddress!.isEmpty) {
      return Text(
        context.l10n.error_address_unavailable,
        style: widget.style?.copyWith(
          color: context.colorScheme.mutedForeground,
        ),
        maxLines: widget.maxLines,
        overflow: widget.overflow,
        textAlign: widget.textAlign,
      );
    }

    return Text(
      _resolvedAddress!,
      style: widget.style,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      textAlign: widget.textAlign,
    );
  }
}
