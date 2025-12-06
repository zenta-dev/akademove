import 'package:akademove/core/_export.dart';
import 'package:akademove/features/notification/data/repositories/notification_repository.dart';
import 'package:akademove/features/notification/presentation/states/_export.dart';

class NotificationCubit extends BaseCubit<NotificationState> {
  NotificationCubit({required NotificationRepository notificationRepository})
    : _notificationRepository = notificationRepository,
      super(NotificationState());

  final NotificationRepository _notificationRepository;

  /// Get notifications for the current page
  Future<void> getNotifications({int page = 1, bool refresh = false}) async {
    if (refresh) {
      emit(state.toLoading());
    }

    try {
      await taskManager.execute('NC-getNotifications', () async {
        final response = await _notificationRepository.getNotifications(
          page: page,
        );

        final notificationData = response.data;
        emit(
          state.toSuccess(
            notifications: notificationData.notifications,
            currentPage: notificationData.page,
            totalPages: (notificationData.total / notificationData.limit)
                .ceil(),
            totalCount: notificationData.total,
            message: response.message,
          ),
        );
      });
    } catch (e, st) {
      logger.e('Failed to get notifications', error: e, stackTrace: st);
      emit(
        state.toFailure(
          RepositoryError(e.toString(), code: ErrorCode.unknown),
          message: 'Failed to load notifications',
        ),
      );
    }
  }

  /// Load more notifications (pagination)
  Future<void> loadMoreNotifications() async {
    if (state.isLoadingMore || state.currentPage >= state.totalPages) return;

    emit(state.toLoadingMore());

    try {
      await taskManager.execute('NC-loadMoreNotifications', () async {
        final nextPage = state.currentPage + 1;
        final response = await _notificationRepository.getNotifications(
          page: nextPage,
        );

        final notificationData = response.data;
        final updatedNotifications = [
          ...state.notifications,
          ...notificationData.notifications,
        ];

        emit(
          state.toLoadedMore(
            notifications: updatedNotifications,
            currentPage: notificationData.page,
            totalPages: (notificationData.total / notificationData.limit)
                .ceil(),
            totalCount: notificationData.total,
          ),
        );
      });
    } catch (e, st) {
      logger.e('Failed to load more notifications', error: e, stackTrace: st);
      emit(
        state.toFailure(
          RepositoryError(e.toString(), code: ErrorCode.unknown),
          message: 'Failed to load more notifications',
        ),
      );
    }
  }

  /// Get unread notification count
  Future<void> getUnreadCount() async {
    try {
      await taskManager.execute('NC-getUnreadCount', () async {
        final response = await _notificationRepository.getUnreadCount();
        emit(state.withUpdatedUnreadCount(response.data));
      });
    } catch (e, st) {
      logger.e('Failed to get unread count', error: e, stackTrace: st);
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await taskManager.execute('NC-markAsRead', () async {
        await _notificationRepository.markAsRead(notificationId);

        // Update the notification in local state
        final updatedNotifications = state.notifications.map((notification) {
          if (notification.id == notificationId) {
            return notification.copyWith(isRead: true, readAt: DateTime.now());
          }
          return notification;
        }).toList();

        final newUnreadCount = state.unreadCount > 0
            ? state.unreadCount - 1
            : 0;

        emit(
          state.copyWith(
            notifications: updatedNotifications,
            unreadCount: newUnreadCount,
          ),
        );
      });
    } catch (e, st) {
      logger.e('Failed to mark notification as read', error: e, stackTrace: st);
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      await taskManager.execute('NC-markAllAsRead', () async {
        await _notificationRepository.markAllAsRead();

        // Update all notifications to read
        final updatedNotifications = state.notifications.map((notification) {
          return notification.copyWith(isRead: true, readAt: DateTime.now());
        }).toList();

        emit(
          state.copyWith(notifications: updatedNotifications, unreadCount: 0),
        );
      });
    } catch (e, st) {
      logger.e(
        'Failed to mark all notifications as read',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await taskManager.execute('NC-deleteNotification', () async {
        await _notificationRepository.deleteNotification(notificationId);

        final notificationToDelete = state.notifications
            .where((n) => n.id == notificationId)
            .firstOrNull;

        if (notificationToDelete != null && !notificationToDelete.isRead) {
          // Decrease unread count if deleted notification was unread
          final newUnreadCount = state.unreadCount > 0
              ? state.unreadCount - 1
              : 0;
          emit(
            state
                .withRemovedNotification(notificationId)
                .copyWith(unreadCount: newUnreadCount),
          );
        } else {
          emit(state.withRemovedNotification(notificationId));
        }
      });
    } catch (e, st) {
      logger.e('Failed to delete notification', error: e, stackTrace: st);
    }
  }

  /// Refresh notifications
  Future<void> refreshNotifications() async {
    await getNotifications(page: 1, refresh: true);
    await getUnreadCount();
  }

  /// Reset state
  void reset() {
    emit(NotificationState());
  }
}
