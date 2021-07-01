part of 'notification_bloc.dart';

enum NotificationStatus { initial, loading, success, failure }

extension NotificationStatusX on NotificationStatus {
  bool get isInitial => this == NotificationStatus.initial;
  bool get isLoading => this == NotificationStatus.loading;
  bool get isSuccess => this == NotificationStatus.success;
  bool get isFailure => this == NotificationStatus.failure;
}

class NotificationState extends Equatable {
  final NotificationStatus status;
  final List<models.Notification> notifications;
  final int page;
  final bool hasMore;

  NotificationState({
    this.status = NotificationStatus.initial,
    this.notifications = const [],
    this.page = -1,
    this.hasMore = true,
  });

  NotificationState copyWith({
    NotificationStatus? status,
    List<models.Notification>? notifications,
    int? page,
    bool? hasMore,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [status, notifications, page, hasMore];
}
