import 'package:bloc/bloc.dart';
import '../../../models/models.dart';
import '../../../repositories/repositories.dart';
import 'package:equatable/equatable.dart';

import '../../../util.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.userRepository) : super(NotificationState());

  final UserRepository userRepository;
  final Debouncer _debouncer = Debouncer();

  void fetch(String username, {bool refresh = false}) async {
    _debouncer.run(() async {
      _fetch(username, refresh: refresh);
    });
  }

  void _fetch(String username, {bool refresh = false}) async {
    var page = 0;

    if (refresh) {
      page = 0;
      emit(NotificationState());
    } else if (state.status.isSuccess) {
      if (!state.more) {
        return;
      }
      page = state.page + 1;
      emit(state.copyWith(
        status: NotificationStatus.paging,
      ));
    }

    final pageModel = await userRepository.notifications(username, page: page);
    emit(state.copyWith(
      status: NotificationStatus.success,
      page: page,
      more: pageModel.hasNext,
      notifications: List.of(state.notifications)..addAll(pageModel.data),
    ));
  }

  Future<bool> hasNotification(String username) {
    return userRepository.hasNotification(username);
  }

  Future<bool> readNotification(String username, int id) {
    return userRepository.readNotification(username, id);
  }
}
