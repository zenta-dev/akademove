import 'package:akademove/core/utils/extension/context.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A circular avatar widget
/// Replacement for Material's CircleAvatar
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    this.imageUrl,
    this.child,
    this.backgroundColor,
    this.radius = 20,
    this.borderColor,
    this.borderWidth = 0,
    super.key,
  });

  final String? imageUrl;
  final Widget? child;
  final Color? backgroundColor;
  final double radius;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;
    final bgColor =
        backgroundColor ?? context.colorScheme.primary.withValues(alpha: 0.1);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: borderWidth > 0
            ? Border.all(
                color: borderColor ?? context.colorScheme.border,
                width: borderWidth,
              )
            : null,
      ),
      child: ClipOval(child: _buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    final url = imageUrl;
    if (url != null && url.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildPlaceholder(context),
        errorWidget: (context, url, error) => _buildPlaceholder(context),
      );
    }

    if (child != null) {
      return Center(child: child);
    }

    return _buildPlaceholder(context);
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Center(
      child: Icon(
        LucideIcons.user,
        size: radius,
        color: context.colorScheme.mutedForeground,
      ),
    );
  }
}
