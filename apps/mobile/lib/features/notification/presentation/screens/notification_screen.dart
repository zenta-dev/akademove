import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationCubit _cubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = sl<NotificationCubit>();
    _cubit.refreshNotifications();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      _cubit.loadMoreNotifications();
    }
  }

  Future<void> _onRefresh() async {
    await _cubit.refreshNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          leading: [
            IconButton(
              icon: const Icon(LucideIcons.arrowLeft),
              variance: ButtonVariance.ghost,
              onPressed: () => context.pop(),
            ),
          ],
          title: Text(context.l10n.notifications),
          trailing: [
            BlocBuilder<NotificationCubit, NotificationState>(
              bloc: _cubit,
              builder: (context, state) {
                final items = state.notifications.value?.items ?? [];
                final hasUnread = items.any((n) => !n.isRead);
                if (!hasUnread) return const SizedBox.shrink();

                return IconButton(
                  icon: const Icon(LucideIcons.checkCheck),
                  variance: ButtonVariance.ghost,
                  onPressed: () => _cubit.markAllAsRead(),
                );
              },
            ),
          ],
        ),
      ],
      scrollable: false,
      body: BlocProvider.value(
        value: _cubit,
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            final notificationData = state.notifications.value;
            final items = notificationData?.items ?? [];

            if (state.notifications.isLoading && items.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.notifications.isFailure && items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16.h,
                  children: [
                    Icon(
                      LucideIcons.circleAlert,
                      size: 48.sp,
                      color: context.colorScheme.destructive,
                    ),
                    Text(
                      state.notifications.error?.message ??
                          context.l10n.failed_to_load,
                      style: context.typography.small,
                      textAlign: TextAlign.center,
                    ),
                    PrimaryButton(
                      onPressed: _onRefresh,
                      child: Text(context.l10n.retry),
                    ),
                  ],
                ),
              );
            }

            if (items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16.h,
                  children: [
                    Icon(
                      LucideIcons.bellOff,
                      size: 48.sp,
                      color: context.colorScheme.muted,
                    ),
                    Text(
                      context.l10n.no_notifications,
                      style: context.typography.small,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            final currentPage = notificationData?.currentPage ?? 1;
            final totalPages = notificationData?.totalPages ?? 1;
            final hasMore = currentPage < totalPages;

            return RefreshTrigger(
              onRefresh: _onRefresh,
              child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                itemCount: items.length + (hasMore ? 1 : 0),
                separatorBuilder: (context, index) => Gap(16.h),
                itemBuilder: (context, index) {
                  if (index >= items.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }

                  final notification = items[index];
                  return NotificationListItem(
                    notification: notification,
                    onTap: () => _onNotificationTap(notification),
                    onDismiss: () => _cubit.deleteNotification(notification.id),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNotificationTap(NotificationModel notification) {
    // Mark as read if not already
    if (!notification.isRead) {
      _cubit.markAsRead(notification.id);
    }

    // Navigate based on notification data
    final route = notification.route;
    if (route != null && route.isNotEmpty) {
      context.push(route);
    }
  }
}
