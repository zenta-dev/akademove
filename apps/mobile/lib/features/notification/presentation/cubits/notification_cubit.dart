import 'package:akademove/core/_export.dart';
import 'package:akademove/features/notification/data/models/notification_models.dart';
import 'package:akademove/features/notification/data/repositories/notification_repository.dart';
import 'package:akademove/features/notification/presentation/states/_export.dart';

class NotificationCubit extends BaseCubit<NotificationState> {
  NotificationCubit({required NotificationRepository notificationRepository})
    : _notificationRepository = notificationRepository,
      super(const NotificationState());

  final NotificationRepository _notificationRepository;

  /// Get notifications for the current page
  Future<void> getNotifications({int page = 1, bool refresh = false}) async {
    await taskManager.execute('NC-getNotifications', () async {
      try {
        if (refresh) {
          emit(state.copyWith(notifications: const OperationResult.loading()));
        }

        final response = await _notificationRepository.getNotifications(
          page: page,
        );

        final (notifications, totalPages) = response.data;
        emit(
          state.copyWith(
            notifications: OperationResult.success(
              NotificationListData(
                items: notifications,
                currentPage: page,
                totalPages: totalPages,
                totalCount: notifications.length,
              ),
              message: response.message,
            ),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e('Failed to get notifications', error: e, stackTrace: st);
        emit(state.copyWith(notifications: OperationResult.failed(e)));
      }
    });
  }

  /// Load more notifications (pagination)
  Future<void> loadMoreNotifications() async {
    final currentData = state.notifications.value;
    if (currentData == null) return;
    if (currentData.isLoadingMore ||
        currentData.currentPage >= currentData.totalPages) {
      return;
    }

    // Set loading more flag
    emit(
      state.copyWith(
        notifications: OperationResult.success(
          currentData.copyWith(isLoadingMore: true),
        ),
      ),
    );

    await taskManager.execute('NC-loadMoreNotifications', () async {
      try {
        final nextPage = currentData.currentPage + 1;
        final response = await _notificationRepository.getNotifications(
          page: nextPage,
        );

        final (notifications, totalPages) = response.data;
        final updatedItems = [...currentData.items, ...notifications];

        emit(
          state.copyWith(
            notifications: OperationResult.success(
              NotificationListData(
                items: updatedItems,
                currentPage: nextPage,
                totalPages: totalPages,
                totalCount: updatedItems.length,
                isLoadingMore: false,
              ),
            ),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e('Failed to load more notifications', error: e, stackTrace: st);
        // Reset loading more flag on error
        emit(
          state.copyWith(
            notifications: OperationResult.success(
              currentData.copyWith(isLoadingMore: false),
            ),
          ),
        );
      }
    });
  }

  /// Get unread notification count
  Future<void> getUnreadCount() async {
    await taskManager.execute('NC-getUnreadCount', () async {
      try {
        final response = await _notificationRepository.getUnreadCount();
        emit(
          state.copyWith(
            unreadCount: OperationResult.success(
              response.data,
              message: response.message,
            ),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e('Failed to get unread count', error: e, stackTrace: st);
        emit(state.copyWith(unreadCount: OperationResult.failed(e)));
      }
    });
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    await taskManager.execute('NC-markAsRead-$notificationId', () async {
      try {
        await _notificationRepository.markAsRead(notificationId);

        final currentData = state.notifications.value;
        if (currentData == null) return;

        // Update the notification in local state
        final updatedItems = currentData.items.map((notification) {
          if (notification.id == notificationId) {
            return notification.copyWithUpdated(
              isRead: true,
              readAt: DateTime.now(),
            );
          }
          return notification;
        }).toList();

        final currentUnread = state.unreadCount.value ?? 0;
        final newUnreadCount = currentUnread > 0 ? currentUnread - 1 : 0;

        emit(
          state.copyWith(
            notifications: OperationResult.success(
              currentData.copyWith(items: updatedItems),
            ),
            unreadCount: OperationResult.success(newUnreadCount),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          'Failed to mark notification as read',
          error: e,
          stackTrace: st,
        );
      }
    });
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    await taskManager.execute('NC-markAllAsRead', () async {
      try {
        await _notificationRepository.markAllAsRead();

        final currentData = state.notifications.value;
        if (currentData == null) return;

        // Update all notifications to read
        final updatedItems = currentData.items.map((notification) {
          return notification.copyWithUpdated(
            isRead: true,
            readAt: DateTime.now(),
          );
        }).toList();

        emit(
          state.copyWith(
            notifications: OperationResult.success(
              currentData.copyWith(items: updatedItems),
            ),
            unreadCount: OperationResult.success(0),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          'Failed to mark all notifications as read',
          error: e,
          stackTrace: st,
        );
      }
    });
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    await taskManager.execute(
      'NC-deleteNotification-$notificationId',
      () async {
        try {
          await _notificationRepository.deleteNotification(notificationId);

          final currentData = state.notifications.value;
          if (currentData == null) return;

          final notificationToDelete = currentData.items
              .where((n) => n.id == notificationId)
              .firstOrNull;

          final updatedItems = currentData.items
              .where((n) => n.id != notificationId)
              .toList();

          final newTotalCount = currentData.totalCount > 0
              ? currentData.totalCount - 1
              : 0;

          if (notificationToDelete != null && !notificationToDelete.isRead) {
            // Decrease unread count if deleted notification was unread
            final currentUnread = state.unreadCount.value ?? 0;
            final newUnreadCount = currentUnread > 0 ? currentUnread - 1 : 0;
            emit(
              state.copyWith(
                notifications: OperationResult.success(
                  currentData.copyWith(
                    items: updatedItems,
                    totalCount: newTotalCount,
                  ),
                ),
                unreadCount: OperationResult.success(newUnreadCount),
              ),
            );
          } else {
            emit(
              state.copyWith(
                notifications: OperationResult.success(
                  currentData.copyWith(
                    items: updatedItems,
                    totalCount: newTotalCount,
                  ),
                ),
              ),
            );
          }
        } on BaseError catch (e, st) {
          logger.e('Failed to delete notification', error: e, stackTrace: st);
        }
      },
    );
  }

  /// Refresh notifications
  Future<void> refreshNotifications() async {
    await getNotifications(page: 1, refresh: true);
    await getUnreadCount();
  }

  /// Reset state
  void reset() {
    emit(const NotificationState());
  }
}
