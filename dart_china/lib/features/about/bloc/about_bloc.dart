import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutInitial());

  @override
  Stream<AboutState> mapEventToState(
    AboutEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
