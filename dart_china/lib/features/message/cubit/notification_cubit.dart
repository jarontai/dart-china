import 'package:bloc/bloc.dart';
import 'package:dart_china/models/models.dart';
import 'package:dart_china/repositories/repositories.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.userRepository) : super(NotificationInitial());

  final UserRepository userRepository;

  void fetch(String username, {bool refresh = false}) async {
    var page = 0;
    final myState = state;

    if (refresh) {
      page = 0;
      emit(NotificationLoading());
    } else if (myState is NotificationSuccess) {
      if (!myState.more) {
        return;
      }
      page = myState.page + 1;
      emit(myState.copyWith(
        paging: true,
      ));
    }

    final pageModel = await userRepository.notifications(username, page: page);
    emit(NotificationSuccess(
      page: page,
      more: pageModel.hasNext,
      notifications: pageModel.data,
    ));
  }

  Future<bool> hasNotification(String username) {
    return userRepository.hasNotification(username);
  }

  Future<bool> readNotification(String username, int id) {
    return userRepository.readNotification(username, id);
  }
}
