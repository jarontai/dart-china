import 'package:bloc/bloc.dart';
import 'package:dart_china/features/features.dart';
import 'package:dart_china/models/models.dart';
import 'package:dart_china/repositories/repositories.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.authRepository) : super(NotificationInitial());

  final UserRepository authRepository;

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

    final pageModel = await authRepository.notifications(username, page: page);
    emit(NotificationSuccess(
      page: page,
      more: pageModel.hasNext,
      notifications: pageModel.data,
    ));
  }
}
