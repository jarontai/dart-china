part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationOpen extends NotificationEvent {}

class NotificationFetch extends NotificationEvent {
  final String username;
  final bool refresh;
  NotificationFetch({
    required this.username,
    this.refresh = false,
  });

  
}

class NotificationRead extends NotificationEvent {}
