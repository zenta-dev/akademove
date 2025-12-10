import 'package:akademove/core/utils/extension/context.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A status indicator dot that shows colored status
class StatusIndicator extends StatelessWidget {
  const StatusIndicator({
    required this.color,
    this.size = 12,
    this.showBorder = false,
    super.key,
  });

  final Color color;
  final double size;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: showBorder
            ? Border.all(color: context.colorScheme.border, width: 1)
            : null,
      ),
    );
  }
}
