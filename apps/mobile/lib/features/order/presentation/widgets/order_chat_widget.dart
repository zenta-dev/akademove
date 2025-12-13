import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class OrderChatWidget extends StatefulWidget {
  const OrderChatWidget({required this.orderId, super.key});

  final String orderId;

  @override
  State<OrderChatWidget> createState() => _OrderChatWidgetState();
}

class _OrderChatWidgetState extends State<OrderChatWidget> {
  late SharedOrderChatCubit _cubit;
  late SharedQuickMessageCubit _quickMessageCubit;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SharedOrderChatCubit>();
    _quickMessageCubit = context.read<SharedQuickMessageCubit>();
    _cubit.init(widget.orderId);
    _scrollController.addListener(_onScroll);

    // Fetch quick message templates for current user's role
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final currentUser = context.read<AuthCubit>().state.user.data?.value;
        if (currentUser != null) {
          final appLocalizations = context.l10n;
          final locale = appLocalizations.localeName.split('_').first;
          _quickMessageCubit.fetchTemplates(
            role: currentUser.role.value,
            locale: locale,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      _cubit.loadMoreMessages();
    }
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      _cubit.sendMessage(message);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<SharedOrderChatCubit, SharedOrderChatState>(
              builder: (context, state) {
                if (state.messages.isIdle || state.messages.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.messages.isFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: ${state.messages.error?.message ?? "Unknown error"}',
                        ),
                        SizedBox(height: 16.h),
                        PrimaryButton(
                          onPressed: () => _cubit.loadMessages(),
                          child: Text(context.l10n.retry),
                        ),
                      ],
                    ),
                  );
                }

                final messages = state.messages.value ?? [];
                if (messages.isEmpty) {
                  return Center(child: Text(context.l10n.chat_no_messages));
                }

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return _ChatMessageBubble(message: msg);
                  },
                );
              },
            ),
          ),
          const Divider(),
          BlocProvider.value(
            value: _quickMessageCubit,
            child: _QuickMessageChips(
              onMessageSelected: (message) {
                _messageController.text = message;
              },
            ),
          ),
          _MessageInputField(
            controller: _messageController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class _ChatMessageBubble extends StatelessWidget {
  const _ChatMessageBubble({required this.message});

  final OrderChatMessage message;

  String _getRoleDisplayName(BuildContext context, ChatSenderRole? role) {
    if (role == null) return "";
    switch (role) {
      case ChatSenderRole.USER:
        return context.l10n.user_role;
      case ChatSenderRole.DRIVER:
        return context.l10n.driver_role;
      case ChatSenderRole.MERCHANT:
        return context.l10n.merchant_role;
    }
  }

  Color _getRoleBadgeColor(BuildContext context, ChatSenderRole? role) {
    if (role == null) return context.colorScheme.muted;
    switch (role) {
      case ChatSenderRole.USER:
        return context.colorScheme.primary.withValues(alpha: 0.2);
      case ChatSenderRole.DRIVER:
        return Colors.green.withValues(alpha: 0.2);
      case ChatSenderRole.MERCHANT:
        return Colors.orange.withValues(alpha: 0.2);
    }
  }

  Color _getRoleTextColor(BuildContext context, ChatSenderRole? role) {
    if (role == null) return context.colorScheme.foreground;
    switch (role) {
      case ChatSenderRole.USER:
        return context.colorScheme.primary;
      case ChatSenderRole.DRIVER:
        return Colors.green;
      case ChatSenderRole.MERCHANT:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine if message is from current user
    final currentUser = context.select<AuthCubit, User?>(
      (cubit) => cubit.state.user.data?.value,
    );
    final isCurrentUser = currentUser?.id == message.senderId;
    final senderName = message.sender?.name ?? 'Unknown';
    final senderRole = message.sender?.role;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  senderName,
                  style: context.typography.small.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (senderRole != null) ...[
                  SizedBox(width: 6.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getRoleBadgeColor(context, senderRole),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      _getRoleDisplayName(context, senderRole),
                      style: context.typography.xSmall.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: _getRoleTextColor(context, senderRole),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? context.colorScheme.primary
                  : context.colorScheme.muted,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              message.message,
              style: TextStyle(
                color: isCurrentUser
                    ? context.colorScheme.primaryForeground
                    : context.colorScheme.foreground,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            _formatTimestamp(context, message.sentAt),
            style: context.typography.small.copyWith(
              color: context.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(BuildContext context, DateTime timestamp) {
    // Convert UTC timestamp to local time for comparison
    final localTimestamp = timestamp.toLocal();
    final now = DateTime.now();
    final difference = now.difference(localTimestamp);

    if (difference.inDays > 0) {
      return context.l10n.chat_time_days_ago(difference.inDays);
    } else if (difference.inHours > 0) {
      return context.l10n.chat_time_hours_ago(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return context.l10n.chat_time_minutes_ago(difference.inMinutes);
    } else {
      return context.l10n.chat_time_just_now;
    }
  }
}

class _QuickMessageChips extends StatelessWidget {
  const _QuickMessageChips({required this.onMessageSelected});

  final ValueChanged<String> onMessageSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      SharedQuickMessageCubit,
      OperationResult<List<QuickMessageTemplate>>
    >(
      builder: (context, state) {
        final templates = state.value;
        if (!state.isSuccess || templates == null || templates.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          color: context.colorScheme.muted,
          height: 50.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: templates.length,
            separatorBuilder: (context, index) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final template = templates[index];
              return Chip(
                onPressed: () => onMessageSelected(template.message),
                style: const ButtonStyle.outline(),
                child: Text(template.message),
              );
            },
          ),
        );
      },
    );
  }
}

class _MessageInputField extends StatelessWidget {
  const _MessageInputField({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      color: context.colorScheme.background,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              placeholder: Text(context.l10n.placeholder_type_message),
              maxLines: null,
              onSubmitted: (_) => onSend(),
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            onPressed: onSend,
            icon: const Icon(LucideIcons.send),
            variance: const ButtonStyle.ghost(),
          ),
        ],
      ),
    );
  }
}
