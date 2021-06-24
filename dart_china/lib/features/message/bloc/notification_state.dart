part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<models.Notification> notifications;
  final int page;
  final bool more;
  final bool paging;

  NotificationSuccess({
    required this.notifications,
    required this.page,
    required this.more,
    required this.paging,
  });

  NotificationSuccess copyWith({
    List<models.Notification>? notifications,
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

class NotificationFailure extends NotificationState {}
