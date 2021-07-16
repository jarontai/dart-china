import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bugly_crash/bugly.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'bugly_event.dart';
part 'bugly_state.dart';

class BuglyBloc extends Bloc<BuglyEvent, BuglyState> {
  BuglyBloc() : super(BuglyState());

  @override
  Stream<BuglyState> mapEventToState(
    BuglyEvent event,
  ) async* {
    if (event is BuglyInit) {
      await _init(event.enableDebug, event.androidAppId, event.iosAppId);
    }
  }

  _init(bool enableDebug, String androidId, String iosId) async {
    if (Platform.isIOS) {
      print('--- Bugly is disabled in ios!!! ---');
      return;
    }

    var platformVersion = '';
    var connected = false;
    try {
      platformVersion = await Bugly.platformVersion;
      connected = true;
    } on PlatformException {
      connected = false;
      platformVersion = 'Failed to get platform version.';
    }

    if (connected) {
      if (Platform.isAndroid) {
        _initBuglyAndroid(androidId, enableDebug);
      }
    }

    emit(state.copyWith(
      platformVersion: platformVersion,
      connected: connected,
    ));
  }

  _initBuglyAndroid(String appId, bool enableDebug) async {
    final packageInfo = await PackageInfo.fromPlatform();

    //Bugly.setAndroidServerUrl(url: "https://xxxx");
    await Bugly.initAndroidCrashReport(appId: appId, isDebug: enableDebug);
    // Bugly.setUserId(userId: "androiduser");
    //如果遇到AndroidId采集隐私问题，可以参考https://github.com/BuglyDevTeam/Bugly-Android-Demo
    // Bugly.setAndroidDeviceId(deviceId: "test");
    // Bugly.setUserSceneTag(userSceneTag: 111437);
    await Bugly.setAppVersion(appVersion: packageInfo.version);
    // Bugly.setAndroidAppChannel(appChannel: "test");
    //bugly自定义日志,可在"跟踪日志"页面查看
    // BuglyLog.d(tag: "bugly", content: "debugvalue");
    // BuglyLog.i(tag: "bugly", content: "infovalue");
    // BuglyLog.v(tag: "bugly", content: "verbosevalue");
    // BuglyLog.w(tag: "bugly", content: "warnvalue");
    // BuglyLog.e(tag: "bugly", content: "errorvalue");
    //自定义map参数 可在"跟踪数据"页面查看
    // Bugly.putUserData(userKey: "userkey1", userValue: "uservalue1");
    // Bugly.putUserData(userKey: "userkey2", userValue: "uservalue2");
  }

  _initBuglyIos(String appId, bool enableDebug) async {
    final packageInfo = await PackageInfo.fromPlatform();

    //Bugly.initIosCrashReport(appId:"87654c7bfa",debugMode: true,serverUrl: "");
    await Bugly.initIosCrashReport(appId: appId, debugMode: enableDebug);
    // Bugly.setUserSceneTag(userSceneTag: 116852);
    await Bugly.setAppVersion(appVersion: packageInfo.version);
    // Bugly.putUserData(userKey: "userkey1", userValue: "uservalue1");
    // Bugly.setUserId(userId: "iosuser");
    // BuglyLog.d(tag: "bugly", content: "debugvalue");
    // BuglyLog.i(tag: "bugly", content: "infovalue");
    // BuglyLog.w(tag: "bugly", content: "warnvalue");
    // BuglyLog.v(tag: "bugly", content: "verbosevalue");
    // BuglyLog.e(tag: "bugly", content: "errorvalue");
  }
}
