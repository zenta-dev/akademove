import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A chat button that shows a badge with the unread message count.
///
/// This widget creates and manages its own [SharedOrderChatCubit] for tracking
/// unread messages. When pressed, it calls the [onPressed] callback.
///
/// Example usage:
/// ```dart
/// ChatButtonWithBadge(
///   orderId: order.id,
///   onPressed: () => _showChatDialog(context),
/// )
/// ```
class ChatButtonWithBadge extends StatefulWidget {
  const ChatButtonWithBadge({
    required this.orderId,
    required this.onPressed,
    this.iconSize,
    this.badgeColor,
    this.variance = ButtonVariance.ghost,
    super.key,
  });

  /// The order ID to track unread messages for.
  final String orderId;

  /// Callback when the button is pressed.
  final VoidCallback onPressed;

  /// Optional icon size (defaults to theme default).
  final double? iconSize;

  /// Optional badge background color (defaults to destructive color).
  final Color? badgeColor;

  /// Button variance style.
  final AbstractButtonStyle variance;

  @override
  State<ChatButtonWithBadge> createState() => _ChatButtonWithBadgeState();
}

class _ChatButtonWithBadgeState extends State<ChatButtonWithBadge> {
  late SharedOrderChatCubit _chatCubit;
  bool _isOwnCubit = false;

  @override
  void initState() {
    super.initState();
    _initCubit();
  }

  void _initCubit() {
    // Try to use existing cubit from context, otherwise create our own
    try {
      _chatCubit = context.read<SharedOrderChatCubit>();
      _isOwnCubit = false;

      // If cubit exists but hasn't been initialized for this order,
      // initialize it for unread count only
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _chatCubit.initUnreadCountOnly(widget.orderId);
        }
      });
    } catch (_) {
      // No existing cubit, create our own
      _chatCubit = SharedOrderChatCubit(
        orderChatRepository: sl(),
        webSocketService: sl(),
      );
      _isOwnCubit = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _chatCubit.initUnreadCountOnly(widget.orderId);
        }
      });
    }
  }

  @override
  void didUpdateWidget(ChatButtonWithBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.orderId != widget.orderId) {
      _chatCubit.initUnreadCountOnly(widget.orderId);
    }
  }

  @override
  void dispose() {
    if (_isOwnCubit) {
      _chatCubit.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubitWidget = BlocBuilder<SharedOrderChatCubit, SharedOrderChatState>(
      bloc: _chatCubit,
      builder: (context, state) {
        final unreadCount = state.unreadCount.value ?? 0;
        return _ChatButton(
          onPressed: widget.onPressed,
          unreadCount: unreadCount,
          iconSize: widget.iconSize,
          badgeColor: widget.badgeColor,
          variance: widget.variance,
        );
      },
    );

    // If we're using an existing cubit, just return the widget
    // If we created our own, wrap it in a BlocProvider
    if (_isOwnCubit) {
      return BlocProvider.value(value: _chatCubit, child: cubitWidget);
    }
    return cubitWidget;
  }
}

class _ChatButton extends StatelessWidget {
  const _ChatButton({
    required this.onPressed,
    required this.unreadCount,
    this.iconSize,
    this.badgeColor,
    this.variance = ButtonVariance.ghost,
  });

  final VoidCallback onPressed;
  final int unreadCount;
  final double? iconSize;
  final Color? badgeColor;
  final AbstractButtonStyle variance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(LucideIcons.messageCircle, size: iconSize),
          onPressed: onPressed,
          variance: variance,
        ),
        if (unreadCount > 0)
          Positioned(
            right: -2.w,
            top: -2.h,
            child: _UnreadBadge(
              count: unreadCount,
              backgroundColor: badgeColor,
            ),
          ),
      ],
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count, this.backgroundColor});

  final int count;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final displayCount = count > 99 ? '99+' : count.toString();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: count > 9 ? 4.w : 6.w,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.destructive,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: context.colorScheme.background, width: 1.5),
      ),
      constraints: BoxConstraints(minWidth: 18.w, minHeight: 18.h),
      child: Center(
        child: Text(
          displayCount,
          style: context.typography.xSmall.copyWith(
            // Use white for destructive badge text
            color: Colors.white,
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
