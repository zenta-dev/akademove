import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
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
  late OrderChatCubit _cubit;
  late QuickMessageCubit _quickMessageCubit;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = sl<OrderChatCubit>();
    _quickMessageCubit = sl<QuickMessageCubit>();
    _cubit.init(widget.orderId);
    _scrollController.addListener(_onScroll);

    // Fetch quick message templates for current user's role
    final currentUser = sl<AuthCubit>().state.user.data?.value;
    if (currentUser != null) {
      // Get app locale from Flutter localization context
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          final appLocalizations = context.l10n;
          final locale = appLocalizations.localeName.split('_').first;
          _quickMessageCubit.fetchTemplates(
            role: currentUser.role.value,
            locale: locale,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _cubit.close();
    _quickMessageCubit.close();
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
            child: BlocBuilder<OrderChatCubit, OrderChatState>(
              builder: (context, state) {
                if (state.isInitial || state.messages.isLoading) {
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
                  itemCount: messages.length + (state.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == messages.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
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

  @override
  Widget build(BuildContext context) {
    // Determine if message is from current user
    final currentUser = context.select<AuthCubit, User?>(
      (cubit) => cubit.state.user.data?.value,
    );
    final isCurrentUser = currentUser?.id == message.senderId;
    final senderName = message.sender?.name ?? 'Unknown';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser)
            Text(
              senderName,
              style: context.typography.small.copyWith(
                fontWeight: FontWeight.bold,
              ),
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
            _formatTimestamp(message.sentAt),
            style: context.typography.small.copyWith(
              color: context.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class _QuickMessageChips extends StatelessWidget {
  const _QuickMessageChips({required this.onMessageSelected});

  final ValueChanged<String> onMessageSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      QuickMessageCubit,
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
