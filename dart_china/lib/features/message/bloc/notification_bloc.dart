import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../models/models.dart' as models;
import '../../../repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(this._userRepository) : super(NotificationState());

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
    if (event is NotificationFetch) {
      _fetch(event.username, refresh: event.refresh);
    } else if (event is NotificationRead) {
      // TODO:
    }
  }

  void _fetch(String username, {bool refresh = false}) async {
    if (!state.hasMore) {
      return;
    }

    var page = state.page + 1;
    if (refresh) {
      page = 0;
      emit(state.copyWith(status: NotificationStatus.loading));
    }

    final pageModel = await _userRepository.notifications(username, page: page);
    emit(state.copyWith(
      status: NotificationStatus.success,
      page: page,
      hasMore: pageModel.hasNext,
      notifications: List.of(state.notifications)..addAll(pageModel.data),
    ));
  }

  Future<bool> hasNotification(String username) {
    return _userRepository.hasNotification(username);
  }

  Future<bool> readNotification(String username, int id) {
    return _userRepository.readNotification(username, id);
  }
}
