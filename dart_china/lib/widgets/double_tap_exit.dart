import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DoubleTapExit extends StatefulWidget {
  DoubleTapExit(
    this.text, {
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final String text;

  @override
  _DoubleTapExitState createState() => _DoubleTapExitState();
}

class _DoubleTapExitState extends State<DoubleTapExit> {
  bool isTimerRunning = false;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return WillPopScope(
        child: widget.child,
        onWillPop: () async {
          if (!isTimerRunning) {
            setState(() {
              isTimerRunning = true;
            });
            timer = Timer(widget.duration, () {
              setState(() {
                isTimerRunning = false;
              });
            });
            EasyLoading.showToast(
              widget.text,
              duration: widget.duration,
              toastPosition: EasyLoadingToastPosition.bottom,
            );
            return false;
          } else {
            return true;
          }
        },
      );
    }
    return widget.child;
  }
}
