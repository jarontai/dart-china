part of 'notification_cubit.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  NotificationSuccess({
    required this.notifications,
    this.page = 0,
    this.more = false,
    this.paging = false,
  });

  final List<Notification> notifications;
  final int page;
  final bool more;
  final bool paging;

  NotificationSuccess copyWith({
    List<Notification>? notifications,
    int? page,
    bool? more,
    bool? paging,
  }) {
    return NotificationSuccess(
      notifications: notifications ?? this.notifications,
      page: page ?? this.page,
      more: more ?? this.more,
      paging: paging ?? this.paging,
    );
  }
}
