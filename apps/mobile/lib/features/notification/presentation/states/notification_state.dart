part of '_export.dart';

class NotificationState {
  NotificationState({
    this.notifications = const [],
    this.unreadCount = 0,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
    this.isLoadingMore = false,
    this.state = CubitState.initial,
    this.message,
    this.error,
  });

  final List<NotificationModel> notifications;
  final int unreadCount;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final bool isLoadingMore;
  final CubitState state;
  final String? message;
  final BaseError? error;

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    int? unreadCount,
    int? currentPage,
    int? totalPages,
    int? totalCount,
    bool? isLoadingMore,
    CubitState? state,
    String? message,
    BaseError? error,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalCount: totalCount ?? this.totalCount,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      state: state ?? this.state,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  NotificationState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  NotificationState toLoading() =>
      copyWith(state: CubitState.loading, message: null, error: null);

  NotificationState toSuccess({
    List<NotificationModel>? notifications,
    int? unreadCount,
    int? currentPage,
    int? totalPages,
    int? totalCount,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    notifications: notifications ?? this.notifications,
    unreadCount: unreadCount ?? this.unreadCount,
    currentPage: currentPage ?? this.currentPage,
    totalPages: totalPages ?? this.totalPages,
    totalCount: totalCount ?? this.totalCount,
    message: message,
    error: null,
  );

  NotificationState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);

  NotificationState toLoadingMore() => copyWith(isLoadingMore: true);

  NotificationState toLoadedMore({
    List<NotificationModel>? notifications,
    int? currentPage,
    int? totalPages,
    int? totalCount,
  }) => copyWith(
    notifications: notifications ?? this.notifications,
    currentPage: currentPage ?? this.currentPage,
    totalPages: totalPages ?? this.totalPages,
    totalCount: totalCount ?? this.totalCount,
    isLoadingMore: false,
  );

  NotificationState withUpdatedNotification(
    NotificationModel updatedNotification,
  ) {
    final index = notifications.indexWhere(
      (n) => n.id == updatedNotification.id,
    );
    if (index == -1) return this;

    final updatedList = List<NotificationModel>.from(notifications);
    updatedList[index] = updatedNotification;

    return copyWith(notifications: updatedList);
  }

  NotificationState withRemovedNotification(String notificationId) {
    final updatedList = notifications
        .where((n) => n.id != notificationId)
        .toList();
    return copyWith(
      notifications: updatedList,
      totalCount: totalCount > 0 ? totalCount - 1 : 0,
    );
  }

  NotificationState withUpdatedUnreadCount(int unreadCount) =>
      copyWith(unreadCount: unreadCount);
}
