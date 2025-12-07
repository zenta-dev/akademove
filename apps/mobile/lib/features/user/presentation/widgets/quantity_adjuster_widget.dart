import 'package:flutter/material.dart' as flutter_material;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Quantity adjuster widget showing [ - ] [Qty/Max] [ + ]
/// Respects maximum quantity based on item stock
/// Always visible, never collapses
class QuantityAdjusterWidget extends StatefulWidget {
  /// Current quantity being adjusted
  final int initialQuantity;

  /// Maximum quantity allowed (based on item.stock)
  final int maxQuantity;

  /// Callback when quantity changes
  final Function(int) onChanged;

  /// Whether to disable the controls (out of stock)
  final bool isDisabled;

  const QuantityAdjusterWidget({
    required this.initialQuantity,
    required this.maxQuantity,
    required this.onChanged,
    this.isDisabled = false,
    super.key,
  });

  @override
  State<QuantityAdjusterWidget> createState() => _QuantityAdjusterWidgetState();
}

class _QuantityAdjusterWidgetState extends State<QuantityAdjusterWidget> {
  late int _currentQty;

  @override
  void initState() {
    super.initState();
    _currentQty = widget.initialQuantity;
  }

  @override
  void didUpdateWidget(QuantityAdjusterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialQuantity != widget.initialQuantity) {
      _currentQty = widget.initialQuantity;
    }
  }

  /// Get color based on stock status
  Color _getStockColor() {
    if (widget.maxQuantity == 0) {
      return const Color(0xFFEF4444); // Red - out of stock
    }
    if (_currentQty >= widget.maxQuantity) {
      return const Color(0xFFF97316); // Orange - at max stock
    }
    if (widget.maxQuantity <= 2) {
      return const Color(0xFFF97316); // Orange - low stock
    }
    return const Color(0xFF22C55E); // Green - good stock
  }

  void _decrease() {
    if (_currentQty > 0 && !widget.isDisabled) {
      _currentQty--;
      widget.onChanged(_currentQty);
      setState(() {});
    }
  }

  void _increase() {
    if (_currentQty < widget.maxQuantity && !widget.isDisabled) {
      _currentQty++;
      widget.onChanged(_currentQty);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final canDecrease = _currentQty > 0 && !widget.isDisabled;
    final canIncrease = _currentQty < widget.maxQuantity && !widget.isDisabled;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(color: flutter_material.Colors.grey[300]!),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrease button
          GestureDetector(
            onTap: canDecrease ? _decrease : null,
            child: Opacity(
              opacity: canDecrease ? 1.0 : 0.5,
              child: Icon(
                flutter_material.Icons.remove,
                size: 16.sp,
                color: canDecrease
                    ? flutter_material.Colors.black
                    : flutter_material.Colors.grey[500],
              ),
            ),
          ),
          SizedBox(width: 10.w),

          // Quantity display: "Qty/Max"
          Text(
            '$_currentQty/${widget.maxQuantity}',
            style: TextStyle(
              color: _getStockColor(),
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(width: 10.w),

          // Increase button
          GestureDetector(
            onTap: canIncrease ? _increase : null,
            child: Opacity(
              opacity: canIncrease ? 1.0 : 0.5,
              child: Icon(
                flutter_material.Icons.add,
                size: 16.sp,
                color: canIncrease
                    ? flutter_material.Colors.black
                    : flutter_material.Colors.grey[500],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
