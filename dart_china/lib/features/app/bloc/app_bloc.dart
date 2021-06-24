import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_china/features/features.dart';
import 'package:dart_china/models/models.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState());

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
