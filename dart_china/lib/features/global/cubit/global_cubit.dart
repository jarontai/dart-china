import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/models.dart';
import '../../login/cubit/login_cubit.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  final LoginCubit loginCubit;
  StreamSubscription? authSubscription;

  GlobalCubit(this.loginCubit) : super(GlobalState()) {
    authSubscription = loginCubit.stream.listen((authState) {
      if (authState.isLogin && authState.user != null) {
        updateLogin(true, authState.user);
      } else {
        updateLogin(false, null);
      }
    });

    checkLogin();
  }

  checkLogin() async {
    await loginCubit.check();
  }

  updateLogin(bool status, User? user) {
    print('App state login change: $status');
    emit(state.copyWith(userLogin: status, user: user));
  }

  @override
  Future<void> close() {
    authSubscription?.cancel();
    return super.close();
  }

  signOut() async {
    var dir = await getApplicationDocumentsDirectory();
    var folder = Directory(dir.path + '/.cookies');
    var list = folder.listSync();
    for (var item in list) {
      await item.delete(recursive: true);
    }
    updateLogin(false, null);
  }
}
