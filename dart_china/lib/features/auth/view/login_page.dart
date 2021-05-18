import 'package:dart_china/commons.dart';
import 'package:dart_china/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static final String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPalette.backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              buildHead(),
              buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildForm() {
    return Expanded(
        flex: 7,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              InputWidget(
                label: '用户名',
              ),
              InputWidget(
                label: '密码',
              ),
            ],
          ),
        ));
  }

  Expanded buildHead() {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: Image.asset(
              'assets/icon/logo_dart.png',
              height: 45,
              width: 45,
            ),
          ),
          SizedBox(height: 40),
          Text(
            '欢迎回到 DartChina',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
