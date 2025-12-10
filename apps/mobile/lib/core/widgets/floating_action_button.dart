import 'package:akademove/core/utils/extension/context.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A floating action button
/// Replacement for Material's FloatingActionButton
class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.size = 56,
    this.elevation = 6,
    this.heroTag,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double size;
  final double elevation;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? context.colorScheme.primary;
    final fgColor = foregroundColor ?? context.colorScheme.primaryForeground;

    Widget button = GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: elevation,
              offset: Offset(0, elevation / 2),
            ),
          ],
        ),
        child: Center(
          child: IconTheme(
            data: IconThemeData(color: fgColor, size: 24),
            child: child,
          ),
        ),
      ),
    );

    if (heroTag != null) {
      button = Hero(tag: heroTag!, child: button);
    }

    return button;
  }
}
