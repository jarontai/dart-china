import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutState());

  @override
  Stream<AboutState> mapEventToState(
    AboutEvent event,
  ) async* {
    if (event is AboutInit) {
      yield await _init();
    }
  }

  Future<AboutState> _init() async {
    final info = await PackageInfo.fromPlatform();
    return state.copyWith(
      appVersion: info.version,
      buildNumber: info.buildNumber,
    );
  }
}
