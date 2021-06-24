import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dart_china/models/models.dart' as models;
import 'package:dart_china/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(this._userRepository) : super(NotificationInitial());

  final UserRepository _userRepository;

  @override
  Stream<Transition<NotificationEvent, NotificationState>> transformEvents(
      Stream<NotificationEvent> events,
      TransitionFunction<NotificationEvent, NotificationState> transitionFn) {
    return super.transformEvents(
        events.debounceTime(Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is NotificationOpen) {
      emit(NotificationInitial());
    } else if (event is NotificationFetch) {
      _fetch(event.username, refresh: event.refresh);
    } else if (event is NotificationRead) {
      // TODO:
    }
  }

  void _fetch(String username, {bool refresh = false}) async {
    var page = 0;

    final myState = state;
    if (refresh) {
      page = 0;
      emit(NotificationLoading());
    }

    final oldNotifications = <models.Notification>[];
    if (myState is NotificationSuccess) {
      if (!myState.more) {
        return;
      }
      page = myState.page + 1;
      oldNotifications.addAll(myState.notifications);
      emit(myState.copyWith(
        paging: true,
      ));
    }

    final pageModel = await _userRepository.notifications(username, page: page);
    emit(NotificationSuccess(
      page: page,
      more: pageModel.hasNext,
      notifications: List.of(oldNotifications)..addAll(pageModel.data),
      paging: false,
    ));
  }

  Future<bool> hasNotification(String username) {
    return _userRepository.hasNotification(username);
  }

  Future<bool> readNotification(String username, int id) {
    return _userRepository.readNotification(username, id);
  }
}
