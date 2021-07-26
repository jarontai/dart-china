import 'dart:async';
import 'dart:io';

import 'package:dart_china/common.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'push_event.dart';
part 'push_state.dart';

class PushBloc extends Bloc<PushEvent, PushState> {
  PushBloc() : super(PushState());

  final JPush jpush = JPush();

  @override
  Stream<PushState> mapEventToState(
    PushEvent event,
  ) async* {
    if (event is PushInitEvent) {
      if (!Platform.isAndroid && !Platform.isIOS) {
        return;
      }

      print('--- Start JPush config ---');

      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print("JPush: flutter onReceiveNotification: $message");
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print("JPush: flutter onOpenNotification: $message");
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("JPush: flutter onReceiveMessage: $message");
      }, onReceiveNotificationAuthorization:
              (Map<String, dynamic> message) async {
        print("JPush: flutter onReceiveNotificationAuthorization: $message");
      });

      final appConfig = getIt.get<AppConfig>();
      var debug = true;
      var production = false;
      if (appConfig.isProd) {
        production = true;
        debug = false;
      }

      jpush.setup(
        appKey: appConfig.jpushAppkey, //你自己应用的 AppKey
        channel: "default",
        production: production,
        debug: debug,
      );

      try {
        jpush.getRegistrationID().then((rid) {
          print("JPush: flutter get registration id : $rid");
        });
      } catch (e) {
        print("JPush: flutter get registration error - $e");
      }

      if (Platform.isIOS) {
        jpush.applyPushAuthority(
            new NotificationSettingsIOS(sound: true, alert: true, badge: true));
      }

      print('--- Finish JPush config ---');
    }
  }
}
