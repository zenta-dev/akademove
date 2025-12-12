part of '_export.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.notifications = const OperationResult.idle(),
    this.unreadCount = const OperationResult.idle(),
  });

  final OperationResult<NotificationListData> notifications;
  final OperationResult<int> unreadCount;

  @override
  List<Object?> get props => [notifications, unreadCount];

  NotificationState copyWith({
    OperationResult<NotificationListData>? notifications,
    OperationResult<int>? unreadCount,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  bool get stringify => true;
}

/// Data class to hold notification list with pagination info
class NotificationListData extends Equatable {
  const NotificationListData({
    required this.items,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
    this.isLoadingMore = false,
  });

  final List<NotificationList200ResponseDataInner> items;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final bool isLoadingMore;

  @override
  List<Object?> get props => [
    items,
    currentPage,
    totalPages,
    totalCount,
    isLoadingMore,
  ];

  NotificationListData copyWith({
    List<NotificationList200ResponseDataInner>? items,
    int? currentPage,
    int? totalPages,
    int? totalCount,
    bool? isLoadingMore,
  }) {
    return NotificationListData(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalCount: totalCount ?? this.totalCount,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
