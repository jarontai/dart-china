import 'dart:async';
import 'dart:io';

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

      jpush.setup(
        appKey: "7096370dad448d28104d21f7", //你自己应用的 AppKey
        channel: "default",
        production: false,
        debug: true,
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
    }
  }
}
