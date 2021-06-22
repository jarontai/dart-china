part of 'notification_cubit.dart';

enum NotificationStatus { initial, success, paging, failure }

extension NotificationStatusX on NotificationStatus {
  bool get isInitial => this == NotificationStatus.initial;
  bool get isSuccess => this == NotificationStatus.success;
  bool get isPaging => this == NotificationStatus.paging;
  bool get isFailure => this == NotificationStatus.failure;
}

class NotificationState extends Equatable {
  NotificationState({
    this.status = NotificationStatus.initial,
    this.notifications = const <Notification>[],
    this.page = 0,
    this.more = false,
  });

  final NotificationStatus status;
  final List<Notification> notifications;
  final int page;
  final bool more;

  NotificationState copyWith({
    NotificationStatus? status,
    List<Notification>? notifications,
    int? page,
    bool? more,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      page: page ?? this.page,
      more: more ?? this.more,
    );
  }

  @override
  List<Object?> get props => [status, notifications, page, more];
}
